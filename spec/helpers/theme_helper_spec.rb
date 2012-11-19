require 'spec_helper'

module Paperclip
  class Attachment; end
end

describe ThemeHelper do
  describe "#page_header" do
    it "renders a hash correctly" do
      data = { title: 'test', description: 'test' }
      html = helper.page_header(data)
      page = Capybara::Node::Simple.new(html)
      page.find('h1').should have_content('test')
    end
  end

  describe "#content_items" do
    it "renders a collection of items correctly" do
      stubbed_item = OpenStruct.new(name: 'Item', url:'/course', image: nil)
      collection   = [stubbed_item, stubbed_item, stubbed_item]

      html = helper.content_items(collection)
      page = Capybara::Node::Simple.new(html)
      page.should have_css("div.content-item", count: collection.size)
    end
  end

  describe "#video_modal" do
    it "renders the video modal correctly" do
      video = stub(name: 'My video', desktop_src: "example", mobile_src: "example", streamer: "example", favorite?: nil, liked?: nil).as_null_object
      html = helper.video_modal(video)
      page = Capybara::Node::Simple.new(html)
      page.find('h3').should have_content(video.name)
    end
  end

  describe "#content_item_header" do
    it "renders correctly" do
      html = helper.content_item_header
      page = Capybara::Node::Simple.new(html)
      page.should have_css('.content-item-header')
    end
  end

  describe "#outline" do
    #TODO: figure out how to test the fact that the outline partial yields the block
    it "should render an outline which yields the presenter" do
      html = helper.outline(stub(name:'my unit')) { |outline| outline.wrapped_by.should == [OutlinePresenter] }
      page = Capybara::Node::Simple.new(html)
      page.should have_css('.outline')
    end
  end

  describe "#profile" do
    it "renders correctly when a profile_model is present" do
      helper.stub(:profile_model) { stub(image: nil, sections: []).as_null_object }

      html = helper.profile
      page = Capybara::Node::Simple.new(html)
      page.should have_css('.profile')
    end

    it "raises an error when the profile_helper method does not exist" do
      WoopleTheme.configure do |config|
        config.profile_helper = :something_that_does_not_exist
      end

      expect { helper.profile }.to raise_error("something_that_does_not_exist helper_method does not exist. WoopleTheme.configuration.profile_helper must point to a valid helper_method.")
    end
  end

  describe "#menu" do
    it "renders correctly" do
      helper.stub(:menu_model) { stub.as_null_object }

      html = helper.menu
      page = Capybara::Node::Simple.new(html)
      page.should have_css('.menu')
    end

    it "raises an error when the menu_helper method does not exist" do
      WoopleTheme.configure do |config|
        config.menu_helper = :something_that_does_not_exist
      end

      expect { helper.menu }.to raise_error("something_that_does_not_exist helper_method does not exist. WoopleTheme.configuration.menu_helper must point to a valid helper_method.")
    end
  end

  describe "#results_header" do
    let(:title) { "Results Header" }

    it "always shows the title" do
      page = Capybara::Node::Simple.new helper.results_header(title, '')
      page.find('.results-header .title').should have_content(title)
    end

    it "does not show the more link when the path is not set" do
      page = Capybara::Node::Simple.new helper.results_header(title, '')
      page.should_not have_selector("a")
      page.find('.results-header .title').should_not have_content(I18n.t('woople_theme.search_results_more'))
    end

    it "shows the more link when the path is set" do
      path = "/search"
      html = helper.results_header(title, path)
      page = Capybara::Node::Simple.new(html)
      page.find("a").should have_content(I18n.t('woople_theme.search_results_more'))
      page.should have_css("a[href='#{path}']")
    end
  end

  describe "#impersonation_banner" do
    it "does not show anything if the impersonating? is false" do
      helper.stub(:impersonation_banner_helper) { stub(impersonating?: false) }

      html = helper.impersonation_banner
      html.should be_nil
    end

    it "renders correctly" do
      helper_stub = stub(impersonating?: true, logged_in_as: "Adam Doeler", impersonating: "Tom Cruise")

      helper.stub(:impersonation_banner_helper) { helper_stub }

      html = helper.impersonation_banner
      page = Capybara::Node::Simple.new(html)
      page.find(".span6:first-child").should have_content(helper_stub.logged_in_as)
      page.find(".span6:last-child").should have_content(helper_stub.impersonating)
    end

    it "raises an error when the impersonation_banner_helper method does not exist" do
      WoopleTheme.configure do |config|
        config.impersonation_banner_helper = :something_that_does_not_exist
      end

      expect { helper.impersonation_banner }.to raise_error("something_that_does_not_exist helper_method does not exist. WoopleTheme.configuration.impersonation_banner_helper must point to a valid helper_method.")
    end
  end

  describe "#breadcrumb" do
    it 'shows the breadcrumb' do
      page = Capybara::Node::Simple.new helper.breadcrumb('path')
      page.should have_css('.breadcrumb')
    end
  end
end
