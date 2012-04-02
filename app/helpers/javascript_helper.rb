module JavascriptHelper
  def application_javascript
    javascript_include_tag(WoopleTheme.configuration.layout_javascript) if WoopleTheme.configuration.layout_javascript.present?
  end
end
