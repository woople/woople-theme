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

  describe '#organization_accounts' do
    context 'accordion heading' do
      subject { helper.organization_accounts [{ name: 'Account 1', users: [] }, { name: 'Account 2', users: [] }] }

      it 'renders the account names in the accordion headings' do
        page = Capybara::Node::Simple.new(subject)
        page.find('a[href="#organization-account-0"]').text.should eq('Account 1')
        page.find('a[href="#organization-account-1"]').text.should eq('Account 2')
      end
    end

    context 'accordion inner' do
      user1 = {
        image: '/assets/retina_thumb/missing.png',
        name: 'Christopher Mudiappahpillai',
        member_dashboard_path: '/member_dashboards/2757',
        status_color: :red,
        status_description: '3 essentials and 123 elective points required.'
      }
      user2 = {
        image: 'https://woople.s3.amazonaws.com/gwar.jpg',
        name: 'Joannou Ng',
        member_dashboard_path: '/member_dashboards/113037',
        status_color: :yellow,
        status_description: '7 essentials and 113 elective points required.'
      }

      subject do
        account = { name: 'GOATSE', users: [user1, user2] }
        helper.organization_accounts [account]
      end

      it 'renders the account users in the accordion inner' do
        page = Capybara::Node::Simple.new subject

        [user1, user2].each_with_index do |user, i|
          page.all('img')[i][:src].should eq '/assets/woople-theme/missing-profile.png' if i == 0
          page.all('img')[i][:src].should eq user[:image] if i == 1
          anchor = page.all('.span8 a')[i]
          anchor.text.should eq user[:name]
          anchor[:href].should eq user[:member_dashboard_path]
          status = page.all('.status-alert')[i]
          status[:class].should eq 'alert alert-error status-alert' if i == 0
          status[:class].should eq 'alert  status-alert' if i == 1
          status['data-content'].should eq user[:status_description]
          page.all('.status-alert strong')[i].text.should eq user[:status_color].to_s.capitalize!
          page.all('.status-alert span')[i].text.should eq user[:status_description]
        end

        page.should have_css 'button.btn.btn-primary i.icon-envelope-alt.icon-white', count: 2
      end
    end
  end

  describe "#essentials_section" do
    subject do
      helper.essentials_section({
        enabled?: true,
        essentials_remaining:  [stub(url:"/course",name:'remaining',image:nil).as_null_object],
        essentials_completed:  [stub(url:"/course",name:'completed',image:nil,time_total:'12:34').as_null_object],
        essentials_exceptions: [stub(name: 'Exception', description: 'Reason', completed_on: Time.current, url: '/course').as_null_object]
      })
    end

    let(:page) { Capybara::Node::Simple.new(subject) }

    it "has the correct name for the essential remaining" do
      page.find(".content-item-content h2 a").text.should == 'remaining'
    end
  end

  describe "#essentials_completed" do
    it "renders a collection" do
      collection = [stub(url:"/course").as_null_object, stub(url:"/course").as_null_object, stub(url:"/course").as_null_object]
      helper.should_receive(:render_collection_partial).with(collection, WoopleTheme::Dashboard::EssentialCompletedPresenter, 'woople-theme/content_item')
      helper.essentials_completed(collection)
    end
  end

  describe "#essentials_exceptions" do
    it "renders a collection" do
      collection = [stub(url: '/course').as_null_object]
      helper.should_receive(:render_collection_partial).with(collection, WoopleTheme::Dashboard::EssentialExceptionPresenter, 'woople-theme/dashboard/exception')
      helper.essentials_exceptions(collection)
    end
  end

  describe "#electives_section" do
    subject do
      helper.electives_section({
        electives_history: [stub(completed_on: Time.current, name: 'x', current_points: 10, total_points: 20, url: '/course', image: nil).as_null_object],
        electives_exceptions: [stub(name: 'Exception', description: 10, completed_on: Time.current, url: nil).as_null_object],
        points_earned: 1,
        points_total: 2,
        enabled?: true
      })
    end

    let(:page) { Capybara::Node::Simple.new(subject) }

    it "has the correct title" do
      page.find("#electives-section h2").text.should == I18n.t('woople_theme.dashboards.member.electives_section.title')
    end
  end

  describe "#electives_points" do
    subject do
      helper.electives_section({
        electives_history: [stub(completed_on: Time.current, name: 'x', current_points: 10, total_points: 20, url: '/course', image: nil).as_null_object],
        electives_exceptions: [stub(name: 'Exception', description: 10, completed_on: Time.current, url: nil).as_null_object],
        points_earned: 1,
        points_total: 2,
        enabled?: true
      })

      let(:page) { Capybara::Node::Simple.new(subject) }

      it "has points" do
        page.find('#electives_points .points').text.should == I18n.t('woople_theme.dashboards.member.electives_section.points_earned', points_earned: 1, points_total: 2)

      end
    end
  end

  describe "#electives_history" do
    it "renders a collection" do
      collection = [stub(completed_on: Time.current, name: 'x', current_points: 10, total_points: 20, url: '/course', image: nil).as_null_object]
      helper.should_receive(:render_collection_partial).with(collection, WoopleTheme::Dashboard::ElectiveHistoryPresenter, 'woople-theme/content_item')
      helper.electives_history(collection)
    end
  end
end
