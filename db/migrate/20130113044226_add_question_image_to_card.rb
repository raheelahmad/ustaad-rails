class AddQuestionImageToCard < ActiveRecord::Migration
  def change
    add_attachment :cards, :question_image
  end
end
