# professional article scraping

module Aylien
  include AuthorName
  include Calais
  include Description
  include FindTags
  include HTTParty
  include Publisher
  include TimePublished

  def aylien_creator(url)
    response = HTTParty.get(
      'https://api.aylien.com/api/v1/extract',
      headers: {
        'X-AYLIEN-TextAPI-Application-Key' => ENV['AYLIEN_KEY'],
        'X-AYLIEN-TextAPI-Application-ID' => ENV['AYLIEN_ID']
      },
      query: {
        url: url,
        best_image: true
      }
    )
    response.parsed_response
  end

  def get_html(url)
    page = HTTParty.get(url)
    Nokogiri::HTML(page)
  end

  def article_info(url)
    page_json = aylien_creator(url)
    page_html = get_html(url)

    scraped_tags = find_tags(page_html)
    calais_tags = calais(page_json['article'])
    tags = calais_tags.concat(scraped_tags).flatten.map(&:titlecase)

    author = page_json['author'].blank? ? author_name(page_html, url) : page_json['author']
    if author.nil?
      author_first_name = nil
      author_last_name = nil
    else
      author = author.split(' ')
      author_first_name = author[0..-2].join(' ')
      author_last_name = author[-1]
    end

    title = page_json['title']

    default_image = 'https://static1.squarespace.com/static/57600285f699bb9740cbd53b/t/57cf0af315d5dba471549ecb/1473186552334/'

    image = page_json['image'].blank? ? default_image : page_json['image']

    description = describe(page_html)

    published_time = page_json['publishDate'].blank? ?  time_published(page_html, url) : page_json['publishDate'].to_datetime

    boilerpipe_text = page_json['article'].force_encoding('UTF-8')

    site_name = publisher(page_html, url)

    @parsed = {
      title: title,
      author_first_name: author_first_name,
      author_last_name: author_last_name,
      type_of: 'article',
      image: image,
      image_credit: 'n/a',
      description: description,
      site_name: site_name,
      url: url,
      published_time: published_time,
      tags: tags,
      site_text: page_html,
      boilerpipe_text: boilerpipe_text
    }
    @parsed
  end

end
