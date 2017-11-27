## links collected from twitter, friday link dumps, fb (classics int'l), rss in the future
# require 'pry'

class DumpedLinksController < ApplicationController
  def new
    @dumped_link = DumpedLink.new
  end

  def create
    @dumped_link = DumpedLink.new(dumped_link_params)
    if @dumped_link.save
      flash[:success] = "DumpedLink '#{@dumped_link.title}' added"
      render 'manage'
    else
      flash[:danger] = "Please re-check information: #{@dumped_link.errors.full_messages}"
      Rails.logger.info(@dumped_link.errors.inspect)
      render 'new'
    end
  end

  def destroy
    DumpedLink.find(params[:id]).destroy
    flash[:success] = 'DumpedLink removed'
    redirect_to root_path
  end

  def reject
    @dumped_link = DumpedLink.find(params[:id])
    @dumped_link.update(rejected: true)
    if @dumped_link.save
      flash[:success] = "#{@dumped_link.title} rejected"
    else
      flash[:danger] = 'Unable to remove dumped link'
    end
    redirect_back fallback_location: articles_manage_path
  end

  private

  def dumped_link_params
    params.require(:dumped_link).permit(
      :title,
      :url,
      :submission_route,
      :rss_object,
      :rejected,
      :submitted_by
    )
  end
end
