module ContentImage
  def image(&block)
    yield(__getobj__.image || 'woople-theme/missing.png') if __getobj__.respond_to? :image
  end
end
