require 'forwardable'

class ExplicitDelegator
  extend Forwardable

  def self.enforce_definitions(*methods)
    define_method(:enforced_methods) do
      super() | methods
    end

    methods.each do |method|
      def_instance_delegator(:@delegate, method)
    end
  end

  def initialize(delegate)
    @delegate = delegate

    ensure_defined
  end

  def enforced_methods
    []
  end

  def ensure_defined
    missing_methods = []
    enforced_methods.each do |method|
      missing_methods << method unless @delegate.methods.include?(method)
    end
    raise "Methods required to use #{self.class}: #{missing_methods}" unless missing_methods.empty?
  end
end
