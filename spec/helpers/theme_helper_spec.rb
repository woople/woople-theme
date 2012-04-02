require 'spec_helper'

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
    it "renders correctly" do
      outline = [stub.as_null_object, stub.as_null_object, stub.as_null_object]
      html = helper.outline(outline)
      page = Capybara::Node::Simple.new(html)
      page.should have_css('.outline', count: 3)
    end
  end

  describe "#profile" do
    it "renders correctly" do
      helper.stub(:profile_model) { stub.as_null_object }

      html = helper.profile
      page = Capybara::Node::Simple.new(html)
      page.should have_css('.profile')
    end
  end

  describe "#menu" do
    it "renders correctly" do
      helper.stub(:menu_model) { stub.as_null_object }

      html = helper.menu
      page = Capybara::Node::Simple.new(html)
      page.should have_css('.menu')
    end
  end
end
