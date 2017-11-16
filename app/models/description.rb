module Description
  def describe(html)
    if html.at("meta[property='og:description']")
      description = html.at("meta[property='og:description']")['content']
    elsif html.at("meta[property='twitter:description']")
      description = html.at("meta[property='twitter:description']")['content']
    else
      description = 'An article shared on the Paideia Institute\'s Online Public Classics Archive'
    end
    description
  end
end
