require 'spec_helper'

class NoMethodClass < ExplicitDelegator
end

class OneMethodClass < ExplicitDelegator
  enforce_definitions :one
end

class TwoMethodClass < ExplicitDelegator
  enforce_definitions :one, :two
end

class Parent < ExplicitDelegator
  enforce_definitions :parent_method, :shared_method
end

class Child < Parent
  enforce_definitions :child_method, :shared_method
end

describe ExplicitDelegator do
  obj_none = OpenStruct.new({})
  obj_one = OpenStruct.new({one: 1})
  obj_two = OpenStruct.new({one: 1, two: 2})

  describe NoMethodClass do
    it "should not raise any exceptions" do
      NoMethodClass.new(obj_none)
      NoMethodClass.new(obj_one)
      NoMethodClass.new(obj_two)
    end
  end

  describe OneMethodClass do
    it "should only raise an exeption when the :one method is not defined" do
      expect { OneMethodClass.new(obj_none) }.to raise_error
      OneMethodClass.new(obj_one)
      OneMethodClass.new(obj_two)
    end
  end

  describe TwoMethodClass do
    it "should only raise an exception when either the :one or :two methods are not defined" do
      expect { TwoMethodClass.new(obj_none) }.to raise_error
      expect { TwoMethodClass.new(obj_one) }.to raise_error
      OneMethodClass.new(obj_two)
    end
  end

  describe '::enforce_definitions' do
    it 'should raise a runtime error with a list of required methods (including inherited methods, unduplicated)' do
      expect { Child.new(OpenStruct.new) }.to raise_error(RuntimeError, 'Methods required to use Child: [:parent_method, :shared_method, :child_method]')
    end
  end
end
