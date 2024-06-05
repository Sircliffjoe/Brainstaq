class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]
  before_action :set_user, only: [:profile, :index, :delete]
  impressionist actions: [:show], unique: [:impressionable_type, :impressionable_id, :session_hash]

  def index
  end

  def dashboard
    @ideas = Idea.all.order(created_at: :desc).limit(15)
    @enterprises = Enterprise.all.order(created_at: :desc).limit(15)
    following_ids = Follow.where(follower_id: current_user.id).map(&:followee_id)
    following_ids << current_user.id
  
    @follower_suggestions = User.where.not(id: following_ids).limit(10)
  end
  
  def follow
    @user = User.find_by_username params[:username]
    current_user.followees << @user
    redirect_back(fallback_location: profile_path(@user.username))
  end
  
  def unfollow
    @user = User.find_by_username params[:username]
    current_user.followed_users.find_by(followee_id: @user.id).destroy
    redirect_back(fallback_location: profile_path(@user.username))
  end

  def create
    @user = User.create(params.require(:user))

    if verify_recaptcha(model: @user) && @user.save
      session[:user_id] = @user.id
      format.html { redirect_to root_path, notice: 'Confirmation required. Check your email!' }
    else
      render :new
    end
  end
  
  def new
    @user = User.new
  end

  def profile
    @profile = User.find_by_username params[:username]
    @user = User.find_by_username params[:username]
    @ideas = current_user.ideas.order(created_at: :desc)
    @enterprises = Enterprise.all.order(created_at: :desc).limit(15)
    @courses_teaching = @user.courses
    @courses_learning = @user.enrollments.includes(:course)

    following_ids = current_user.followees.pluck(:id)
    following_ids << current_user.id

    @follower_suggestions = User.where.not(id: following_ids).limit(10)
    @active_campaigns = @user.ideas.select { |idea| idea.relevance_bar > 75 && !idea.expired? }

    @courses_teaching = @user.courses
    @courses_learning = @user.enrollments.includes(:course)
  end
  

  def ideas
    @user = User.find_by_username params[:username]
    @ideas = @user.ideas
  end

  def edit
    @user = current_user
  end

  def update
    if current_user.update(user_params)
      redirect_to profile_path(current_user.username)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :image, :image_url, :country, 
      :website, :phone, :gender, :bio, :email, :password, :password_confirmation, :facebook_url, 
      :twitter_url, :instagram_url, :username, :linkedin_url)
  end

  def sign_up_params
    params.require(:user).permit(:email, :password, :last_name, :first_name, :username, :country, :password_confirmation)
  end

  def set_user
    @user = User.find_by_username(params[:username])
  end
end
