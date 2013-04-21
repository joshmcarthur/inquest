module ApplicationHelper

  def glyph(icon, size = 1, classes = "")
    content_tag(:i, '', :class => "icon-#{icon} #{size > 1 ? "icon-#{size}x" : nil} #{classes}".strip)
  end

  def inline_user_display(user)
    link_to user, :class => 'inline-user-display' do
      image_tag(user.gravatar_url(:size => 16)) + user.username
    end
  end

  def badge(number, extra_classes = "badge-info")
    content_tag :span, number.to_s, :class => "badge #{extra_classes}"
  end
end
