class FrameworkController < ApplicationController
  layout 'theme'

  helper_method :menu_model

  def menu_model
    [introduction, components] #, look_and_feel, typography, urls, performance_and_metrics]
  end

  def introduction
    {
      links: [ { name: 'Introduction', url: '#introduction', featured: true } ]
    }
  end

  def components
    {
      name: 'Components',
      links: [
        { name: 'Page Header', url: '#page_header' },
        { name: 'Content Items', url: '#content_items' },
        { name: 'Content Item Header', url: '#content_item_header' },
        { name: 'Video Modal', url: '#video_modal' },
        { name: 'Outline', url: '#outline' },
        { name: 'Profile', url: '#profile' },
        { name: 'Menu', url: '#menu' }
      ]
    }
  end

  def look_and_feel
    {
      name: 'Look & Feel',
      links: [
        { name: 'Emotions', url: '#emotions' },
        { name: 'Flexibility', url: '#flexibility' },
        { name: 'Palette', url: '#colours' }
      ]
    }
  end

  def typography
    {
      name: 'Typography',
      links: [
        { name: 'Fonts', url: '#fonts' },
        { name: 'Type Sizes', url: '#type_sizes' },
        { name: 'Spacing', url: '#spacing' }
      ]
    }
  end

  def urls
    {
      name: 'URL Structure',
      links: [
        { name: 'Philosophy', url: '#url_philosophy' },
        { name: 'Page URLs', url: '#page_urls' },
        { name: 'Addressability', url: '#addressability' }
      ]
    }
  end

  def performance_and_metrics
    {
      name: 'Performance & Metrics',
      links: [
        { name: 'Fast', url: '#fast' },
        { name: 'Feature Validation', url: '#feature_validation' }
      ]
    }
  end
end
