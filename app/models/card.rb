class Card < ActiveRecord::Base
  attr_accessible :answer, :question, :image
  has_attached_file :image
  validates_presence_of :answer, :question

  belongs_to :topic
end
