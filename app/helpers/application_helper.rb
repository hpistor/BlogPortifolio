module ApplicationHelper
  require 'redcarpet'
  require 'rouge'
  require 'rouge/plugins/redcarpet'

  class HTML < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet
  end


  def markdown(content)

    options = {
        filter_html: true,
        hard_wrap: true,
        autolink: true,
        no_intra_emphasis: true,
        disable_indented_code_blocks: true,
        lax_html_blocks: true,
        strikethrough: true,
        superscript: true,
        fenced_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    Redcarpet::Markdown.new(renderer, options).render(content).html_safe
  end

  def tag_cloud(tags, classes)
    max = tags.max_by(&:count)
    tags2 = tags.order('count desc')
    tags2.each do |tag|
      puts tag.name
      index = tag.count.to_f / max.count * (classes.size - 1)
      yield(tag, classes[index.round])
    end
  end

end