require 'spec_helper'
require 'capybara/rspec'
require_relative '../support/helper.rb'

describe "the topics interface" do
  before(:all) do
    user = signin
    @topics = []
    3.times do
      topic = Topic.new(name:['english', 'urdu', 'history'].sample)
      topic.user_id = user.id
      topic.save
      @topics << topic
    end
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
      current_path.should eq(topic_path(topic))
    end
  end

  describe "on the show page" do
    before (:each) do
      @topic = @topics.first
      @topic.cards.new(:question => 'Hatta', answer:'Katta').save
      @topic.cards.new(:question => 'Johootha', answer:'Mootha').save
      @topic.cards.new(:question => 'Lamba', answer:'Tagda').save
      visit topic_path(@topic)
    end

    it "should show topic title in h1" do
      page.should have_selector 'h1', text:@topic.name
    end

    it "should have the questions and answers for each card" do
      @topic.cards.each do |card|
        page.should have_content card.question
        page.should have_content card.answer
      end
    end

    it "should add a new card" do
      fill_in 'Question', with:"Tagda"
      fill_in 'Answer', with:"Pahelwan"
      click_button "Add a card"
      page.should have_content "Tagda"
      page.should have_content "Pahelwan"
    end
  end

  after(:all) do
    @topics = Topic.all
    @topics.each { |topic| 
      topic.destroy
    }
  end
end
