ActiveAdmin.register Category do
  permit_params :name, idea_ids: [], enterprise_ids: []

  index do
    selectable_column
    id_column
    column :name
    column :created_at
    column :updated_at
    actions
  end

  filter :name
  filter :created_at
  filter :updated_at

  # show do
  #   attributes_table do
  #     row :name
  #     row :created_at
  #     row :updated_at
  #   end

  #   panel "Ideas" do
  #     table_for category.ideas do
  #       column :id
  #       column :title
  #       column :description
  #       column :created_at
  #       column :updated_at
  #       actions
  #     end
  #   end

  #   panel "Enterprises" do
  #     table_for category.enterprises do
  #       column :id
  #       column :name
  #       column :address
  #       column :email
  #       column :phone_number
  #       column :created_at
  #       column :updated_at
  #       actions
  #     end
  #   end
  # end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs "Category Details" do
      f.input :name
    end

    f.actions
  end
end