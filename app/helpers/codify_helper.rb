module CodifyHelper
  def codify(&block)
    content = capture(&block)

    preview = content_tag(:div, class: 'well') { content }

    code = content_tag(:pre, class: 'prettyprint') do
      CGI.escapeHTML(content).html_safe
    end

    show_source = content_tag(:a, 'Show Source', class: 'show_source')

    content_tag(:div, class: 'codify') do
      preview + code + show_source
    end
  end
end
