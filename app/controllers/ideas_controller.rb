class IdeasController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show]
  before_action :set_idea, only: [:show, :edit, :destroy, :update, :like, :unlike]
  before_action :find_idea, only: [:show, :edit, :update, :destroy]
  impressionist actions: [:show], unique: [:impressionable_type, :impressionable_id, :session_hash]
   
  IDEAS_PER_PAGE = 6

  def index
    if params[:category].blank?
      @page = params.fetch(:page, 0).to_i 
      @next_page = @page + 1 if Idea.count >= 6
      @prev_page = @page - 1 if @page < 0
      @ideas = Idea.offset(@page*IDEAS_PER_PAGE).limit(IDEAS_PER_PAGE).order(created_at: :desc)
    else
      @category_id = Category.find_by(name: params[:category]).id
      @page = params.fetch(:page, 0).to_i 
      @next_page = @page + 1 if Idea.count >= 6
      @prev_page = @page - 1 if @page < 0
      @ideas = Idea.where(category_id: @category_id).offset(@page*IDEAS_PER_PAGE).limit(IDEAS_PER_PAGE).order(created_at: :desc)
    end
    @enterprises_count = Enterprise.count
  end

  def donation_history
    @perk = Perk.find_by_id params[:perk_id]

    @idea = Idea.find(params[:id]) 
    @comment = Comment.new
    @comments = @idea.comments
    @comment.idea_id = @idea.id
    donation = Donation.includes(:idea).where(idea_id: params[:id])
    @donation = Donation.new
    @donors_count = donation.count
    @donors = @idea.donations
    @donated_amount = @idea.donations.sum(:amount)
    @idea = Idea.includes(:perks).find(params[:id])
  end

  def show
    @idea = Idea.find(params[:id]) 
    @comment = Comment.new
    @comments = @idea.comments
    @comment.idea_id = @idea.id
    donation = Donation.includes(:idea).where(idea_id: params[:id])
    @donation = Donation.new
    @donors_count = donation.count
    @donors = @idea.donations
    @donated_amount = @idea.donations.sum(:amount)
    @idea = Idea.includes(:perks).find(params[:id])
    @enterprises_count = Enterprise.count
    render :show
  end

  def set_pct_funded!
    self.pct_funded = (100 * self.donated_amount.to_f / self.donation_goal).round(1)
  end

  def new
    @idea = current_user.ideas.build
    @user = current_user
    @idea = Idea.new
  end

  def edit
    @idea = Idea.find(params[:id])
  end
  
  def create
    @idea = current_user.ideas.build(idea_params)
    @idea.user_id = current_user.id if user_signed_in?    
    # @idea = Idea.new(idea_params)
    respond_to do |format|
      if @idea.save
        IdeaMailer.with(idea: @idea).idea_created.deliver_now
        # ExpireIdeaJob.set(wait_until: @idea.expires_at).perform_later(@idea)
        format.html { redirect_to @idea, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @idea }
      else
        format.html { render :new }
      end

    end
  end

  def update
    respond_to do |format|
      if @idea.update(idea_params)
        format.html { redirect_to @idea, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @idea }
      else
        format.html { render :edit }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @idea = current_user.ideas.find(params[:id])
    @idea.destroy
    respond_to do |format|
      format.html { redirect_to ideas_url, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def like
    @idea.liked_by current_user
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path }
      format.json { render layout:false }
    end
  end

  def unlike
    @idea.unliked_by current_user
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path }
      format.json { render layout:false }
    end
  end

  private

  def set_idea
    @idea = Idea.find(params[:id])
  end

  def find_idea
    @idea = Idea.find(params[:id])
  end

  def idea_params
    params.require(:idea).permit(:title, :description, :overview, :impact, :donation_goal, :challenges, 
      :category_id, :image, :end_date, :image_cache, :user_id, 
    perks_attributes: [:id, :_destroy, :title, :description, :amount, :quantity])
  end
end