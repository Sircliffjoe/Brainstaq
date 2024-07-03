ActiveAdmin.register Idea do
  permit_params :title, :description, :image, :upvotes, :downvotes, :total_comments,
                :user_id, :relevance_bar, :slug, :overview, :challenges, :impact,
                :donation_goal, :donated_amount, :status, :donations_count, :end_date,
                :category_id, images: [], perks_attributes: [:id, :title, :_destroy]

  # Form configuration
  form do |f|
    f.inputs 'Idea Details' do
      f.input :title
      f.input :description
      f.input :image, as: :file
      f.input :user
      f.input :category
      f.input :overview
      f.input :challenges
      f.input :impact
      f.input :donation_goal
      f.input :end_date, as: :datepicker
    end

    f.inputs 'Images' do
      f.input :images, as: :file, input_html: { multiple: true }
    end

    f.inputs 'Perks' do
      f.has_many :perks, allow_destroy: true, new_record: true do |p|
        p.input :title
        p.input :amount
        p.input :description
      end
    end

    f.actions
  end

  # Index page configuration
  index do
    selectable_column
    id_column
    column :title
    column :upvotes
    column :downvotes
    column :total_comments
    column :user
    column :category
    column 'Relevance Bar (%)', :relevance_bar do |idea|
      number_to_percentage(idea.relevance_bar, precision: 0)
    end
    column 'Donation Goal (₦)', :donation_goal do |idea|
      number_to_currency(idea.donation_goal, unit: '₦', precision: 0)
    end
    column 'Donated Amount (₦)', :donated_amount do |idea|
      number_to_currency(idea.donated_amount, unit: '₦', precision: 0)
    end
    column :status
    column :donations_count
    column :end_date
    actions
  end

  # Show page configuration
  show do
    attributes_table do
      row :title
      row :description do |idea|
        idea.description.to_s.include?("class") ? idea.description.body.to_s.html_safe : simple_format(idea.description)
      end
      row :upvotes
      row :downvotes
      row :total_comments
      row :user
      row :category
      row :relevance_bar do |idea|
        number_to_percentage(idea.relevance_bar, precision: 0)
      end
      row :slug
      row :overview do |idea|
        idea.overview.to_s.include?("class") ? idea.overview.body.to_s.html_safe : simple_format(idea.overview)
      end
      row :challenges do |idea|
        idea.challenges.to_s.include?("class") ? idea.challenges.body.to_s.html_safe : simple_format(idea.challenges)
      end
      row :impact do |idea|
        idea.impact.to_s.include?("class") ? idea.impact.body.to_s.html_safe : simple_format(idea.impact)
      end
      row :donation_goal do |idea|
        number_to_currency(idea.donation_goal, unit: '₦', precision: 0)
      end
      row :donated_amount do |idea|
        number_to_currency(idea.donated_amount, unit: '₦', precision: 0)
      end
      row :status
      row :donations_count
      row :end_date
      row :image do |idea|
        if idea.image.url
          image_tag idea.image.url, size: "300x200" # Adjust the size as needed
        else
          "No image available"
        end
      end
    end

    panel 'Perks' do
      table_for idea.perks do
        column :title
      end
    end

  end

  # Filter configuration
  filter :title
  filter :description
  filter :user
  filter :category
  filter :relevance_bar
  filter :donation_goal
  filter :donated_amount
  filter :status
  filter :donations_count
  filter :end_date
end