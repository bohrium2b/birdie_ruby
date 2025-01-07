require 'redcarpet'

def initialize_markdown_renderer
  @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
end