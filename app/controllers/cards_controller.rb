class CardsController < ApplicationController
  before_filter :authorize, except: [:show, :index]

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

  def index
    @cards = []
    if current_user
      current_user.topics.each do |topic|
        topic.cards.order("updated_at DESC").all.each { |card| @cards << card }
      end
    else
      Card.where(public:true).order("updated_at DESC").all.each { |card| @cards << card }
    end
  end

  def show
    if current_user
      @card = user_card_for_id(params[:id])
      @all_topics = Topic.where(user_id:current_user.id)
    end

    if !@card
      @card = Card.find(params[:id])
      raise ActiveRecord::RecordNotFound.new unless @card.public
    end

    if @card
      @previous_card = @card.previous(session[:current_card_query_ids])
      @next_card = @card.next(session[:current_card_query_ids])
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

  def switch_to_topic
    topic_id = params[:topic_id]
    topic = Topic.find(topic_id)
    redirect_to card_path(topic.cards.first)
  end
  def user_card_for_id(card_id)
    found_card = nil
    current_user.topics.each do |topic|
      card = topic.cards.where(id:card_id)
      found_card = card.first if card and !found_card
    end
    puts found_card.question
    found_card
  end
end
