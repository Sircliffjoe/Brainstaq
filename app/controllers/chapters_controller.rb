class ChaptersController < ApplicationController
  before_action :set_chapter, only: %i[edit update destroy]

  def sort
    @course = Course.find(params[:course_id])
    chapter = Chapter.find(params[:chapter_id])
    chapter.update(chapter_params)
    render body: nil
  end

  def new
    @chapter = Chapter.new
    @course = Course.find(params[:course_id])
    @chapter.course_id = @course.id # for authorization
  end

  def create
    @chapter = Chapter.new(chapter_params)
    @course = Course.find(params[:course_id])
    @chapter.course_id = @course.id

    # authorize @chapter
    if @chapter.save
      redirect_to course_path(@course), notice: 'Chapter was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    # authorize @chapter
    if @chapter.update(chapter_params)
      redirect_to course_path(@course), notice: 'Chapter was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    # authorize @chapter
    @chapter.destroy
    redirect_to course_path(@course), notice: 'Chapter was successfully destroyed.'
  end

  private

  def set_chapter
    @course = Course.find(params[:course_id])
    @chapter = Chapter.find(params[:id])
  end

  def chapter_params
    params.require(:chapter).permit(:title, :row_order_position)
  end
end
