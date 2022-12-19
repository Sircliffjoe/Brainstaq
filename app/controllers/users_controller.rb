class UsersController < ApplicationController
  # load_and_authorize_resource param_method: :user_params
  before_action :authenticate_user!
  before_action :set_user, only: [:profile, :index, :delete]
  impressionist actions: [:show], unique: [:impressionable_type, :impressionable_id, :session_hash]
  
  def index
  end

  def dashboard
    @ideas = Idea.all.order(created_at: :desc).take(15)
    @enterprises = Enterprise.all.order(created_at: :desc).take(15)
    @users = User.find_by_username params[:username]

    following_ids = Follow.where(follower_id: current_user.id).map(&:followee_id)
    following_ids << current_user.id

    @follower_suggestions = User.where.not(id: following_ids).take(10)
  end

  def follow
    @user = User.find_by_username params[:username]
    current_user.followees << @user
    redirect_back(fallback_location: profile_path(@user))
  end
  
  def unfollow
    @user = User.find_by_username params[:username]
    current_user.followed_users.find_by(followee_id: @user.id).destroy
    redirect_back(fallback_location: profile_path(@user))
  end

  # def user_rating
  #   self.user_rating = (self.ideas.count + self.comments.count)
  # end

  def create
    @users = User.create(params.require(:user))
    session[:user_id] = @user.id

    # redirect_to root_path
    format.html { redirect_to root_path, notice: 'Confirmation required. Check your email!' }
  end
  
  def new
    @user = User.new
  end

  def profile
    @profile = User.find_by_username params[:username]
    @ideas = current_user.ideas.all.order(created_at: :desc)
    # @team_members = current_user.team_members.all.order(created_at: :desc)

    following_ids = Follow.where(follower_id: current_user.id).map(&:followee_id)
    following_ids << current_user.id
    @enterprises = Enterprise.all.order(created_at: :desc).take(15)

    @follower_suggestions = User.where.not(id: following_ids).take(10)
  end

  def ideas
    @user = User.find_by_username params[:username]
    @ideas = @user.ideas
  end

  def set_user
    @user = User.find_by_username(params[:username])
  end

  def edit
   @user = User.find(params[:id])
  end

  def update
    current_user.update(params[:user])
    redirect_to profile_path(user.username)
  end

  private

  def user_params
    params.require(:user).permit(:id, :first_name, :last_name, :image, :image_url, :username, :country, 
      :website, :phone, :gender, :bio, :email, :password, :password_confirmation, :facebook_url, 
      :twitter_url, :instagram_url, :linkedin_url)
  end

  def image_params
    params.require(:image).permit(:image_url)
  end
end
