class HomeController < ApplicationController
  def show
    redirect_to articles_path
  end

  def about
  end

  def reset
    redirect_to reset_filterrific_url
  end

  def sandbox
    @articles = Article.all
  end
end
