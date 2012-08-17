require 'spec_helper'

describe DashboardHelper do
  describe '#status_alert' do
    context 'description' do
      subject { helper.status_alert(:red, 'FOO') }

      it 'outputs the description as is' do
        page = Capybara::Node::Simple.new(subject)
        page.find('span').text.should eq('FOO')
      end
    end

    context 'red status' do
      subject { helper.status_alert(:red, 'FOO') }

      it 'has the required css classes and data' do
        page = Capybara::Node::Simple.new(subject)
        page.should have_css('.alert.alert-error.status-alert')
        page.find('.alert-heading').text.should eq('Red')
      end
    end

    context 'yellow status' do
      subject { helper.status_alert(:yellow, 'FOO') }

      it 'has the required css classes and data' do
        page = Capybara::Node::Simple.new(subject)
        page.should have_css('.alert.status-alert')
        page.find('.alert-heading').text.should eq('Yellow')
      end
    end

    context 'green status' do
      subject { helper.status_alert(:green, 'FOO') }

      it 'has the required css classes and data' do
        page = Capybara::Node::Simple.new(subject)
        page.should have_css('.alert.alert-success.status-alert')
        page.find('.alert-heading').text.should eq('Green')
      end
    end
  end
end
