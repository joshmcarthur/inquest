module Inquest::ContentMarkdownable
  def self.included(base)
    base.class_eval do
      # Public: Render the Markdown content of this question as HTML.
      #
      # This method uses the Redcarpet library to convert the Markdown
      # question content into HTML for rendering into a view.
      #
      # #FIXME it should also handle sanitizing the output, stripping potentially
      # dangerous or disallowed tags.
      #
      # Returns the generated HTML for the question content
      def content_html
        Inquest::Application.config.markdown_renderer.render(self.content).html_safe
      end
    end
  end
end