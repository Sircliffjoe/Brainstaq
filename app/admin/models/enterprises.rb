ActiveAdmin.register Enterprise do
  # Permit parameters
  permit_params :name, :address, :email, :phone_number, :country, :state, :image, :info, 
                :slug, :status, :city, :user_id, :category_id, :facebook_url, :twitter_url, 
                :instagram_url, :website_url, :interval, images: []

  # Index view
  index do
    selectable_column
    id_column
    column :name
    column :address
    column :email
    column :country
    column :state
    column :city
    column :user
    column :category
    column :status
    actions
  end

  # Form view
  form do |f|
    f.inputs 'Enterprise Details' do
      f.input :name
      f.input :address
      f.input :email
      f.input :phone_number
      f.input :country, as: :hidden, input_html: { value: 'Nigeria' }
      f.input :state
      f.input :city
      f.input :user
      f.input :category
      f.input :status
      f.input :facebook_url
      f.input :twitter_url
      f.input :instagram_url
      f.input :website_url
      f.input :info, as: :trix_editor
    end

    f.inputs 'Images' do
      f.input :image, as: :file
    end

    f.actions
  end

  # Show view
  show do
    attributes_table do
      row :name
      row :address
      row :email
      row :phone_number
      row :country
      row :state
      row :city
      row :user
      row :category
      row :status
      row :facebook_url
      row :twitter_url
      row :instagram_url
      row :website_url
      row :interval
      row :info do |enterprise|
        enterprise.info.to_s.html_safe
      end
      row :image do |enterprise|
        if enterprise.image.url
          image_tag enterprise.image.url
        else
          "No image available"
        end
      end
    end

  end

  # Filters
  filter :name
  filter :country
  filter :state
  filter :city
  filter :user
  filter :category
  filter :status
end