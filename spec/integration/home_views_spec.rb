require 'spec_helper'
require 'capybara/rspec'
require_relative '../support/helper.rb'

describe "home views" do
  def add_topics(user)
    topics = ['History', 'Hindi', 'Urdu', 'English'].collect do |name|
      topic = Topic.new(name:name)
      topic.user_id = user.id
      topic.save
    end
  end

  it "should have a login prompt if not logged in" do
    visit root_path
    page.should have_link 'Login', href:signin_path
  end

  it "should list the last 5 public cards" do
    user = User.create(email:'raheel@gmail.com', password:'raheel')
    topic = Topic.new(name:'English')
    topic.user_id = user.id
    topic.save
    @cards = []
    6.times do |i|
      card = Card.new(question:random_string(6), answer:random_string(6))
      card.topic_id = topic.id
      card.public = true
      card.save
      @cards << card
    end
    visit root_path
    page.should have_content 'Cards added recently'

    @cards.last(5).each { |card| page.should have_content card.question}

    page.should have_link 'All recent cards', cards_path
  end

  it "should show last three updated topic links for the user" do
    user = signin
    add_topics(user)
    visit root_path
    page.should have_content "Latest topics"
    user.topics.last(3).each do |topic|
      page.should have_link topic.display_name, href:topic_path(topic)
    end
  end

  it "should show link to user's topics" do
    user = signin
    add_topics(user)
    extra_topic = Topic.new(name:'Cities')
    extra_topic.user_id = (user.id + 1)
    extra_topic.save

    click_link "All topics"
    page.should_not have_link extra_topic.display_name
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
