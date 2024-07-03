class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!
  # before_action :set_category, only: %i[show edit index update destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def show
    
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, notice: 'category was successfully created.'
    else
      render :new
    end
  end

  private

  # def set_category
  #   @category = Category.find(params[:id])
  # end

  def category_params
    params.require(:category).permit(:name)
  end

  def authenticate_admin!
    unless current_user.admin?
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to root_path
    end
  end
end