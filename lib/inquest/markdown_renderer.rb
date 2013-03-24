require 'redcarpet'

class Inquest::MarkdownRenderer
  def initialize
    @engine ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, self.redcarpet_extensions)
  end

  def render(text)
    @engine.render(text)
  end

  def redcarpet_extensions
    {:no_intra_emphasis => true, :tables => true, :fenced_code_blocks => true, :autolink => true, :lax_spacing => true}
  end
end