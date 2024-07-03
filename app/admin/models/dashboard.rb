# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do

    section "Statistics", style: "margin-bottom: 20px; padding: 10px; border: 1px solid #ddd; background-color: #f9f9f9;" do
      div style: "font-size: 16px; font-weight: bold;" do
        span "Total Ideas: #{Idea.count}", style: "margin-right: 20px;"
        span "Total Enterprises: #{Enterprise.count}", style: "margin-right: 20px;"
        span "Total Transactions: #{Transaction.count}", style: "margin-right: 20px;"
        span "All Courses: #{Course.count}", style: "margin-right: 20px;"
      end
    end

    section "Recent Ideas", style: "margin-bottom: 20px; padding: 10px; border: 1px solid #ddd; background-color: #f9f9f9;" do
      table_for Idea.order(created_at: :desc).limit(5).includes(:user, :category) do
        column :title
        column :user
        column :upvotes
        column :created_at
      end
      strong { link_to "View All Ideas", admin_ideas_path, style: "text-decoration: none; color: #0073e6;" }
    end

    section "Recent Enterprises", style: "margin-bottom: 20px; padding: 10px; border: 1px solid #ddd; background-color: #f9f9f9;" do
      table_for Enterprise.order(created_at: :desc).limit(5).includes(:user, :category) do
        column :name
        column :user
        column :status
        column :created_at
      end
      strong { link_to "View All Enterprises", admin_enterprises_path, style: "text-decoration: none; color: #0073e6;" }
    end

    section "Recent Transactions", style: "margin-bottom: 20px; padding: 10px; border: 1px solid #ddd; background-color: #f9f9f9;" do
      table_for Transaction.order(created_at: :desc).limit(5).includes(:enterprise) do
        column :enterprise
        column :amount do |transaction|
          number_to_currency(transaction.amount, unit: '₦', precision: 0)
        end
        column :status
        column :created_at
      end
      strong { link_to "View All Transactions", admin_transactions_path, style: "text-decoration: none; color: #0073e6;" }
    end

    section "Subscription Plans", style: "margin-bottom: 20px; padding: 10px; border: 1px solid #ddd; background-color: #f9f9f9;" do
      table_for SubscriptionPlan.order(created_at: :desc).limit(5) do
        column :plan_name
        column :cost do |plan|
          number_to_currency(plan.cost, unit: '₦', precision: 0)
        end
        column :duration
        column :status
      end
      strong { link_to "View All Subscription Plans", admin_subscription_plans_path, style: "text-decoration: none; color: #0073e6;" }
    end

    section "Recent Users", style: "margin-bottom: 20px; padding: 10px; border: 1px solid #ddd; background-color: #f9f9f9;" do
      table_for User.order(created_at: :desc).limit(5) do
        column :email
        column :username
        column :created_at
      end
      strong { link_to "View All Users", admin_users_path, style: "text-decoration: none; color: #0073e6;" }
    end

  end
end