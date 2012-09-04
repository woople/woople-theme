class ExplicitDelegator < SimpleDelegator
  def self.enforce_definitions(*methods)
    define_method(:enforced_methods) do
      super() | methods
    end
  end

  def initialize(obj)
    super(obj)
    ensure_defined
  end

  def enforced_methods
    []
  end

  def ensure_defined
    missing_methods = []
    enforced_methods.each do |method|
      missing_methods << method unless __getobj__.methods.include?(method)
    end
    raise "Methods required to use #{self.class}: #{missing_methods}" unless missing_methods.empty?
  end
end
