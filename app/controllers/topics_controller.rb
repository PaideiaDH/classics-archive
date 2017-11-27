class TopicsController < ApplicationController
  before_action :set_topic, only: [:destroy]

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)

    if @topic.save
      flash[:success] = "#{@topic.name} added successfully."
    else
      @topic.errors.full_messages.each do |error|
        flash[:danger] = error.html_safe
      end
    end
    redirect_to articles_manage_path
  end

  def destroy
    @topic.destroy
    flash[:success] = "#{@topic.name} removed."
    redirect_to articles_manage_path
  end

  private

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:name)
  end
end
