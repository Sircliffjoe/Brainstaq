class PresenceChannel < ApplicationCable::Channel

  def subscribed
    @brainstorm = Brainstorm.find_by(token: params[:token])
    stream_or_reject_for @brainstorm
    add_to_list_and_transmit!
  end

  def unsubscribed
    remove_from_list_and_transmit!
  end

  def update_name
    transmit_list!
  end

  private

  def add_to_list_and_transmit!
    set_random_name_if_user_has_no_name
    REDIS.set user_color_key, random_color_class
    REDIS.hset brainstorm_key, session_id, Time.now
    transmit_list!
  end

  def remove_from_list_and_transmit!
    REDIS.hdel brainstorm_key, session_id
    transmit_list!
  end

  def set_random_name_if_user_has_no_name
    if REDIS.get(session_id).nil?
      REDIS.set session_id, temporary_user_name
    end
  end

  def transmit_list!
    users = REDIS.hgetall(brainstorm_key).keys

    data = { 
      event: "transmit_presence_list",
      online_users: {} 
    }
    users.each do |user_id|
      unless last_user_activity_more_than_one_hour_ago?(user_id)
        name = REDIS.get(user_id)
        user_color = REDIS.get("user_color_for_user_id_#{user_id}")
        done_voting = REDIS.hget(done_voting_brainstorm_status, "#{user_id}")
        data[:online_users][user_id] = {
          id: user_id, 
          name: name, 
          initials: name.split(nil,2).map(&:first).join.upcase, 
          userColor: user_color, 
          doneVoting: done_voting 
        }
      end
    end

    PresenceChannel.broadcast_to @brainstorm, data
  end

  def last_user_activity_more_than_one_hour_ago?(user_id)
    DateTime.parse(REDIS.hget(brainstorm_key, user_id)) < Time.now-1.hour
  end

  def brainstorm_key
    "brainstorm_id_#{@brainstorm.token}"
  end

  def user_key
    "#{@session_id}"
  end

  def user_color_key
    "user_color_for_user_id_#{session_id}"
  end

  def done_voting_brainstorm_status
    "done_voting_brainstorm_status_#{@brainstorm.token}"
  end

  def temporary_user_name
    "Anonymous Brainstormer"
  end

  def random_color_class
    color_classes = ["bg-purply", "bg-greeny", "bg-yellowy", "bg-reddy"]

    color_classes.sample
  end
end
