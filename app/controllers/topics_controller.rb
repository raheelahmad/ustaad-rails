class TopicsController < ApplicationController
  def index
    if params[:user_id]
      @topics = Topic.where(user_id:params[:user_id])
    elsif current_user
      @topics = Topic.where(user_id:current_user.id)
    else
      @topics = []
    end
  end

  def show
    puts current_user.email
    @topic = current_user.topics.find(params[:id])
    @card = Card.new
    @card.topic_id = @topic.id
  end

  def new
    @topic = Topic.new
    @topic.user_id = current_user.id
  end

  def create
    user_id = params[:topic].delete(:user_id)
    @topic = Topic.new(params[:topic])
    @topic.user_id = user_id
    if @topic.save
      flash[:notice] = "#{@topic.name} created. Add cards below"
      redirect_to topic_path(@topic)
    else
      flash[:notice] = "Could not create the topic. See errors below"
      render "new"
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    name = @topic.name
    @topic.destroy
    redirect_to topics_path, notice:"#{name} has been deleted"
  end
end
