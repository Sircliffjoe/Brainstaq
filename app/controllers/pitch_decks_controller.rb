class PitchDecksController < ApplicationController
  before_action :authenticate_user!
  before_action :get_enterprise
  before_action :set_pitch_deck, only: %i[ show edit update destroy ]
  before_action :check_active
  

  def index
    @pitch_decks = @enterprise.pitch_decks
  end

  # def download
  #   @pitch_deck = PitchDeck.find(params[:id])
  # end
  
  def new
    @pitch_deck = @enterprise.pitch_decks.build
  end

  def edit
    # @enterprises = current_user.enterprises
  end

  def show
    @pitch_deck = PitchDeck.find(params[:id])

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Pitch_Deck_for_#{@pitch_deck.enterprise.name}",
              type: 'application/pdf',
              layout: 'pdf.html.erb',
              page_size: 'A4',
              template: 'pitch_decks/pitch_deck.html.erb',
              margin: { :top => 20, :bottom => 10, :left => 20, :right => 20},
              viewport_size: '1280x1024',
              lowquality: true,
              zoom: 1,
              dpi: 75,
              orientation: 'Portrait',
              disposition: 'inline'
      end
    end
  end

  def create
    @pitch_deck = @enterprise.pitch_decks.build(pitch_deck_params)

    respond_to do |format|
      if @pitch_deck.save
        format.html { redirect_to enterprise_pitch_decks_path(@enterprise), notice: "Pitch Deck was successfully created" }
        format.json { render :show, status: :created, location: @pitch_deck }
      else
        format.html { render :new }
        format.json { render json: @pitch_deck.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @pitch_deck.update(pitch_deck_params)
        format.html { redirect_to enterprise_pitch_decks_path(@enterprise), notice: "Pitch Deck was successfully updated" }
        format.json { render :show, status: :ok, location: @pitch_deck }
      else
        format.html { render :edit }
        format.json { render json: @pitch_deck.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @pitch_deck.destroy
    respond_to do |format|
      format.html { redirect_to enterprise_pitch_decks_path(@enterprise), notice: "Pitch Deck was successfully deleted" }
      format.json { head :no_content }
    end
  end

  # def require_subscription
  #   unless current_user.subscribed?
  #     flash[:error] = "A subscription is required to create a pitch deck."
  #     redirect_to new_transaction_path
  #   end
  # end

  private
  
  def get_enterprise
    @enterprise = Enterprise.find(params[:enterprise_id])
  end

  def set_pitch_deck
    @pitch_deck = @enterprise.pitch_decks.find(params[:id])
  end

  def check_active
    unless @enterprise.active?
      redirect_to @enterprise, alert: "#{@enterprise.name} is inactive. You cannot view or create pitch decks."
    end
  end

  def pitch_deck_params
    params.require(:pitch_deck).permit(:elevator_pitch, :mission, :problem, :competitor_analysis, 
      :solution, :how_it_works, :market_opportunity, :market_size, :financials, :revenue_model, 
      :traction, :growth_strategy, :investment, :team, :introduction, :conclusion, :enterprise_id)
  end
end
