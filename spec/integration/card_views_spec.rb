require "spec_helper"
require "capybara/rspec"
require_relative '../support/helper.rb'

describe "card views" do
  before(:each) do
    @user = signin
    @topic = @user.topics.new(name:'English')
    @topic.save

    question = 'Kya khayaal hai'
    answer = 'Theek hai'
    @card = @topic.cards.new(question:question, answer:answer)
    @card.save

  end

  describe "on the show page" do
    before(:each) { visit card_path(@card) }

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
      click_button "Update Card"

      page.should have_content new_question
    end
  end

end
