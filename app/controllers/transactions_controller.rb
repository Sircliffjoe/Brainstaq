class TransactionsController < ApplicationController
	
	def index
		@ress = Transaction.all
	end

	def details
		@res = Transaction.find(params[:id])
	end

	def callback
		res = 0;
		@paystackObj = Paystack.new(ENV['PAYSTACK_PUBLIC_KEY'], ENV['PAYSTACK_PRIVATE_KEY']) 
		transaction_reference = params[:trxref]
		transactions = PaystackTransactions.new(@paystackObj)
		result = transactions.verify(transaction_reference)
		
    if result['data']['status'] == "success"
			@res = result['data']
			@customer = result['data']['customer']
			current_user.update(status: 1 )
			if current_user.interval == "monthly"
				res = 30
			elsif current_user.interval == "annually"
				res = 365
			end

			if current_user.transactions.any?
				if current_user.transactions.last.expires_on > Date.today
					rem = (current_user.transactions.last.expires_on - Date.today).to_s.split('/')
					offset = rem[0].to_i + res
					@transaction = current_user.transactions.create(
            amount: (@res['amount'].to_f)/100,
            channel: @res['channel'], 
            reference: @res['reference'], 
            # status: "success", 
            gateway_response: @res['gateway_response'],
            currency: @res['currency'], 
            status: @res['status'], 
            expires_on: Date.today + offset.days,
            created_at: Time.now, 
            updated_at: Time.now
          )
					redirect_to details_transaction_path(@transaction), notice: 'Your Subscription Upgrade was successful.'
				else
  				@transaction = current_user.transactions.create(
            amount: (@res['amount'].to_f)/100,
            channel: @res['channel'], 
            reference: @res['reference'], 
          #  status: "success", 
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
				@transaction =  current_user.transactions.create(
          amount: (@res['amount'].to_f)/100,
          channel: @res['channel'], 
          reference: @res['reference'], 
          #status: "success", 
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
		@paystackObj = Paystack.new(ENV['PAYSTACK_PUBLIC_KEY'], ENV['PAYSTACK_PRIVATE_KEY']) 
		transaction_reference = params[:trxref]
		transactions = PaystackTransactions.new(@paystackObj)
		result = transactions.verify(transaction_reference)
		
		if result['data']['status'] == "success"
			@res = result['data']
			@customer = result['data']['customer']
			current_user.update(status: 1 )
			if current_user.interval == "monthly"
				res = 30
			elsif current_user.interval == "annually"
				res = 365
			end

			if current_user.transactions.any?
				if current_user.transactions.last.expires_on > Date.today	
					rem = (current_user.transactions.last.expires_on - Date.today).to_s.split('/')
					offset = rem[0].to_i + res
					@transaction = current_user.transactions.create(
						amount: (@res['amount'].to_f)/100,
						channel: @res['channel'], 
						reference: @res['reference'], 
						#status: "success", 
						gateway_response: @res['gateway_response'],
						currency: @res['currency'], 
						status: @res['status'], 
						expires_on: Date.today + offset.days,
						created_at: Time.now, 
						updated_at: Time.now
					)
					redirect_to details_transaction_path(@transaction), notice: 'Your Subscription Upgrade was successful.'
				else
					@transaction = current_user.transactions.create(
						amount: (@res['amount'].to_f)/100,
						channel: @res['channel'], 
						reference: @res['reference'], 
						#status: "success", 
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
				@transaction =  current_user.transactions.create(
					amount: (@res['amount'].to_f)/100,
					channel: @res['channel'], 
					reference: @res['reference'], 
					#status: "success", 
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
	
	def new
		@paystackObj = Paystack.new(ENV['PAYSTACK_PUBLIC_KEY'], ENV['PAYSTACK_PRIVATE_KEY'])
		page_number = 1
		plans = PaystackPlans.new(@paystackObj)
		result = plans.list(page_number)
		@plans_list = result['data']
		@transaction = Transaction.new
	end

	def upgrade
		@paystackObj = Paystack.new(ENV['PAYSTACK_PUBLIC_KEY'], ENV['PAYSTACK_PRIVATE_KEY'])
		page_number = 1
		plans = PaystackPlans.new(@paystackObj)
		result = plans.list(page_number)
		@plans_list = result['data']
		@transaction = Transaction.new		
	end

	def edit
	end

	def create
		current_user.update(interval: params[:interval])
		new
		transactions = PaystackTransactions.new(@paystackObj)
		result = transactions.initializeTransaction(
			:email => current_user.email,
			:plan => params[:code]
		)
		auth_url = result['data']['authorization_url']
		redirect_to auth_url
    # redirect_to dashboard_path(current_user.full_name)
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
