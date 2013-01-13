require "spec_helper"
require "capybara/rspec"
require_relative '../support/helper.rb'

describe "card views" do
  context "logged in" do
    before(:each) do
      @user = signin
      setup_for_user(@user)
    end

    describe "on the show page" do
      before(:each) { visit card_path(@card) }

      it "should list the card as public" do
        page.should_not have_content 'Public'
      end

      it "should list the card as private" do
        @card.public = true
        @card.save
        visit card_path(@card)
        page.should have_content 'Public'
      end

      it "should show a link to edit the card" do
        page.should have_link 'Edit', href:edit_card_path(@card)
      end
    end

    describe "one the edit page" do
      before(:each)  { visit edit_card_path(@card) }

      it "on the edit page" do
        new_question = @card.question + " bhai saheb"
        new_answer = @card.answer + " bhai saheb"
        fill_in 'Question', with:new_question
        fill_in 'Answer', with:new_answer
        attach_file 'Answer image', 'spec/integration/logo.png'
        page.check 'Public'
        click_button "Update Card"

        page.should have_content new_question
        page.should have_content 'Public'
      end
    end
  end

  context "not logged in" do
    before(:each) do
      user = User.new(email:random_string(6)+"@gmail.com", name:random_string(10), password:random_string(8))
      user.save
      setup_for_user(user)
      @card.public = true
      @card.save
    end

    describe "show page" do
      before(:each) { visit card_path(@card) }

      it "should show the public card" do
        page.should have_content @card.question
        page.should have_content @card.answer
      end

      it "should not have links to delete or edit" do
        page.should_not have_link 'Delete?'
        page.should_not have_link 'Edit'
        page.should_not have_link "Back to #{@card.topic.name}"
      end
    end
    describe "index page" do
      before(:each) do
        6.times do |i|
          card = @topic.cards.new(question:random_string(10), answer:random_string(10))
          card.public = true
          card.save
        end
        private_card = @topic.cards.new(question:random_string(10), answer:random_string(10))
        private_card.save
        visit cards_path
      end

      it "should show the public cards" do
        @topic.cards.each do |card|
          if card.public
            page.should have_link card.question, href:card_path(card)
          else
            page.should_not have_link card.question
          end
        end
      end
    end
  end
end

def setup_for_user(user)
  @topic = user.topics.new(name:'English')
  @topic.save

  question = 'Kya khayaal hai'
  answer = 'Theek hai'
  @card = @topic.cards.new(question:question, answer:answer)
  @card.save
end
