class RSSFeedsController < ApplicationController
  before_action :set_rss_feed, only: [:show, :edit, :update, :destroy]

  def index
    @rss_feeds = RSSFeed.all
  end

  def show
  end

  def new
    @rss_feed = RSSFeed.new
  end

  def edit
  end

  def create
    @rss_feed = RSSFeed.new(rss_feed_params)

    respond_to do |format|
      if @rss_feed.save
        format.html { redirect_to @rss_feed, notice: 'RSS feed was successfully created.' }
        format.json { render :show, status: :created, location: @rss_feed }
      else
        format.html { render :new }
        format.json { render json: @rss_feed.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @rss_feed.update(rss_feed_params)
        format.html { redirect_to @rss_feed, notice: 'RSS feed was successfully updated.' }
        format.json { render :show, status: :ok, location: @rss_feed }
      else
        format.html { render :edit }
        format.json { render json: @rss_feed.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @rss_feed.destroy
    respond_to do |format|
      format.html { redirect_to rss_feeds_url, notice: 'RSS feed was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_rss_feed
      @rss_feed = RSSFeed.find(params[:id])
    end

    def rss_feed_params
      params.fetch(:rss_feed, {})
    end
end
