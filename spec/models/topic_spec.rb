require 'spec_helper'

describe Topic do
  before { @topic = Topic.new(name:"things"); @topic.user_id = 1 }
  subject { @topic }

  describe "does not save without a name" do
    before { @topic.name = nil }
    it { should_not be_valid }
  end

  describe "does not save without a user id" do
    before { @topic.user_id = nil }

    it { should_not be_valid }
  end

  describe "returns the added topic" do
    before do
      @topic.add
    end
  end
end
