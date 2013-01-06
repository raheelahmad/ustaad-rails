require 'spec_helper'

describe Card do
  before(:each) { @card = Card.new(question:"A", answer:"B") }
  subject { @card }
  it "should not save without a question and answer" do
    @card.answer = nil
    @card.should_not be_valid

    @card.answer = "something"
    @card.question = nil
    @card.should_not be_valid
  end

  it "should have public flag as false when being created" do
    @card.save
    @card.public.should be_false
  end
end
