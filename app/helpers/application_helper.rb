module ApplicationHelper

  def warden
    request.env['warden']
  end

  def avatar_url(user, s = 48)
    if false #user.avatar_url.present?
      #user.avatar_url
    else
      default_url = "#{root_url}images/guest.png"
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{s}&d=#{CGI.escape(default_url)}"
    end
  end

  def avatar_alt(user)
    if user.profile.name
      user.profile.name + "'s Photo"
    else
      user.email + "'s Photo"
    end
  end

  def title_by_path(path)
    # path = ROOT_ROUTE if path == "/"
    title(controller_name_by_path(path))
  end

  def title(controller_name)
    t "controller.#{controller_name}.title", :default => controller_name.camelize
  end

  def description_by_path(path)
    # path = ROOT_ROUTE if path == "/"
    description(controller_name_by_path(path))
  end

  def description(controller_name)
    t "controller.#{controller_name}.description", :default => controller_name.camelize
  end

  def controller_name_by_path(path)
    begin
      controller_name = Rails.application.routes.recognize_path(path)[:controller]
    rescue
      controller_name = Rails.application.routes.recognize_path(path, {:method => :post})[:controller]
    end
    controller_name = controller_name.split('/')[1] if controller_name.index '/' # handle namespace
    controller_name
  end


  def default_url(path)
    # path = ROOT_ROUTE if path == "/"
    begin
      controller_name = Rails.application.routes.recognize_path(path)[:controller]
      url_for :controller => controller_name, :action => 'index'
    rescue
      request.path
    end
  end

  def number_to_euro(amount)
    number_to_currency(amount, :unit => '€', :separator => ',', :delimiter => '.', format: '%n %u')
  end

  def admin_mode?
    controller.class.name.split('::').first == 'Admin'
  end

  def current_app_version_int
    if @client_uuid
      device = Device.find_by(uuid: @device_uuid)
      device.app_version_int
    else
      9999999
    end
  end

  def current_os
    if @client_uuid
      device = Device.find_by(uuid: @device_uuid)
      device.os
    else
      'webservice'
    end
  end

  def wicked_pdf_image_tag_for_public(img, options={})
    if img[0] == "/"
      new_image = img.slice(1..-1)
      image_tag "file://#{Rails.root.join('public', new_image)}", options
    else
      image_tag "file://#{Rails.root.join('public', 'images', img)}", options
    end
  end

  def sort_column(model)
    (model.column_names).include?(params[:sort].to_s) ? params[:sort].to_s : :id.to_s
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def sort_search(active_relation)
    active_relation.order(sort_column(active_relation.model).to_s + " " + sort_direction)
  end

  def sortable(model, column, title = nil)
    title ||= column.to_s.titleize
    css_class = column.to_s == sort_column(model) ? "current #{sort_direction}" : nil
    direction = css_class && sort_direction == "asc" ? "desc" : "asc"
    link_to(title, params.merge({:sort => column, :direction => direction}), {:class => css_class}) + (params[:sort] && css_class ? (sort_direction == "asc" ? ascending_span : descending_span) : '').html_safe
  end

  def ascending_span
    ' '.html_safe + content_tag(:span, '', :class => %w[glyphicon glyphicon-chevron-up])
  end

  def descending_span
    ' '.html_safe + content_tag(:span, '', :class => %w[glyphicon glyphicon-chevron-down])
  end

  def hidden_alert_dialog(id, title, body = nil, &block)
    body = capture(&block) if block_given?
    render partial: 'shared/alert_modal', locals: { id: id, title: title, body: body }
  end

end
