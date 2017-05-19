module ApplicationHelper
  def markdown(text)
    options = {
      filter_html:     true,
      hard_wrap:       true,
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true,
      fenced_code_blocks: true
    }

    extensions = {
      autolink:           true,
      superscript:        true,
      disable_indented_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end

  def resource_name
    :user
  end

  def resource
      @resource ||= User.new
  end

  def resource_class
      User
  end

  def devise_mapping
      @devise_mapping ||= Devise.mappings[:user]
  end

  def avatar_url(user, size)
  gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
  "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=identicon"
  end
  # 配置默认头像为 gravatar

  def render_user_avatar(user, size)
    if user.avatar.present?
      user.avatar.mini
    else
      avatar_url(user, size)
    end
  end
  # 如果有头像的话显示头像

  def render_user_avatar_thumb(user, size)
    if user.avatar.present?
      user.avatar.thumb
    else
      avatar_url(user, size)
    end
  end
end
