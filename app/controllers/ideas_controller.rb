class IdeasController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show]
  before_action :set_idea, only: [:show, :edit, :destroy, :update, :like, :unlike]
  impressionist actions: [:show], unique: [:impressionable_type, :impressionable_id, :session_hash]

  IDEAS_PER_PAGE = 6

   
  # GET /ideas
  # GET /ideas.json
  def index
    @page = params.fetch(:page, 0).to_i 
    @next_page = @page + 1 if Idea.count > 6
    @prev_page = @page - 1 if @page < 0
    @ideas = Idea.offset(@page*IDEAS_PER_PAGE).limit(IDEAS_PER_PAGE).order(created_at: :desc)  
  end

  # GET /ideas/1
  # GET /ideas/1.json
  def show
    @idea = Idea.find(params[:id]) 
    @comment = Comment.new
    @comments = @idea.comments
    @comment.idea_id = @idea.id
  end

  # GET /ideas/new
  def new
    @idea = current_user.ideas.build
    @user = current_user
    @idea = Idea.new
  end

  # GET /ideas/1/edit
  def edit
    @idea = Idea.find(params[:id])
  end

  # POST /ideas
  # POST /ideas.json
  def create
    @idea = current_user.ideas.build(idea_params)
    @idea.user_id = current_user.id if user_signed_in?    
    # @idea = Idea.new(idea_params)
    respond_to do |format|
      if @idea.save
        # ExpireIdeaJob.set(wait_until: @idea.expires_at).perform_later(@idea)
        format.html { redirect_to @idea, notice: 'Idea was successfully created.' }
        format.json { render :show, status: :created, location: @idea }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /ideas/1
  # PATCH/PUT /ideas/1.json
  def update
    respond_to do |format|
      if @idea.update(idea_params)
        format.html { redirect_to @idea, notice: 'Idea was successfully updated.' }
        format.json { render :show, status: :ok, location: @idea }
      else
        format.html { render :edit }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ideas/1
  # DELETE /ideas/1.json
  def destroy
    @idea = current_user.ideas.find(params[:id])
    @idea.destroy

    redirect_to :dashboard
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
    # Use callbacks to share common setup or constraints between actions.
    def set_idea
      @idea = Idea.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def idea_params
      params.require(:idea).permit(:title, :description, :overview, :impact, :donation_goal, :challenges, :category, :image, :image_cache, :user_id, 
      perks_attributes: [:id, :_destroy, :title, :description, :amount, :quantity])
    end
end
