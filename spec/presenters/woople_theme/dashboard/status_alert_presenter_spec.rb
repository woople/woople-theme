require 'spec_helper'

describe WoopleTheme::Dashboard::StatusAlertPresenter do
  describe '#css_class' do
    context 'red status' do
      subject do
        data = OpenStruct.new({ color: :red, description: 'FOO' })
        WoopleTheme::Dashboard::StatusAlertPresenter.new(data).css_class
      end

      it 'returns alert-error' do
        should eq('alert-error')
      end
    end

    context 'yellow status' do
      subject do
        data = OpenStruct.new({ color: :yellow, description: 'FOO' })
        WoopleTheme::Dashboard::StatusAlertPresenter.new(data).css_class
      end

      it 'returns nil' do
        should be_nil
      end
    end

    context 'green status' do
      subject do
        data = OpenStruct.new({ color: :green, description: 'FOO' })
        WoopleTheme::Dashboard::StatusAlertPresenter.new(data).css_class
      end

      it 'returns alert-success' do
        should eq('alert-success')
      end
    end
  end

  describe '#color' do
    subject do
      data = OpenStruct.new({ color: :red, description: 'FOO' })
      WoopleTheme::Dashboard::StatusAlertPresenter.new(data).color
    end

    it 'returns a capitalized string' do
      should eq('Red')
    end
  end
end
