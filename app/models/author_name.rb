# scrape author from site text and url

module AuthorName
  def author_name(html, url)
    if html.at("meta[property='author']")
      author = html.at("meta[property='author']")['content']
    elsif url.include? 'rfkclassics'
      author = 'Rebecca Futo Kennedy'
    elsif url.include? 'thesphinxblog'
      author = 'Neville Morley'
    elsif url.include? 'ancientimes'
      author = 'Mary Harrsch'
    elsif url.include? 'ancientworldonline'
      author = 'Charles Jones'
    elsif url.include? 'the-tls'
      author = 'Mary Beard'
    elsif html.at("meta[name='author']")
      author = html.at("meta[name='author']")['content']
    elsif html.at("meta[name='authors']")
      author = html.at("meta[name='authors']")['content']
    elsif html.at("meta[name='parsely-page']")
      if  JSON.parse(html.at("meta[name='parsely-page']")['content'])['authors']
        author = JSON.parse(html.at("meta[name='parsely-page']")['content'])['authors'].join(', ')
      else
        author = nil
      end
    elsif html.at("meta[property='article:author']")
      author = html.at("meta[property='article:author']")['content']
    elsif html.at("meta[name='byl']")
      author = html.at("meta[name='byl']")['content'].sub(/BY[ :]/i, '')
    elsif html.at("meta[name='twitter:creator']")
      author = html.at("meta[name='twitter:creator']")['content']
    else
      author = nil
    end
    author
  end
end
