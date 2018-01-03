module ArticleHelper
  include Wayback

  def search_page_info
    @filterrific = initialize_filterrific(
      Article.where(approved: true),
      params[:filterrific],
      select_options: {
        sorted_by: Article.options_for_sorted_by,
        of_type: CONTENT_TYPES
      }
    ) || return
    @all_articles = @filterrific.find
    @featured = params[:filterrific] ? [] : @all_articles.select{ |a| a.featured? && a.featured_date.between?(1.weeks.ago.to_datetime,(DateTime.now + 1.week)) }
    @all_articles -= @featured
    @articles = Kaminari.paginate_array(@all_articles).page(params[:page])
                        .per(15)
                        .as_json(
                          methods: %i[
                            image
                            tags
                            pretty_date
                          ]
                        )
    @featured_articles = @featured.as_json(methods: %i[
                                             image
                                             tags
                                             pretty_date
                                           ])
    @query = URI.encode_www_form @filterrific.to_hash
    @all_tags = ActsAsTaggableOn::Tag.all.order(taggings_count: :desc).map(&:name)
    @all_authors = Article.all.select(&:approved?).map(&:author_full_name).uniq.join(',')
    @all_publishers = Article.all.select(&:approved?).map(&:site_name).uniq.join(',')
    @p = params[:page].to_i.zero? ? 1 : params[:page].to_i
    @page_entries_info = paginate @all_articles, @p
    @current_filters = describe_filters(@filterrific.to_hash)
    @sorted = @filterrific.to_hash['sorted_by'] || nil
  end

  def rescue_article_image_error
    copy_params = article_params
    copy_params['image'] = 'https://github.com/PaideiaDH/classics-archive/blob/master/app/assets/images/owl.png?raw=true'
    copy_params['image_credit'] = 'NEEDS IMAGE AND CREDIT'
    @article_without_image = Article.new(copy_params)
    if @article_without_image.save
      if @article_without_image.approved
        flash[:success] = "Article '#{@article.title}' by #{@article.author_full_name} added to feed"
      else
        flash[:warning] = "Article '#{@article_without_image.title}' by #{@article_without_image.author_full_name} submitted for review"
      end
      redirect_to articles_manage_path
    else
      flash[:danger] = "Please re-check information: #{@article_without_image.errors.full_messages}"
      Rails.logger.info(@article_without_image.errors.inspect)
      render 'new'
    end
  end

  def article_success_flash
    flash[:success] = "Article '#{@article.title}' by #{@article.author_full_name} added to feed"
    redirect_to articles_manage_path
  end

  def article_error_flash
    flash[:danger] = "Please re-check information: #{@article.errors.full_messages}"
    Rails.logger.info(@article.errors.inspect)
  end

  def new_article_action_info
    if params[:ldid]
      DumpedLink.destroy(params[:ldid]) if DumpedLink.exists?(params[:ldid])
      flash[:success] = 'Added from Link Dump'
    end

    @parsed = article_info(params[:user_url]) if params[:user_url]

    @wayback_id = get_wayback_id(params[:user_url]) if @parsed[:wayback_id].nil?

    @pubs = Article.all.map(&:site_name).uniq.join(',')

    @existing = Article.where(url: @parsed[:url])[0]
    if @existing
      flash[:info] = "Great minds think alike... this article has already been submitted as of #{@existing.created_at.strftime('%e %B %Y')}!"
      redirect_to articles_manage_path
    end
  end

  def article_types
    @approved_articles = Article.all.where(approved: true)
    @need_approval = Article.all.where(approved: false)
    @dumped_links = DumpedLink.all.where(rejected: nil)
  end
end
