# scrape tags from site text

module FindTags
  def find_tags(html)
    tags = []
    if html.at("meta[name='keywords']")
      tags << html.at("meta[name='keywords']")['content'].split(',') if html.at("meta[name='keywords']")['content']
    elsif html.at("meta[name='parsely-page']")
      if JSON.parse(html.at("meta[name='parsely-page']")['content'])['tags']
      tags << JSON.parse(html.at("meta[name='parsely-page']")['content'])['tags']
      end
    elsif html.at("meta[property='article:tag']")
      tags += [html.at("meta[property='article:tag']")['content']]
    elsif html.at("meta[name='collections']")
      tags << html.at("meta[name='collections']")['content'].split(',').to_a
    else
      tags
    end
    tags
  end
end
