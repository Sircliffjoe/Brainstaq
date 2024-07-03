class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, except: [:index, :show]

  POSTS_PER_PAGE = 9

  def index
    # if params[:category].blank?
    #   @page = params.fetch(:page, 0).to_i 
    #   @next_page = @page + 1 if Post.count >= 9
    #   @prev_page = @page - 1 if @page < 0
    #   @posts = Post.offset(@page*POSTS_PER_PAGE).limit(POSTS_PER_PAGE).order(created_at: :desc)
    # else
    #   @category_id = Category.find_by(name: params[:category]).id
    #   @page = params.fetch(:page, 0).to_i 
    #   @next_page = @page + 1 if Post.count >= 9
    #   @prev_page = @page - 1 if @page < 0
    #   @posts = Post.where(category_id: @category_id).offset(@page*POSTS_PER_PAGE).limit(POSTS_PER_PAGE).order(created_at: :desc)
    # end
    @latest_post = Post.order(created_at: :desc).first
    @next_four_posts = Post.order(created_at: :desc).offset(1).limit(4)
    # @trending_posts = Post.order(views: :desc).limit(4)
    @trending_posts = Post.where("created_at >= ?", 1.week.ago).order(views: :desc).limit(4)
    @posts_count = Post.count
  end

  def show
    # @post = Post.find(params[:id])
    @post = Post.includes(:user).find(params[:id])
    @post.user_id= current_user.id
    @post.increment!(:views)
    @trending_posts = Post.where("created_at >= ?", 1.week.ago).order(views: :desc).limit(4)
    @posts_count = Post.count
  end

  def new
    if current_user.admin?
      @post = current_user.posts.build
      @user = current_user
      @post = Post.new
      @categories = Category.all
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id= current_user.id
    @post.date_posted = DateTime.now
    @post.author = current_user.full_name # assuming you have a current_user method

    if @post.save
      redirect_to @post, notice: 'Post published!.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :short_description, :content, :image, :category_id, optional_images: [])
  end

  def authenticate_admin!
    unless current_user.admin?
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to posts_path
    end
  end
end