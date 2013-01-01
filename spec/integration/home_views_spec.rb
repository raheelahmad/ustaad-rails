require 'spec_helper'
require 'capybara/rspec'
require_relative '../support/helper.rb'

describe "home views" do
  def add_topics(user)
    topics = ['History', 'Hindi', 'Urdu', 'English'].collect do |name|
      topic = user.topics.new(name:name)
      topic.user_id = user.id
    end
    user.save
  end

  it "should have a login prompt if not logged in" do
    visit root_path
    page.should have_link 'Login', href:signin_path
  end

  it "should show last three updated topic links for the user" do
    user = signin
    add_topics(user)
    visit root_path
    page.should have_content "Latest topics"
    user.topics.last(3).each do |topic|
      page.should have_link topic.name, href:topic_path(topic)
    end
  end

  it "should show link to user's topics" do
    user = signin
    add_topics(user)
    extra_topic = Topic.new(name:'Cities')
    extra_topic.user_id = (user.id + 1)
    extra_topic.save

    visit root_path
    
    click_link "All topics"
    
    user.topics.each do |topic|
      page.should have_link topic.name, href:topic_path(topic)
    end

    page.should_not have_link extra_topic.name
  end

  it "should show a link to create new topic" do
    signin
    page.should have_link 'Create topic', href:new_topic_path
  end

  it "should add a topic to the topics list" do
    signin
    click_link 'Create topic'
    fill_in 'Name', with:'Strava'
    click_button 'Create Topic'
    visit root_path
    page.should have_content 'Strava'
  end
end
