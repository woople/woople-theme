class ExplicitDelegator

  def initialize(obj)
    @obj = obj
  end

  def __getobj__
    @obj
  end

  def self.delegate_methods(*methods)
    methods.each do |method|
      define_method(method) do
        __getobj__.send(method)
      end
    end
  end

end