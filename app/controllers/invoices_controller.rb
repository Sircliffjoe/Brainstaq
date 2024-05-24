class InvoicesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_enterprise
  before_action :set_invoice, only: %i[ show edit update destroy ]
  before_action :check_active
  

  def index
    @invoices = @enterprise.invoices
    # @invoices = scope
  end

  # def download
  #   @invoice = Invoice.find(params[:id])
  # end
  
  def new
    # @invoice = @enterprise.invoices.new
    @invoice = @enterprise.invoices.build
  end

  def edit
    # @enterprises = current_user.enterprises
  end

  def show
    #@invoice = scope.find(params[:id])
    @invoice = Invoice.find(params[:id])

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Invoice No. #{@invoice.id}",
              type: 'application/pdf',
              layout: 'invoice_pdf.html.erb',
              page_size: 'A4',
              template: 'invoices/show.html.erb',
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

  def create
    @invoice = @enterprise.invoices.build(invoice_params)

    respond_to do |format|
      if @invoice.save
        format.html { redirect_to enterprise_invoices_path(@enterprise), notice: "Business plan was successfully created" }
        format.json { render :show, status: :created, location: @invoice }
      else
        format.html { render :new }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to enterprise_invoices_path(@enterprise), notice: "Business plan was successfully updated" }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @invoice.destroy
    respond_to do |format|
      format.html { redirect_to enterprise_invoices_path(@enterprise), notice: "Business plan was successfully deleted" }
      format.json { head :no_content }
    end
  end

  private
  
  def get_enterprise
    @enterprise = Enterprise.find(params[:enterprise_id])
  end

  def set_invoice
    @invoice = @enterprise.invoices.find(params[:id])
  end

  def check_active
    unless @enterprise.active?
      redirect_to @enterprise, alert: "#{@enterprise.name} is inactive. You cannot view or create invoices."
    end
  end

  def invoice_params
    params.require(:invoice).permit(:from_full_name, :from_address, :from_email, :from_phone, :to_full_name, 
      :to_address, :to_email, :to_phone, :discount, :vat, :enterprise_id, 
      invoice_items_attributes: [:id, :_destroy, :name, :description, :price, :qty])
  end
  # def scope
  #   ::Invoice.all.includes(:invoice_items)
  # end
end
