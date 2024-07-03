ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation, :first_name, :last_name, :username

  index do
    selectable_column
    id_column
    column :first_name
    column :username
    column :last_name
    column :email
    actions
  end

  filter :email
  filter :username
  filter :first_name
  filter :last_name

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :username
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  show do
    attributes_table do
      row :first_name
      row :last_name
      row :username
      row :email
      row :created_at
      row :updated_at
    end
  end

end
