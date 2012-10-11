require_relative '../../app/presenters/theme_presentation'
require 'delegate'

class Model
  def to_model
    'model'
  end

  def name
    'model'
  end
end

class Presenter1 < SimpleDelegator
  def initialize(data)
    super(data)
  end

  def name
    'Presenter1'
  end
end

class Presenter2 < SimpleDelegator
  def initialize(data)
    super(data)
  end

  def name
    'Presenter2'
  end
end

describe ThemePresentation do
  describe '.wrap(data, *presenters)' do
    describe 'when data is a hash' do
      let(:hash) { { key: 'value' } }

      it 'returns a struct instead of a hash' do
        ThemePresentation.wrap(hash).key.should == 'value'
      end

      it 'can wrap hashes as well' do
        data = ThemePresentation.wrap(hash, Presenter1, nil)
        data.key.should == 'value'
      end
    end

    describe 'when data is a hash with an array of hashes' do
      let :hash do
        {
          key: 'value',
          array: [
            {
              key: 'value'
            },
            {
              another_key: 'another value'
            }
          ]
        }
      end

      it 'returns a nested struct' do
        ThemePresentation.wrap(hash).array[0].key.should == 'value'
        ThemePresentation.wrap(hash).array[1].another_key.should == 'another value'
      end
    end

    describe 'when data is a model object' do
      it "should return a class of type Model" do
        ThemePresentation.wrap(Model.new).should be_a(Model)
      end

      it "should return the model" do
        ThemePresentation.wrap(Model.new).to_model.should == 'model'
      end
    end

    describe 'when presenters are passed in' do
      before do
        @data = ThemePresentation.wrap(Model.new, Presenter1, Presenter2, nil)
      end

      it 'exposes which presenters have wrapped it' do
        @data.wrapped_by.should == [Presenter1, Presenter2]
      end

      it 'wraps in order' do
        @data.name.should == 'Presenter2'
      end
    end
  end

  describe '.wrap_collection(collection, *presenters)' do
    before do
      @collection = ThemePresentation.wrap_collection([Model.new, Model.new, Model.new], Presenter1, Presenter2, nil)
    end

    it 'wraps each item in the collection' do
      @collection.each do |item|
        item.wrapped_by.should == [Presenter1, Presenter2]
      end
    end
  end
end
