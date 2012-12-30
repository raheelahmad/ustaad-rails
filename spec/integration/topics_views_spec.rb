require 'spec_helper'
require 'capybara/rspec'

describe "the articles interface" do
  before(:all) do
    @topics = []
    3.times { @topics << Topic.create(name:['english', 'urdu', 'history'].sample)}
  end

  describe "on the index page" do
    before (:each) do
      visit topics_path
    end

    it "should list the path titles on the index" do
      @topics.each do |topic|
        page.should have_content(topic.name)
      end
    end
    
    it "should list the titles as links" do
      @topics.each do |topic|
        page.should have_link topic.name, href:topic_path(topic)
      end
    end

    it "should visit a title's show page" do
      topic = @topics.first
      click_link topic.name
      puts page.current_path
      current_path.should eq(topic_path(topic))
    end
  end

  after(:all) do
    @topics = Topic.all
    @topics.each { |topic| 
      topic.destroy
    }
  end
end
