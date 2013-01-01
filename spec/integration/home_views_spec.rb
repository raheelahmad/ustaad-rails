require 'spec_helper'
require 'capybara/rspec'
require_relative '../support/helper.rb'
describe "home views" do

  it "should have a login prompt if not logged in" do
    visit root_path
    page.should have_link 'Login', href:signin_path
  end

  it "should show last three updated topic links for the user" do
    user = User.new(email:'rahmad@cs.siu.edu', password:'raheelms')
    topics = ['History', 'Hindi', 'Urdu'].collect do |name|
      user.topics.new(name:name)
    end

    signin user
    page.should have_content "Latest topics"
    topics.each do |topic|
      page.should have_link topic.name, href:topic_path(topic)
    end
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
