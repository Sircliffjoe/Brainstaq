class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  impressionist actions: [:show], unique: [:impressionable_type, :impressionable_id, :session_hash]

  IDEAS_PER_PAGE = 3
  ENTERPRISES_PER_PAGE = 3

  def active?
    status == "active"
  end

  def inactive
    status == "inactive"
  end
  
  def index
    @page = params.fetch(:page, 0).to_i 
    @next_page = @page + 1 unless Idea.count < 9
    @prev_page = @page - 1 unless @page == 0
    @ideas = Idea.all.offset(@page*IDEAS_PER_PAGE).limit(IDEAS_PER_PAGE).sort_by { |idea| idea.impressions.size.to_i}.reverse

    @enterprises = Enterprise.all
    @enterprises_count = Enterprise.count
    
    @users = User.all
  end

  def impressionist_count
    impressions.size
  end

end