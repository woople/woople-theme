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

  describe "#essentials_section" do
    subject do
      helper.essentials_section({
        enabled?: true,
        essentials_remaining:  [stub(url:"/course",name:'remaining').as_null_object],
        essentials_completed:  [stub(url:"/course",time_total:0).as_null_object],
        essentials_exceptions: [stub(url:"/course").as_null_object]
      })
    end
    let(:page) { Capybara::Node::Simple.new(subject) }

    it "has the correct name for the essential remaining" do
      page.find(".content-item-content h2 a").text.should == 'remaining'
    end
  end

  describe "#completed_essentials" do
    it "renders a collection" do
      collection = [stub(url:"/course").as_null_object, stub(url:"/course").as_null_object, stub(url:"/course").as_null_object]
      helper.should_receive(:render_collection_partial).with(collection, WoopleTheme::Dashboard::CompletedEssentialPresenter, 'dashboard/completed_essential')
      helper.completed_essentials(collection)
    end
  end

  describe "#essentials_exceptions" do
    it "renders a collection" do
      collection = [stub(url:"/course").as_null_object, stub(url:"/course").as_null_object, stub(url:"/course").as_null_object]
      helper.should_receive(:render_collection_partial).with(collection, WoopleTheme::Dashboard::EssentialExceptionPresenter, 'dashboard/essential_exception')
      helper.essentials_exceptions(collection)
    end
  end

  describe "#total_courses" do
    it "renders the totals" do
      html = helper.total_courses(3)
      page = Capybara::Node::Simple.new(html)

      page.find('.total').text.should == I18n.t('woople_theme.dashboards.member.essentials_section.courses', count: 3)
    end
  end

  describe "#electives_section" do
    subject do
      helper.electives_section({
        enabled?: true
      })
    end

    let(:page) { Capybara::Node::Simple.new(subject)}

    it "has the correct title" do
      page.find("#electives-section h2").text.should == I18n.t('woople_theme.dashboards.member.electives_section.title')
    end
  end
end
