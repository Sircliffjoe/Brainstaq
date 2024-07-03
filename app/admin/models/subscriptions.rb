ActiveAdmin.register Subscription do
  permit_params :user_id, :subscription_plan_id, :start_date, :end_date, :transaction_reference, :plan_id, :status

  index do
    selectable_column
    id_column
    column :user
    column :subscription_plan
    column :start_date
    column :end_date
    column :transaction_reference
    column :plan_id
    column :status
    column :created_at
    column :updated_at
    actions
  end

  filter :user
  filter :subscription_plan
  filter :start_date
  filter :end_date
  filter :transaction_reference
  filter :plan_id
  filter :status
  filter :created_at
  filter :updated_at

  show do
    attributes_table do
      row :user
      row :subscription_plan
      row :start_date
      row :end_date
      row :transaction_reference
      row :plan_id
      row :status
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs "Subscription Details" do
      f.input :user
      f.input :subscription_plan, as: :select, collection: SubscriptionPlan.all.map { |sp| [sp.plan_name, sp.id] }
      f.input :start_date, as: :datepicker
    end

    f.actions
  end
end