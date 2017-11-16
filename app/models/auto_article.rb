# auto add article fields upon RSS add
# TODO -- set up background job for pre-fetching RSS link aylien info

module AutoArticle
  include Aylien

  def turn_rss_link_into_article(id)
    @dumped = DumpedLink.find(id)
    @parsed = article_info(@dumped.url)


  end

  def fill_blank_fields_with_BLANK

  end

  def make_sure_approved_only_if_complete

  end
end
