# professional article scraping
require 'faraday'
require 'iconv'

module Aylien
  include AuthorName
  include Calais
  include Description
  include FindTags
  include Publisher
  include TimePublished
  include Wayback

  def aylien_creator(url)
    conn = Faraday.new(url: 'https://api.aylien.com')
    response = conn.get '/api/v1/extract' do |req|
      req.headers['X-AYLIEN-TextAPI-Application-Key'] = ENV['AYLIEN_KEY']
      req.headers['X-AYLIEN-TextAPI-Application-ID'] = ENV['AYLIEN_ID']
      req.params = {
        url: url,
        best_image: true
      }
    end
    response.body
  end

  # MESSY LOOP TO REGENERATE IMAGES
  # default_image = 'https://github.com/PaideiaDH/classics-archive/blob/master/app/assets/images/owl.png?raw=true'
  # rejected = []
  # Article.all.map(&:id).reverse.each do |article|
  #   a = Article.find(article)
  #   begin
  #   page_json = aylien_creator(a.url)
  #   j = JSON.parse(page_json)
  #   img_url = j['image'].blank? ? default_image : j['image']
  #   a.image_remote_url(img_url)
  #   rescue OpenURI::HTTPError, RuntimeError => e
  #     rejected << a.id
  #     next
  #   end
  #   a.save! validate: false
  # end
  #
  # def manual_image(id)
  #   a = Article.find(id)
  #   puts a.url
  #   img_url = gets.chomp
  #   a.image_remote_url(img_url)
  #   a.save! validate: false
  # end
  #
  # rejected.each do |r|
  #   manual_image(r)
  # end

  # Article.all.each do |a|
  #   j = JSON.parse(aylien_creator(a.url))
  #   puts j['publishDate']
  #   if j['publishDate'].blank?
  #     next
  #   else
  #     a.published_time = j['publishDate'].to_datetime
  #     a.save! validate:false
  #   end
  # end

  def get_html(url)
    page = Faraday.get(url)
    Nokogiri::HTML(page.body, nil, 'UTF-8')
  end

  def get_links(html)
    links = html.css('a')
    links.map {|link| link.attribute('href').to_s}.uniq.sort.delete_if {|href| href.empty?}
  end

  def article_info(url)
    page_json = JSON.parse(aylien_creator(url))
    page_html = get_html(url)
    wayback = get_wayback_id(url)
    scraped_tags = find_tags(page_html)
    calais_tags = calais(page_json['article'])
    tags = calais_tags.concat(scraped_tags).flatten.map(&:titlecase)
    links = get_links(page_html)

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

    default_image = 'https://github.com/PaideiaDH/classics-archive/blob/master/app/assets/images/owl.png?raw=true'

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
      boilerpipe_text: boilerpipe_text,
      wayback_id: wayback
    }
    @parsed
  end

end
