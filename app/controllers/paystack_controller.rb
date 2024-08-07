class PaystackController < ApplicationController
  skip_before_action :verify_authenticity_token
  protect_from_forgery :except => :receive
  before_action :check_allowed_ip, only: [:receive]

 
  SECRET_KEY = ENV["PAYSTACK_SECRET_KEY"]

  def webhook
    if check_allowed_ip == true
      request_headers = request.headers
      payload = JSON.parse(request.body.read)
      data = JSON.generate(payload)
      digest = OpenSSL::Digest.new('sha512')
      hash = OpenSSL::HMAC.hexdigest(digest, SECRET_KEY, data)
      unless hash != request_headers["x-paystack-signature"]
        if payload['event'] == 'charge.success' && payload['data']['status'] == 'success'
          user = get_user(payload)
          event_charge_date = Date.strptime(payload['data']['paid_at']).to_date
          if user && event_charge_date != user.account_detail.subscribe_date.to_date
            if member.paystack_charges.empty? || user.paystack_charges.last.created_at.today? == false
              amount = payload["data"]["amount"]
              options = process_payload(payload, user)
              ProcessWebhookJob.perform_later options
              head :ok
            else
              head :unprocessable_entity
            end
          end
        end
      end
    else
      render status: 401, json: {
        message: "Unauthorized"
      }
    end
  end

  def process_payload(payload, user)
    amount = payload["data"]["amount"]
    description = "Subscription Renewal Paystack"
    payload["user_id"] = user.id
    payload["description"] = description
    payload["amount"] = amount
    options = payload.to_hash
    return options
  end

  def get_user(payload)
    customer_code = payload["data"]["customer"]["customer_code"]
    donor = User.find_by(paystack_cust_code: customer_code)
    return donor
  end


  private

  def check_allowed_ip
    whitelisted = ['41.58.96.208', '52.31.139.75', '52.49.173.169', '52.214.14.220', '127.0.0.1']
    if whitelisted.include? request.remote_ip
      return true
    else
      return false
    end
  end
end