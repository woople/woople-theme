require 'ostruct'

class ThemePresentation
  def self.wrap(data, *presenters)
    normalized = normalize(data)
    presenters = normalize_presenters(presenters)

    wrapped_data = presenters.inject(normalized) do |wrapped, presenter|
      presenter.new(wrapped)
    end

    class << wrapped_data
      attr_accessor :wrapped_by
    end

    wrapped_data.wrapped_by = presenters

    wrapped_data
  end

  def self.wrap_collection(collection, *presenters)
    collection.collect { |item| wrap(item, *presenters) }
  end

  private

  def self.normalize(data)
    if data.is_a? Hash
      hash = {}
      data.each { |key, value| hash[key] = normalize value }
      OpenStruct.new hash
    elsif data.is_a? Array
      data.collect { |datum| normalize datum }
    else
      data
    end
  end

  def self.normalize_presenters(presenters)
    presenters.reject!(&:nil?)
    presenters
  end
end
