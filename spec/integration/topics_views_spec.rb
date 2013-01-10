require 'spec_helper'
require 'capybara/rspec'
require_relative '../support/helper.rb'

describe "the topics interface" do
  before(:each) do
    @user = signin
    @topics = []
    3.times do
      topic = Topic.new(name:['english', 'urdu', 'history'].sample)
      topic.user_id = @user.id
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
        page.should have_link topic.display_name, href:topic_path(topic)
      end
    end

    it "should visit a title's show page" do
      topic = @topics.first
      click_link topic.name
      current_path.should eq(topic_path(topic))
    end

    it "should show a link to create new topic" do
      page.should have_link 'Create topic', href:new_topic_path
    end

    it "should add a topic to the topics list" do
      click_link 'Create topic'
      fill_in 'Name', with:'Strava'
      click_button 'Create Topic'
      visit root_path
      page.should have_content 'Strava'
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

    it "should have form field for image upload" do
      page.should have_field :image
    end

    it "should show topic title in h1" do
      page.should have_selector 'h1', text:@topic.name
    end

    it "should show a link to edit the topic" do
      page.should have_link 'Edit', href:edit_topic_path(@topic)
    end
    it "should have the questions and answers for each card" do
      @topic.cards.each do |card|
        page.should have_content card.question
      end
    end

    # --- this raises ActiveRecord record not found exception
    # --- which means the test passes...
    # it "should not show a topic if the current user does not match" do
    #   unauthorized_topic = Topic.new(name:'Termination')
    #   unauthorized_topic.user_id = @topics.first.id + 1
    #   unauthorized_topic.save
    #   visit topic_path(unauthorized_topic)
    #   page.should_not have_content unauthorized_topic.name
    # end

    it "should delete the topic via a delete link" do
      page.should have_link 'Delete', href:topic_path(@topic)
      click_link 'Delete'
      current_path.should eq(topics_path)
      page.should_not have_content @topic.display_name
    end

    it "should add a new card" do
      fill_in 'Question', with:"Tagda"
      fill_in 'Answer', with:"Pahelwan"
      click_button "Create Card"
      page.should have_content "Tagda"
    end
  end

  describe "one the edit page" do
    it "should update a topic" do
      topic = @topics.first
      visit edit_topic_path(topic)

      new_name = "Badmaash"
      fill_in 'Name', with:new_name
      click_button "Update Topic"
      page.should have_content new_name
    end
  end
  after(:all) do
    @topics = Topic.all
    @topics.each { |topic| 
      topic.destroy
    }
  end
end
