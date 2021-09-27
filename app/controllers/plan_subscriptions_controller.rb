class PlanSubscriptionsController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]
  #before_action :verify_sub, only: [:new]

  #Webhook Url for Paystack after payment to create subscription /start 

  def success
    if params[:reference].present?
      paystackObj = Paystack.new(ENV['PAYSTACK_PUBLIC_KEY'], ENV['PAYSTACK_PRIVATE_KEY'])
      plan_subscriptions = PaystackSubscriptions.new(paystackObj)
      result = subscriptions.create(
        :customer => current_user.email,
        :plan => "PLN_xc9vnk0qixif2m1", #plan id
        :amount => 50000 #in KOBO       
      )


      u = current_user
      u.subscribed_to_plan = true
      u.plan_subscription_code = code
      u.email_token = token
      u.save!
    
    else
      redirect_to new_plan_subscription_path, notice: "Error Making Payment, Try Again"
    end
  end

  #End

  def new
    
  end

  def show
    res = 0
    @paystackObj = Paystack.new(ENV['PAYSTACK_PUBLIC_KEY'], ENV['PAYSTACK_PRIVATE_KEY'])
    transaction_reference = params[:trxref]
    transactions = PaystackTransactions.new(@paystackObj)
    result = transactions.verify(transaction_reference)
    @res = result['data']
    @customer = result['data']['customer']
    
    if @res['status'] == "success"
      user = current_user.email 
      user.update(status: 1 )
  
        
      if user.interval == "monthly"
        res = 30
      elsif user == "annually"
        res = 365
      end
        
  
      user.plan_subscriptions.create(
        amount: (@res['amount'].to_f)/100,
        channel: @res['channel'], 
        reference: @res['reference'], 
        gateway_response: @res['gateway_response'], 
        status: "success", 
        gateway_response: @res['gateway_response'],
        currency: @res['currency'], 
        status: @res['status'], 
        expires_on: Date.today + res.days,
        created_at: Time.now, 
        updated_at: Time.now
      )
    end
  end
  
  def create
    paystackObj = Paystack.new(ENV['PAYSTACK_PUBLIC_KEY'], ENV['PAYSTACK_PRIVATE_KEY'])

    transactions = PaystackTransactions.new(paystackObj)
    result = transactions.initializeTransaction(
    :reference => "#{current_user.id}__#{rand.to_s[2..10]}",
    :amount => 50000,
    :email => current_user.email,
    )
    
    auth_url = result['data']['authorization_url']
    redirect_to auth_url
  end

  def disable
    paystackObj = Paystack.new(ENV['PAYSTACK_PUBLIC_KEY'], ENV['PAYSTACK_PRIVATE_KEY'])
    plan_subscriptions = PaystackSubscriptions.new(paystackObj)
    result = plan_subscriptions.disable(
        :code => "12328833",
        :token => "EWFWKFJWE" #user email token
      )
  end

  def enable
    paystackObj = Paystack.new(ENV['PAYSTACK_PUBLIC_KEY'], ENV['PAYSTACK_PRIVATE_KEY'])
    plan_subscriptions = PaystackSubscriptions.new(paystackObj)
    result = plan_subscriptions.enable(
        :code => "12328833",
        :token => "EWFWKFJWE" #user email token
      )
  end

  private 

  def verify_sub
    if current_user.subscribed_to_plan == true 
      redirect_to dashboard_path(current_user.full_name)
    end
  end
end
