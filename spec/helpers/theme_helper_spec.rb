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
      collection = [stub.as_null_object, stub.as_null_object, stub.as_null_object]
      html = helper.content_items(collection)
      page = Capybara::Node::Simple.new(html)
      page.should have_css("div.content-item", count: 3)
    end
  end

  describe "#video_modal" do
    it "renders the video modal correctly" do
      video = stub(name: 'My video').as_null_object
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
      helper.stub(:profile_model) { stub.as_null_object }

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
      html = helper.results_header(title)
      page = Capybara::Node::Simple.new(html)
      page.find('h2.results-header').should have_content(title)
    end

    it "does not show the more link when the path is nil" do
      html = helper.results_header(title)
      page = Capybara::Node::Simple.new(html)
      page.should_not have_selector("a")
    end

    it "shows the more link when the path is not nil" do
      path = "/search"
      html = helper.results_header(title, path)
      page = Capybara::Node::Simple.new(html)
      page.find("a").should have_content(I18n.t('woople_theme.search_results_more'))
      page.should have_css("a[href='#{path}']")
    end
  end
end
