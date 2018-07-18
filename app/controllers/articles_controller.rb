class ArticlesController < ApplicationController
  include ApplicationHelper
  include ArticleHelper
  include Aylien
  include Calais
  include Filter
  include Pagination

  before_action :require_login, only: %i[create edit update destroy manage]
  # before_action :require_login, only: %i[create edit update destroy]


  def new
    new_article_action_info
    @article = Article.new
  end

  def create
    params[:article][:calais_tags] = params[:article][:calais_tags].split(',')

    params[:article][:tag_list] = params[:article][:tag_list].map(&:titlecase).join(',')
    @article = Article.new(article_params)
    if @article.save
      if @article.approved
        flash[:success] = "Article '#{@article.title}' by #{@article.author_full_name} added to feed"
      else
        flash[:warning] = "Article '#{@article.title}' by #{@article.author_full_name} submitted for review"
      end
      redirect_to articles_manage_path
    else
      article_error_flash
      render 'new'
    end
  rescue OpenURI::HTTPError, RuntimeError => e
    rescue_article_image_error
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    params[:article][:tag_list] = params[:article][:tag_list].join(',')
    if @article.update(article_params)
      article_success_flash
    else
      article_error_flash
      render 'edit'
    end
  end

  def index
    # Filterrific crap inside of ArticleHelper
    search_page_info

    respond_to do |format|
      format.html
      format.js
      format.json { render json: @articles, include: [:taggings, :image] }
    end

    rescue ActiveRecord::RecordNotFound => e
      puts "Had to reset filterrific params: #{ e.message }"
      redirect_to(reset_filterrific_url(format: :html)) and return
  end

  def destroy
    Article.find(params[:id]).destroy
    flash[:success] = "Article removed"
    redirect_to articles_manage_path
  end

  def manage
    article_types
  end

  private

  def article_params
    params.require(:article).permit(
      :title,
      :author_first_name,
      :author_last_name,
      :type_of,
      :image,
      :featured,
      :featured_date,
      :image_credit,
      :description,
      :site_name,
      :url,
      :published_time,
      :tag_list,
      :calais_tags,
      :board_list,
      :site_text,
      :wayback_id,
      :boilerpipe_text,
      :approved,
      :approved_by,
      :submitted_by,
      calais_tags: []
    ).permit!
  end

  def logged_in?
    !current_user.nil?
  end

  def require_login
    unless logged_in?
      flash[:danger] = "You must be signed in to access this section"
      redirect_to root_path # halts request cycle
    end
  end
end
