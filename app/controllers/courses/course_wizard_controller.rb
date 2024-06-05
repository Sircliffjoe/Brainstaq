module Courses
  class CourseWizardController < ApplicationController
    include Wicked::Wizard
    before_action :set_progress, only: %i[show update]
    before_action :set_course, only: %i[show update finish_wizard_path]

    steps :about, :targeting, :pricing, :chapters, :publish

    def show
      case step
      when :about
      when :targeting
        @tags = Tag.all
      when :pricing
      when :chapters
        @course.chapters.build unless @course.chapters.any?
      when :publish
      end
      render_wizard
    end

    def update
      case step
      when :about
      when :targeting
        @tags = Tag.all
      when :pricing
      when :chapters
      when :publish
      end
      @course.update(course_params)
      render_wizard @course
    end

    def finish_wizard_path
      course_path(@course)
    end

    private

    def set_progress
      @progress = if wizard_steps.any? && wizard_steps.index(step).present?
                    ((wizard_steps.index(step) + 1).to_d / wizard_steps.count.to_d) * 100
                  else
                    0
                  end
    end

    def set_course
      @course = Course.find params[:course_id]
    end

    def course_params
      params.require(:course).permit(
        :title, :image, :marketing_description, :course_category_id, :description,
        :language, :level, :price, :published,
        tag_ids: [],
        chapters_attributes: %i[id title _destroy]
      )
    end
  end
end
