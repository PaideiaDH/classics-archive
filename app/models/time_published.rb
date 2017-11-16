module TimePublished
  def time_published(html, url)
    if html.at("meta[property='article:published_time']")
      @published_time = html.at("meta[property='article:published_time']")['content'].to_datetime
    elsif html.at("meta[name='parsely-page']")
      if JSON.parse(html.at("meta[name='parsely-page']")['content'])['pub_date']
        @published_time = JSON.parse(html.at("meta[name='parsely-page']")['content'])['pub_date'].to_datetime
      else
        @published_time = nil
      end
    elsif html.at("script[type='application/ld+json']")
      if JSON.parse(html.at("script[type='application/ld+json']"))['datePublished']
        @published_time = JSON.parse(html.at("script[type='application/ld+json']"))['datePublished'].to_datetime
      else
        @published_time = nil
      end
    elsif html.at("meta[name='pdate']")
      @published_time = html.at("meta[name='pdate']")['content'].to_datetime
    elsif url[/[12][0-9][0-9][0-9]\/[01][0-9]\/[0-3][0-9]/]
      @published_time = url[/[12][0-9][0-9][0-9]\/[01][0-9]\/[0-3][0-9]/].to_datetime
    else
      @published_time = nil
    end
    @published_time
  end
end
