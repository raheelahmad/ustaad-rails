module CardsHelper
  def display_text(card)
    text = link_to card.question, card_path(card)
    if card.answer_image.exists?
      text += " "
      text += image_tag "image_placeholder.png", width:"20"
    end
    text.html_safe
  end
end
