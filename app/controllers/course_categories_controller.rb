class CourseCategoriesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :authenticate_admin!, except: [:index]
  before_action :set_course_category, only: %i[show edit update destroy]

  
  COURSE_CATEGORIES_PER_PAGE = 12
  
  def index
    @course_categories = CourseCategory.all
  end

  # def index
  #   if params[:course_category].blank?
  #     @page = params.fetch(:page, 0).to_i 
  #     @next_page = @page + 1 if CourseCategory.count >= 12
  #     @prev_page = @page - 1 if @page < 0
  #     @course_categories = CourseCategory.offset(@page*COURSE_CATEGORIES_PER_PAGE).limit(COURSE_CATEGORIES_PER_PAGE).order(created_at: :desc)
  #   else
  #     @course_category_id = CourseCategory.find_by(name: params[:course_category]).id
  #     @page = params.fetch(:page, 0).to_i 
  #     @next_page = @page + 1 if CourseCategory.count >= 12
  #     @prev_page = @page - 1 if @page < 0
  #     @course_categories = CourseCategory.where(course_category_id: @course_category_id).offset(@page*COURSE_CATEGORIES_PER_PAGE).limit(COURSE_CATEGORIES_PER_PAGE).order(created_at: :desc)
  #   end
  #   @course_categories_count = CourseCategory.count
  # end

  # def index
  # @page = params.fetch(:page, 0).to_i
  # @course_categories_count = CourseCategory.count

  # @next_page = @page + 1 unless CourseCategory.count < 12
  # @prev_page = @page - 1 unless @page == 0
  # @course_categories = CourseCategory.offset(@page * COURSE_CATEGORIES_PER_PAGE)
  #                                     .limit(COURSE_CATEGORIES_PER_PAGE)
  #                                     .order(created_at: :desc)
  # else
  #   @course_category_id = CourseCategory.find_by(name: params[:course_category])&.id
  #   if @course_category_id
  #     @next_page = @page + 1 if @course_categories_count >= 12
  #     @prev_page = @page - 1 if @page.positive?
  #     @course_categories = CourseCategory.where(course_category_id: @course_category_id)
  #                                       .offset(@page * COURSE_CATEGORIES_PER_PAGE)
  #                                       .limit(COURSE_CATEGORIES_PER_PAGE)
  #                                       .order(created_at: :desc)
  #   else
  #     # Handle case when course category is not found
  #     # You can redirect or display an error message here
  #   end
  # end
# end



  def show
  end

  def new
    @course_category = CourseCategory.new
  end

  def create
    @course_category = CourseCategory.new(course_category_params)
    if @course_category.save
      redirect_to @course_category, notice: 'Course category was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @course_category.update(course_category_params)
      redirect_to @course_category, notice: 'Course category was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @course_category.destroy
    redirect_to course_categories_url, notice: 'Course category was successfully destroyed.'
  end

  private

  def authenticate_admin!
    unless current_user.admin?
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to root_path
    end
  end

  def set_course_category
    @course_category = CourseCategory.find(params[:id])
  end

  def course_category_params
    params.require(:course_category).permit(:name)
  end
end
