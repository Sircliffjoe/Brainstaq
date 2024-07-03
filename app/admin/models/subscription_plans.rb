ActiveAdmin.register SubscriptionPlan do
  permit_params :plan_name, :cost, :description, :recurring, :paystack_plan_code, :status, :duration,
                features_attributes: [:id, :name, :description, :_destroy]

  index do
    selectable_column
    id_column
    column :plan_name
    column :cost do |plan|
      number_to_currency(plan.cost, unit: "₦")
    end
    column :description
    column :recurring
    column :paystack_plan_code
    column :status
    column :duration
    actions
  end

  filter :plan_name
  filter :cost
  filter :recurring
  filter :status
  filter :duration

  show do
    attributes_table do
      row :plan_name
      row :cost do |plan|
        number_to_currency(plan.cost, unit: "₦")
      end
      row :description
      row :recurring
      row :paystack_plan_code
      row :status
      row :duration
      row :created_at
      row :updated_at
    end

    panel "Features" do
      table_for subscription_plan.features do
        column :id
        column :name
        column :description
        # actions
      end
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs "Subscription Plan Details" do
      f.input :plan_name
      f.input :cost
      f.input :description
      f.input :recurring
      f.input :paystack_plan_code
      f.input :status
      f.input :duration
    end

    f.inputs "Features" do
      f.has_many :features, allow_destroy: true, new_record: true do |feature_form|
        feature_form.input :name
        feature_form.input :description
      end
    end

    f.actions
  end
end