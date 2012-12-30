require 'spec_helper'

describe Card do
  it "should not save without a question and answer" do
    @card = Card.new
    @card.should_not be_valid
  end

end
