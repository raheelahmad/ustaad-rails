class Card < ActiveRecord::Base
  attr_accessible :answer, :question
  validates_presence_of :answer, :question

  belongs_to :topic
end
