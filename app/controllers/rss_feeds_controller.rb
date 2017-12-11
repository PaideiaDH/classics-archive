class RssFeedsController < ApplicationController
  include RssFeedsHelper

  before_action :set_rss_feed, only: [:destroy]

  def new
    @rss_feed = RssFeed.new
  end

  def create
    @rss_feed = RssFeed.new(rss_feed_params)

    if @rss_feed.save
      flash[:success] = "#{@rss_feed.name} added successfully."
    else
      @rss_feed.errors.full_messages.each do |error|
        flash[:danger] = error.html_safe
      end
    end
    redirect_to articles_manage_path
  end

  def destroy
    @rss_feed.destroy
    flash[:success] = "#{@rss_feed.name} removed from incoming links."
    redirect_to articles_manage_path
  end

  private
    def set_rss_feed
      @rss_feed = RssFeed.find(params[:id])
    end

    def rss_feed_params
      params.require(:rss_feed).permit(
        :name,
        :feed_url
      )
    end
end
