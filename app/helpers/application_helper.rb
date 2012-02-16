module ApplicationHelper
  def codify(&block)
    content = capture(&block)

    content_tag(:div, :class => "codify") do
      content1 = content_tag(:div, class: "well") do
        content
      end

      content2 = content_tag(:pre, class: "prettyprint linenums") do
        CGI.unescape(content)
      end

      link = content_tag(:a, "Show source", class: "show_source")

      content1 + content2 + link
    end
  end
end
