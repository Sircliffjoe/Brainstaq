class PagesController < ApplicationController
  
  IDEAS_PER_PAGE = 3
  ENTERPRISES_PER_PAGE = 3
  COURSES_PER_PAGE = 3
  
  def about
    @page = params.fetch(:page, 0).to_i 
    @next_page = @page + 1 unless Idea.count < 9
    @prev_page = @page - 1 unless @page == 0
    @ideas = Idea.all.offset(@page*IDEAS_PER_PAGE).limit(IDEAS_PER_PAGE).sort_by { |idea| idea.impressions.size.to_i}.reverse

    @enterprises = Enterprise.all
    @courses = Course.all
    @users = User.all
  end

  def career
  end

  def impressionist_count
    impressions.size
  end

  def terms
  end

  def privacy
  end

  # def plans
  #   render "pages/plans"
  # end
end
