class CardsController < ApplicationController
  before_filter :authorize, except: :show

  def create
    topic_id = params[:card].delete(:topic_id)
    @card = Card.new(params[:card])
    @card.topic_id = topic_id
    if @card.save
      redirect_to topic_path(@card.topic), notice:"Card added"
    else
      flash[:error] = "Could not add card."
      render "new"
    end
  end

  def show
    if current_user
      @card = user_card_for_id(params[:id])
    else
      @card = Card.find(params[:id])
      raise ActiveRecord::RecordNotFound.new unless @card.public
    end
  end

  def destroy
    card = Card.find(params[:id])
    name = card.question; topic = card.topic
    card.destroy
    redirect_to topic_path(topic), notice:"#{name} was deleted"
  end

  def edit
    @card = user_card_for_id(params[:id])
  end

  def update
    topic_id = params[:card].delete(:topic_id)
    card = user_card_for_id(:id)
    card.update_attributes(params[:card])
    redirect_to card_path(card)
  end

  def user_card_for_id(card_id)
    found_card = nil
    current_user.topics.each do |topic|
      card = topic.cards.where(id: params[:id])
      found_card = card.first if card
    end

    found_card
  end
end
