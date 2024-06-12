class EnrollmentsController < ApplicationController
  before_action :authenticate_user!, only: [:certificate]
  before_action :authenticate_admin!, only: %i[index]
  before_action :set_enrollment, only: %i[show edit update destroy certificate]

  def index
    @enrollments = Enrollment.includes(:user)
  end

  def teaching
    @enrollments = current_user.students.includes(:user)
    render 'index'
  end

  # def certificate
  #   respond_to do |format|
  #     format.pdf do
  #       render pdf: "#{@enrollment.course.title}, #{@enrollment.user.full_name}",
  #              page_size: 'A4',
  #              template: 'enrollments/certificate.pdf.erb'
  #     end
  #   end
  # end


  def certificate
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "#{@enrollment.course.title}, #{@enrollment.user.full_name}",
          type: 'application/pdf',
          layout: 'certificate_pdf.html.erb',
          page_size: 'A4',
          template: 'enrollments/certificate.pdf.erb',
          margin: { :top => 20, :bottom => 10, :left => 20, :right => 20},
          viewport_size: '1280x1024',
          lowquality: true,
          zoom: 1,
          dpi: 75,
          orientation: 'Landscape',
          disposition: 'inline'
      end
    end
  end

  def show
  end

  def edit
  end

  def create
    @course = Course.find(params[:course_id])
    # if @course.price.positive?
    #   redirect_to course_path(@course), alert: 'The course is not free...'
    # else
      @enrollment = current_user.take_course(@course)
      EnrollmentMailer.student_enrollment(@enrollment).deliver_later
      EnrollmentMailer.teacher_enrollment(@enrollment).deliver_later
      redirect_to course_path(@course), notice: 'You are enrolled!'
    # end
  end

  def update
    if @enrollment.update(enrollment_params)
      redirect_to @enrollment, notice: 'Enrollment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @enrollment.destroy
    redirect_to enrollments_url, notice: 'Enrollment was successfully destroyed.'
  end

  private

  def set_enrollment
    @enrollment = Enrollment.find(params[:id])
  end

  def enrollment_params
    params.require(:enrollment).permit(:rating, :review)
  end

  def authenticate_admin!
    unless current_user.admin?
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to courses_path
    end
  end
end
