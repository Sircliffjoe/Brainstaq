class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  # before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :set_commentable, only: [:create, :destroy]

  def index
    @comments = Comment.all
  end

  def show
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.build(comment_params)
    # @comment = Comment.new(comment_params)
    # @course = Course.find(params[:course_id])
    # @lesson = Lesson.find(params[:lesson_id])
    # @comment.lesson = @lesson
    @comment.user = current_user

    if @comment.save
      # CommentMailer.new_comment(@comment).deliver_later if @comment.user_id != @commentable.user_id
      redirect_to commentable_path(@commentable), notice: "Your comment was successfully added."
    else
      render 'new'
    end
  end

	def destroy
    @course = Course.find(params[:course_id])
    @lesson = Lesson.find(params[:lesson_id])
    @comment = @commentable.comments.find(params[:id])
    @comment.destroy
    redirect_to commentable_path(@commentable), notice: "Comment was successfully destroyed."
  end

  private


  def set_commentable
    if params[:idea_id]
      @commentable = Idea.find(params[:idea_id])
    elsif params[:course_id] && params[:lesson_id]
      @commentable = Lesson.find(params[:lesson_id])
      @commentable = Course.find(params[:course_id])
    end
  end


  def commentable_path(commentable)
    case commentable.class.name
    when "Idea"
      idea_path(commentable)
    when "Lesson"
      course_lesson_path(commentable, params[:lesson_id], anchor: 'current_lesson')
    end
  end

  def comment_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type)
  end
end