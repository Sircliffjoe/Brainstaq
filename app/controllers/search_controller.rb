class SearchController < ApplicationController
  def index
    if params[:query].blank?
      redirect_to root_path, alert: "Empty field!"
    elsif params[:query].start_with?('#')
      query = params[:query].gsub('#', '').downcase
      @ideas = Idea.joins(:idea).where("lower(ideas.title) = ?", query)
      @enterprises = Enterprise.joins(:enterprise).where("lower(enterprises.name) = ?", query)
      @users = User.joins(:user).where("lower(users.first_name) = ?", query)
      @courses = Course.joins(:course).where("lower(courses.title) = ?", query)
    else
      query = params[:query].downcase
      @ideas = Idea.where("lower(title) like ? or lower(description) like ?", "%#{query}%", "%#{query}%")
      @enterprises = Enterprise.where("lower(name) like ? or lower(info) like ?", "%#{query}%", "%#{query}%")
      @users = User.where("lower(first_name || ' ' || last_name) like ?", "%#{query}%")
      @courses = Course.where("lower(title) like ? or lower(description) like ?", "%#{query}%", "%#{query}%")
    end
  end

  def check_ideas_exists
    if Idea.exists?(title: self.title)
    end
  end

  def check_enterprises_exists
    if Enterprise.exists?(name: self.name)
    end
  end

  def check_courses_exists
    if Course.exists?(title: self.title)
    end
  end

  def check_users_exists
    if User.exists?(first_name: self.first_name)
    elsif User.exists?(last_name: self.last_name)
    end
  end 
end
