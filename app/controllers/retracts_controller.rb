class RetractsController < ApplicationController
  before_action :verify_authenticity_token
  before_action :authenticate_user!
  
  def show
    res = 0
    @paystackObj = Paystack.new(ENV['PAYSTACK_PUBLIC_KEY'], ENV['PAYSTACK_SECRET_KEY'])
    transaction_reference = params[:trxref]
    transactions = PaystackTransactions.new(@paystackObj)
    result = transactions.verify(transaction_reference)
    @res = result['data']
    @customer = result['data']['customer']  
    if @res['status'] == "success"
      user = user.find_by_email(@customer['email']) 
      user.update(status: 1 )
      if user.interval == "monthly"
        res = 30
      else user == "annually"
        res = 365
      end
      user.transactions.create(
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
    end
  end
  def web
    res = 0;
    @paystackObj = Paystack.new(ENV['PAYSTACK_PUBLIC_KEY'], ENV['PAYSTACK_SECRET_KEY'])
    @res = params['data']
    @plan = params['data']['plan']['interval']
    @customer = params['data']['customer']
    if @res['status'] == "success"
      user = user.find_by_email(@customer['email']) 
      user.update(status: 1 )
      if @plan == "monthly"
        res = 30
      else @plan == "annually"
        res = 365
      end
      user.transactions.create(
        amount: (@res['amount'].to_f)/100,
        channel: @res['channel'], 
        reference: @res['reference'],
        currency: @res['currency'], 
        status: @res['status'],
        gateway_response: @res['gateway_response'], 
        expires_on: Date.today + res.days,
        created_at: Time.now, 
        updated_at: Time.now
      )
    end
  end
end
