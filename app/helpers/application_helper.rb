module ApplicationHelper

  def glyph(icon, size = 1)
    content_tag(:i, '', :class => "icon-#{icon} #{size > 1 ? "icon-#{size}x" : nil}")
  end
end
