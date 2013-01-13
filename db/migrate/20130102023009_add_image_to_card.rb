class AddImageToCard < ActiveRecord::Migration
  def change
    add_attachment :cards, :answer_image
  end
end
