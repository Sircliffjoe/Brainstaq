class TransactionsController < ApplicationController
  before_action :authenticate_user!, except: [:new]

  def new
    @paystackObj = Paystack.new(ENV['PAYSTACK_PUBLIC_KEY'], ENV['PAYSTACK_SECRET_KEY'])
    page_number = 1
    plans = PaystackPlans.new(@paystackObj)
    result = plans.list(page_number)
    @plans_list = result['data']
                .select { |plan| !plan['is_deleted'] && !plan['is_archived'] }
                .sort_by { |plan| plan['amount'] }
    @transaction = Transaction.new
    @enterprises_count = Enterprise.count
  
    # Fetch local subscription plans and features
    @local_plans = SubscriptionPlan.includes(:features).all
    @plan = SubscriptionPlan.first
  end
  

  # def index
  #   @ress = Transaction.all
  # end

  def index
    @ress = current_user.enterprise.transactions if current_user.enterprise
  end

  def details
    @res = Transaction.find(params[:id])
  end

  def callback
    res = 0;
    @paystackObj = Paystack.new(ENV['PAYSTACK_PUBLIC_KEY'], ENV['PAYSTACK_SECRET_KEY'])
   
    transaction_reference = params[:trxref]
    transactions = PaystackTransactions.new(@paystackObj)
    result = transactions.verify(transaction_reference)
    
    if result['data']['status'] == "success"
      @res = result['data']
      @customer = result['data']['customer']

      # Retrieve user from session (assuming you have user ID in session)
      # user_id = session[:user_id]
      # current_user = User.find_by(id: user_id)
      
      current_user.enterprise.update(status: 1 )
      if current_user.enterprise.interval == "monthly"
        res = 30
      elsif current_user.enterprise.interval == "annually"
        res = 365
      end

      if current_user.enterprise.transactions.any?
        if current_user.enterprise.transactions.last.expires_on > Date.today
          rem = (current_user.enterprise.transactions.last.expires_on - Date.today).to_s.split('/')
          offset = rem[0].to_i + res
          
          @transaction = current_user.enterprise.transactions.create(
            amount: (@res['amount'].to_f)/100,
            channel: @res['channel'], 
            reference: @res['reference'], 
            gateway_response: @res['gateway_response'],
            currency: @res['currency'], 
            status: @res['status'], 
            expires_on: Date.today + offset.days,
            created_at: Time.now, 
            updated_at: Time.now
          )

          redirect_to details_transaction_path(@transaction), notice: 'Your Subscription Upgrade was successful.'
        else
          @transaction = current_user.enterprise.transactions.create(
            amount: (@res['amount'].to_f)/100,
            channel: @res['channel'], 
            reference: @res['reference'], 
            gateway_response: @res['gateway_response'],
            currency: @res['currency'], 
            status: @res['status'], 
            expires_on: Date.today + res.days,
            created_at: Time.now, 
            updated_at: Time.now
          )

          redirect_to details_transaction_path(@transaction), notice: 'Your Subscription was successful.'
        end
      else
        @transaction =  current_user.enterprise.transactions.create(
          amount: (@res['amount'].to_f)/100,
          channel: @res['channel'], 
          reference: @res['reference'], 
          gateway_response: @res['gateway_response'],
          currency: @res['currency'], 
          status: @res['status'], 
          expires_on: Date.today + res.days,
          created_at: Time.now, 
          updated_at: Time.now
        )
        redirect_to details_transaction_path(@transaction), notice: 'Your Subscription was successful.'
      end
    else
      redirect_to new_transaction_path, notice: 'Payment Failed. Please try again'
    end
  end

  def show
    res = 0;
    @paystackObj = Paystack.new(ENV['PAYSTACK_PUBLIC_KEY'], ENV['PAYSTACK_SECRET_KEY'])
   
    transaction_reference = params[:trxref]
    transactions = PaystackTransactions.new(@paystackObj)
    result = transactions.verify(transaction_reference)
    
    if result['data']['status'] == "success"
      @res = result['data']
      @customer = result['data']['customer']
      current_user.enterprise.update(status: 1 )
      if current_user.enterprise.interval == "monthly"
        res = 30
      elsif current_user.enterprise.interval == "annually"
        res = 365
      end

      if current_user.enterprise.transactions.any?
        if current_user.enterprise.transactions.last.expires_on > Date.today
          rem = (current_user.enterprise.transactions.last.expires_on - Date.today).to_s.split('/')
          offset = rem[0].to_i + res
          
          @transaction = current_user.enterprise.transactions.create(
            amount: (@res['amount'].to_f)/100,
            channel: @res['channel'], 
            reference: @res['reference'], 
            gateway_response: @res['gateway_response'],
            currency: @res['currency'], 
            status: @res['status'], 
            expires_on: Date.today + offset.days,
            created_at: Time.now, 
            updated_at: Time.now
          )

          redirect_to details_transaction_path(@transaction), notice: 'Your Subscription Upgrade was successful.'
          else
            @transaction = current_user.enterprise.transactions.create(amount: (@res['amount'].to_f)/100,
            channel: @res['channel'], 
            reference: @res['reference'], 
            gateway_response: @res['gateway_response'],
            currency: @res['currency'], 
            status: @res['status'], 
            expires_on: Date.today + res.days,
            created_at: Time.now, 
            updated_at: Time.now
          )

          redirect_to details_transaction_path(@transaction), notice: 'Your Subscription was successful.'
        end
      else
        @transaction =  current_user.enterprise.transactions.create(
          amount: (@res['amount'].to_f)/100,
          channel: @res['channel'], 
          reference: @res['reference'], 
          gateway_response: @res['gateway_response'],
          currency: @res['currency'], 
          status: @res['status'], 
          expires_on: Date.today + res.days,
          created_at: Time.now, 
          updated_at: Time.now
        )
        redirect_to details_transaction_path(@transaction), notice: 'Your Subscription was successful.'
      end
    else
      redirect_to new_transaction_path, notice: 'Payment Failed. Please try again'
    end
  end

  def upgrade
    @paystackObj = Paystack.new(ENV['PAYSTACK_PUBLIC_KEY'], ENV['PAYSTACK_SECRET_KEY'])
    page_number = 1
    plans = PaystackPlans.new(@paystackObj)
    result = plans.list(page_number)  #Optional `page_number` parameter,  50 items per page
    @plans_list = result['data'].select { |plan| !plan['is_deleted'] && !plan['is_archived'] }
    @transaction = Transaction.new
  end

  def edit
  end

  def create
    @paystackObj = Paystack.new(ENV['PAYSTACK_PUBLIC_KEY'], ENV['PAYSTACK_SECRET_KEY'])
    
    if current_user.enterprise
      current_user.enterprise.update(interval: params[:interval])
    end
  
    transactions = PaystackTransactions.new(@paystackObj)
  
    begin
      result = transactions.initializeTransaction(
        reference: "brainer#{current_user.id}#{Time.now.to_i}",
        email: current_user.email,
        amount: params[:amount],
        plan: params[:code]
      )
  
      auth_url = result['data']['authorization_url']
      redirect_to auth_url

    rescue RestClient::BadRequest => e
      flash[:alert] = "Error initializing transaction: #{e.message}"
      redirect_to new_transaction_path
    end
  end

  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  
  def set_transaction
    @Transaction = Transaction.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit!
  end
end