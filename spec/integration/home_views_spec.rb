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
  
  context "not logged in" do
    it "should have a login prompt" do
      visit root_path
      page.should have_link 'Login', href:signin_path
    end

    context "viewing public cards" do
      before(:each) do
        user = User.create(email:'raheel@gmail.com', password:'raheel')
        topic = Topic.new(name:'English')
        topic.user_id = user.id
        @cards = add_some_cards_to_topic(topic:topic, public:true)
        visit root_path
      end

      it "should list the last 5 public cards" do
        page.should have_content 'Public cards added recently'
        @cards.last(5).each { |card| page.should have_link card.question, href:card_path(card)}
        page.should have_link 'All recent cards', href:cards_path
      end
  end
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

    click_link "(All)"
    page.should_not have_link extra_topic.display_name
  end


end
