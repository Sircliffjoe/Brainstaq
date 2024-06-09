class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_commentable, only: [:create, :destroy]

  def index
    @comments = Comment.all
  end

  def show
  end

  def new
    @comment = Comment.new
  end

  # def create
  #   @comment = @commentable.comments.new(comment_params)
  #   @comment.user = current_user
  #   if @comment.save
  #     redirect_to commentable_path(@commentable), notice: 'Your comment was successfully added.'
  #   else
  #     render 'new'
  #   end
  # end

  # def create
  #   @comment = @commentable.comments.new(comment_params)
  #   @comment.user = current_user

  #   if @comment.save
  #     redirect_to [@commentable, anchor: "comment_#{@comment.id}"], notice: 'Comment was successfully created.'
  #   else
  #     redirect_to [@commentable, anchor: "new_comment"], alert: 'Failed to add comment.'
  #   end
  # end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to commentable_path(@commentable, anchor: "comment_#{@comment.id}"), notice: 'Comment successfully added!'
    else
      redirect_to commentable_path(@commentable, anchor: "new_comment"), alert: 'Error in adding comment'
    end
  end

	def destroy
    # @course = Course.find(params[:course_id])
    # @lesson = Lesson.find(params[:lesson_id])
    @comment = @commentable.comments.find(params[:id])
    @comment.destroy
    redirect_to commentable_path(@commentable), notice: "Comment successfully deleted!"
  end

  
  private


  def set_commentable
    if params[:lesson_id]
      @commentable = Lesson.find(params[:lesson_id])
    elsif params[:idea_id]
      @commentable = Idea.find(params[:idea_id])
    end
  end

  def commentable_path(commentable, options = {})
    if commentable.is_a?(Lesson)
      course_lesson_path(commentable.course, commentable, options)
    elsif commentable.is_a?(Idea)
      idea_path(commentable, options)
    end
  end

  def comment_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type)
  end
end