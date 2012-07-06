require 'spec_helper'
require 'explicit_delegator'

class MyPresenterClass < ExplicitDelegator
end

describe ExplicitDelegator do
  obj = OpenStruct.new({hello: "sir", how: "are you", this: "fine day?"})
  delegator = ExplicitDelegator.new(obj)

  it "can expose the obj" do
    delegator.__getobj__.should eq(obj)
  end

  it "doesn't expose obj methods automatically" do
    delegator.respond_to?(:hello).should == false
    delegator.respond_to?(:how).should == false
    delegator.respond_to?(:this).should == false
  end

  # Adding an instance method to a class doesn't get torn down between tests.
  # Need to define then undefine methods in the same tests that use them
  context "calling delegate methods" do

    it "should create the new methods" do
      ExplicitDelegator.delegate_methods(:hello, :how)

      ExplicitDelegator.instance_methods.should include(:hello, :how)
      ExplicitDelegator.instance_methods.should_not include(:this)

      ExplicitDelegator.send(:remove_method, :hello)
      ExplicitDelegator.send(:remove_method, :how)
    end

    it "exposes the methods on obj" do
      ExplicitDelegator.delegate_methods(:hello, :how)

      delegator.hello.should == "sir"
      delegator.how.should == "are you"
      delegator.respond_to?(:this).should == false

      ExplicitDelegator.send(:remove_method, :hello)
      ExplicitDelegator.send(:remove_method, :how)
    end

  end

  context "object inheriting from explicit delegator" do
    my_delegator = MyPresenterClass.new(obj)

    it "should only define instance methods on the immediate class" do
      MyPresenterClass.delegate_methods(:yo, :dude)

      MyPresenterClass.instance_methods.should include(:yo, :dude)
      ExplicitDelegator.instance_methods.should_not include(:yo, :dude)

      MyPresenterClass.send(:remove_method, :yo)
      MyPresenterClass.send(:remove_method, :dude)
    end

  end

end

