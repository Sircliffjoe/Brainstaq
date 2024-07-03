ActiveAdmin.register Transaction do
  permit_params :channel, :status, :gateway_response, :customer_code, :currency, :reference, :amount, :expires_on, :enterprise_id

  index do
    selectable_column
    id_column
    column :channel
    column :gateway_response
    column :enterprise
    column :customer_code
    column :amount do |transaction|
      number_to_currency(transaction.amount, unit: '₦', precision: 0)
    end
    column :expires_on
    column :created_at
    actions
  end

  filter :gateway_response
  filter :reference
  filter :amount
  filter :expires_on
  filter :enterprise
  filter :created_at
  filter :updated_at

  show do
    attributes_table do
      row :channel
      row :status
      row :gateway_response
      row :customer_code
      row :currency
      row :reference
      row :amount do |transaction|
        number_to_currency(transaction.amount / 100.0)
      end
      row :expires_on
      row :enterprise
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs "Transaction Details" do
      f.input :channel
      f.input :status
      f.input :gateway_response
      f.input :customer_code
      f.input :currency
      f.input :reference
      f.input :amount
      f.input :expires_on, as: :datepicker
      f.input :enterprise
    end

    f.actions
  end
end