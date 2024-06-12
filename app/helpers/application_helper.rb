module ApplicationHelper
  include Pagy::Frontend

  def flash_class(level)
    case level
      when :notice then "alert alert-info"
      when :success then "alert alert-success"
      when :error then "alert alert-error"
      when :alert then "alert alert-error"
    end
  end
  
  def device
    agent = request.user_agent
    return "tablet" if agent =~ /(tablet|ipad)|(android(?!.*mobile))/i
    return "mobile" if agent =~ /Mobile/
    return "desktop"
  end

  def crud_label(key)
    case key
    when 'create'
      "<i class='fa fa-plus'></i>".html_safe
    when 'update'
      "<i class='fa fa-pen'></i>".html_safe
    when 'destroy'
      "<i class='fa fa-trash'></i>".html_safe
    end
  end

  def model_label(model)
    case model
    when 'Course'
      "<i class='fa fa-graduation-cap'></i>".html_safe
    when 'Lesson'
      "<i class='fa fa-check-square'></i>".html_safe
    when 'Enrollment'
      "<i class='fa fa-lock-open'></i>".html_safe
    when 'Comment'
      "<i class='fa fa-comment'></i>".html_safe
    end
  end

  def boolean_label(value)
    case value
    when true
      content_tag(:span, value, class: 'badge badge-success')
    when false
      content_tag(:span, value, class: 'badge badge-danger')
    end
  end
  
  def resource_name
    :user
  end
    
  def resource_class 
    User 
  end
    
  def resource
    @resource ||= User.new
  end
    
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def author_of(resource)
    user_signed_in? && resource.user_id == current_user.id
  end

  def admin?
    user_signed_in? && current_user.admin?
  end

  def available_plans
    SubscriptionPlan.active.order(:cost) # Assuming active plans
  end

  def truncate_html(text, length = 300, omission = '...')
    doc = Nokogiri::HTML::DocumentFragment.parse(text)
    content_length = 0

    doc.traverse do |node|
      if node.text?
        content_length += node.text.length
        if content_length > length
          node.content = node.text[0, length - content_length + node.text.length] + omission
          break
        end
      end
    end

    doc.to_html.html_safe
  end
  
end