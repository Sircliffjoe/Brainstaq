class CoursesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :authenticate_admin!, only: %i[new create edit update destroy]
  before_action :set_course, only: %i[show edit update destroy analytics]
  before_action :set_tags, only: %i[index learning pending_review teaching unapproved]

  COURSES_PER_PAGE = 9

  def index
    if params[:course_category].blank?
      @page = params.fetch(:page, 0).to_i 
      @next_page = @page + 1 if Course.count >= 9
      @prev_page = @page - 1 if @page < 0
      @courses = Course.offset(@page*COURSES_PER_PAGE).limit(COURSES_PER_PAGE).order(created_at: :desc)
    else
      @course_category_id = CourseCategory.find_by(name: params[:course_category]).id
      @course_count = course_count(@course_category_id)
      @page = params.fetch(:page, 0).to_i 
      @next_page = @page + 1 if Course.count >= 9
      @prev_page = @page - 1 if @page < 0
      @courses = Course.where(course_category_id: @course_category_id).offset(@page*COURSES_PER_PAGE).limit(COURSES_PER_PAGE).order(created_at: :desc)
    end
    @courses_count = Course.count
  end

  def learning
    @courses = Course.joins(:enrollments).where(enrollments: { user: current_user }).includes(:user, :course_tags, course_tags: :tag)
    render 'index'
  end

  def pending_review
    @courses = Course.joins(:enrollments).merge(Enrollment.pending_review.where(user: current_user)).includes(:user, :course_tags, course_tags: :tag)
    render 'index'
  end

  def teaching
    @courses = Course.where(user: current_user).includes(:user, :course_tags, course_tags: :tag)
    render 'index'
  end

  def unapproved
    @courses = Course.unapproved.published.includes(:user, :course_tags, course_tags: :tag)
    render 'index'
  end

  def show
    @course = Course.find(params[:id])
    @chapters = @course.chapters.rank(:row_order).includes(:lessons, lessons: [:user_lessons])
    @reviews = @course.enrollments.reviewed
  end

  def analytics
    @course = Course.find(params[:id])
    unless current_user.admin? || @course.user == current_user
      flash[:alert] = "You are not authorized to view analytics for this course."
      redirect_to @course and return
    end
  end

  def approve
    if current_user.admin?
      if @course.approved?
        @course.update(approved: false)
      else
        @course.update(approved: true)
      end
      CourseMailer.approved(@course).deliver_later
      redirect_to @course, notice: "Course approval: #{@course.approved}"
    else
      flash[:alert] = "You are not authorized to approve this course."
      redirect_to courses_path
    end
  end

  def new
    @course = Course.new
  end

  def course_count(category_id)
    Course.where(course_category_id: category_id).count
  end

  def create
    @course = Course.new(course_params)
    @course.marketing_description = 'Marketing Description'
    @course.description = 'Curriculum Description'
    @course.user = current_user

    if @course.save
      redirect_to course_course_wizard_index_path(@course), notice: 'Course was successfully created.'
    else
      render :new
    end
  end

  def destroy
    if @course.destroy
      redirect_to teaching_courses_path, notice: 'Course was successfully destroyed.'
    else
      redirect_to @course, alert: 'Course has enrollments. Can not be destroyed.'
    end
  end

  private

  def set_tags
    @tags = Tag.all.where.not(course_tags_count: 0).order(course_tags_count: :desc)
  end

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:course_category_id, :title, :description, :slug, :image, :handout, :released, :marketing_description, :language, :average_rating, :enrollments_count, :lessons_count, :published, :approved, :income, :price, :level, :paid, :premium_description, :category_id, :user_id, :chapters_count)
  end

  def authenticate_admin!
    unless current_user.admin?
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to courses_path
    end
  end
end
