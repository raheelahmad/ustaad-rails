class Card < ActiveRecord::Base
  attr_accessible :answer, :question, :image
  has_attached_file :image
  validates_presence_of :answer, :question
  after_create :default_values

  belongs_to :topic

  def default_values
    self.public = false
  end
end
