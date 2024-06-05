class LessonsController < ApplicationController
  before_action :set_lesson, only: %i[show edit update destroy]
  

  def sort
    @course = Course.find(params[:course_id])
    lesson = Lesson.find(params[:lesson_id])
    lesson.update(lesson_params)
    render body: nil
  end

  def show
    current_user.view_lesson(@lesson)
    @chapters = @course.chapters.rank(:row_order).includes(:lessons, lessons: [:user_lessons])
    @comment = Comment.new

    @commentable = @lesson
    @comments = @lesson.comments.order(created_at: :desc)
  end

  def new
    @lesson = Lesson.new
    @course = Course.find(params[:course_id])
    @lesson.course_id = @course.id
  end

  def create
    @lesson = Lesson.new(lesson_params)
    @course = Course.find(params[:course_id])
    @lesson.course_id = @course.id

    if @lesson.save
      redirect_to course_lesson_path(@course, @lesson, anchor: 'current_lesson'), notice: 'Lesson was successfully created.'
    else
      render :new
    end
  end

  def edit
    @lesson = Lesson.find(params[:id])
    unless current_user.admin?
      redirect_to course_lesson_path(@course, @lesson, anchor: 'current_lesson'), alert: 'You are not authorized to edit this lesson.'
      return
    end
  end

  def update
    if @lesson.update(lesson_params)
      redirect_to course_lesson_path(@course, @lesson, anchor: 'current_lesson'), notice: 'Lesson was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @lesson.destroy
    redirect_to course_path(@course), notice: 'Lesson was successfully deleted!'
  end

  private


  def set_lesson
    @course = Course.find(params[:course_id])
    @lesson = Lesson.find(params[:id])
  end

  def lesson_params
    params.require(:lesson).permit(:title, :content, :row_order_position, :chapter_id, :vimeo)
  end
end

