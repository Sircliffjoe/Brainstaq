ActiveAdmin.register User do

  permit_params :first_name, :last_name, :username, :bio, :email, :country, :website, :phone, :gender, 
                :facebook_url, :twitter_url, :instagram_url, :linkedin_url, :image, 
                user_lessons_attributes: [:id, :lesson_id, :_destroy], 
                ideas_attributes: [:id, :title, :description, :_destroy], 
                enterprise_attributes: [:id, :name, :address, :email, :phone_number, :country, :state, :city, :info, :_destroy], 
                business_plans_attributes: [:id, :title, :description, :_destroy], 
                comments_attributes: [:id, :content, :_destroy], 
                conversations_attributes: [:id, :subject, :_destroy]

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :username
    column :email
    column :country
    column :phone
    column :gender
    column :subscribed_to_plan
    column :plan
    column :status
    column :created_at
    column :updated_at
    actions
  end

  filter :first_name
  filter :last_name
  filter :username
  filter :email
  filter :country
  filter :gender
  filter :subscribed_to_plan
  filter :plan
  filter :status
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs "User Details" do
      f.input :first_name
      f.input :last_name
      f.input :username
      f.input :bio
      f.input :email
      f.input :country, as: :hidden, input_html: { value: 'Nigeria' }
      f.input :website
      f.input :phone
      f.input :gender
      f.input :facebook_url
      f.input :twitter_url
      f.input :instagram_url
      f.input :linkedin_url
    end

    f.inputs 'Images' do
      f.input :image, as: :file
    end

    f.actions
  end

  show do
    attributes_table do
      row :id
      row :first_name
      row :last_name
      row :username
      row :bio
      row :email
      row :country
      row :website
      row :phone
      row :gender
      row :image do |user|
        if user.image.url
          image_tag user.image.url, size: "200x200" # Adjust the size as needed
        else
          "No image found"
        end
      end
      row :facebook_url
      row :twitter_url
      row :instagram_url
      row :linkedin_url
      row :subscribed_to_plan
      row :plan
      row :status
      row :enterprise_count
      row :business_plan_count
      row :created_at
      row :updated_at
    end

    panel "Courses" do
      table_for user.courses do
        column :id
        column :title
        column :description
      end
    end

    panel "Enrollments" do
      table_for user.enrollments do
        column :id
        column :course_id
        column :status
      end
    end

    panel "User Lessons" do
      table_for user.user_lessons do
        column :id
        column :lesson_id
        column :status
      end
    end

    panel "Ideas" do
      table_for user.ideas do
        column :id
        column :title
        column :description
      end
    end

    panel "Enterprise" do
      table_for [user.enterprise] do
        column :id
        column :name
        column :description
      end
    end

    panel "Business Plans" do
      if user.enterprise && user.enterprise.business_plans.any?
        table_for user.enterprise.business_plans do
          column :id
          column :title
          column :description
          # other business plan attributes...
        end
      else
        div do
          "No Business Plans found"
        end
      end
    end

    panel "Donations" do
      table_for user.donations do
        column :id
        column :amount do |user|
          number_to_currency(user.amount, unit: '₦', precision: 0)
        end
        column :status
      end
    end

    panel "Comments" do
      table_for user.comments do
        column :id
        column :content
      end
    end

    panel "Conversations" do
      table_for user.conversations do
        column :id
        column :subject
      end
    end

    panel "Visits" do
      table_for user.visits do
        column :id
        column :ip
      end
    end

    panel "Followers" do
      table_for user.followers do
        column :id
        column :username
      end
    end

    panel "Followees" do
      table_for user.followees do
        column :id
        column :username
      end
    end

  end

  # controller do
  #   def scoped_collection
  #     super.includes(:courses, :enrollments, :user_lessons, :students, :lessons, :ideas, 
  #     :enterprise, :business_plans, :donations, :comments, :conversations, :visits, :followed_users, 
  #     :following_users)
  #   end
  # end
  
end
