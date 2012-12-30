require 'spec_helper'

describe Topic do
  before { @topic = Topic.new(name:"things") }
  subject { @topic }

  describe "does not save without a name" do
    before { @topic.name = nil }
    it { should_not be_valid }
  end

  describe "returns the added topic" do
    before do
      @topic.add
    end
  end
end
