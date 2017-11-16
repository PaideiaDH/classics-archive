# # require 'pry'
#
# module WebScraper
#   include Calais
#
#   def article_creator(url)
#     # GET AND PARSE FULL PAGE HTML
#     url = url.split('?')[0]
#
#     page = HTTParty.get(url)
#     parse_page = Nokogiri::HTML(page)
#     site_text_string = parse_page.to_s.force_encoding("UTF-8")
#
#     # GET BOILERPIPE RESULT
#     boilerpipe_url = "https://boilerpipe-web.appspot.com/extract?url=#{URI.escape(url)}&extractor=ArticleExtractor&output=text&extractImages=&token="
#     if pismo.body.blank?
#       @boilerpipe_text = HTTParty.get(boilerpipe_url)
#       @boilerpipe_text = @boilerpipe_text.to_s.force_encoding("UTF-8")
#     else
#       # @boilerpipe_text = pismo.body
#     end
#     @calais_tags = calais(@boilerpipe_text)
#
#     # FIND TITLE
#     if page.success?
#       if  parse_page.at("meta[property='og:title']")
#         @title = parse_page.at("meta[property='og:title']")['content']
#       elsif parse_page.at("meta[name='parsely-page']")
#         if JSON.parse(parse_page.at("meta[name='parsely-page']")['content'])['title']
#           @title = JSON.parse(parse_page.at("meta[name='parsely-page']")['content'])['title']
#         else
#           @title = nil
#         end
#       elsif parse_page.at("title").children
#         @title = parse_page.at("title").children.text
#       else
#         @title = nil
#       end
#
#       # FIND AUTHOR
#       # if !pismo.author.blank?
#       # elsif parse_page.at("meta[property='author']")
#       #   @author = parse_page.at("meta[property='author']")['content']
#       # elsif url.include? 'rfkclassics'
#       #   @author = 'Rebecca Futo Kennedy'
#       # elsif url.include? 'thesphinxblog'
#       #   @author = 'Neville Morley'
#       # elsif url.include? 'ancientworldonline'
#       #   @author = 'Charles Jones'
#       # elsif url.include? 'the-tls'
#       #   @author = 'Mary Beard'
#       # elsif parse_page.at("meta[name='author']")
#       #   @author = parse_page.at("meta[name='author']")['content']
#       # elsif parse_page.at("meta[name='authors']")
#       #   @author = parse_page.at("meta[name='authors']")['content']
#       # elsif parse_page.at("meta[name='parsely-page']")
#       #   if  JSON.parse(parse_page.at("meta[name='parsely-page']")['content'])['authors']
#       #     @author = JSON.parse(parse_page.at("meta[name='parsely-page']")['content'])['authors'].join(', ')
#       #   else
#       #     @author = nil
#       #   end
#       # elsif parse_page.at("meta[property='article:author']")
#       #   @author = parse_page.at("meta[property='article:author']")['content']
#       # elsif parse_page.at("meta[name='byl']")
#       #   @author = parse_page.at("meta[name='byl']")['content'].sub(/BY[ :]/i, '')
#       # elsif parse_page.at("meta[name='twitter:creator']")
#       #   @author = parse_page.at("meta[name='twitter:creator']")['content']
#       # else
#       #   @author = nil
#       # end
#       #
#       # @type_of = "article"
#       # if parse_page.at("meta[property='og:type']")
#       #   @type_of = parse_page.at("meta[property='og:type']")['content']
#       # elsif parse_page.at("meta[name='parsely-page']")
#       #    if JSON.parse(parse_page.at("meta[name='parsely-page']")['content'])['type']
#       #      @type_of = JSON.parse(parse_page.at("meta[name='parsely-page']")['content'])['type']
#       #    else
#       #      @type_of = "article"
#       #    end
#       # elsif parse_page.at("meta[name='PT']")
#       #   @type_of = parse_page.at("meta[name='PT']")['content']
#       # else
#       #   @type_of = "article"
#       # end
#
#       # FIND IMAGE
#       # if url.include? 'thesphinxblog'
#       #   @image = 'https://bristolclassics.files.wordpress.com/2011/11/cropped-easter-2009-172.jpg'
#       # elsif url.include? 'ancientworldonline'
#       #   @image = 'http://dhawards.org/wp-content/uploads/2016/03/DHAwards2015-blog.png'
#       # elsif parse_page.at("meta[property='og:image']")
#       #   @image = parse_page.at("meta[property='og:image']")['content']
#       # elsif parse_page.at("meta[name='parsely-page']")
#       #   if JSON.parse(parse_page.at("meta[name='parsely-page']")['content'])['image_url']
#       #     @image = JSON.parse(parse_page.at("meta[name='parsely-page']")['content'])['image_url']
#       #   else
#       #     @image = nil
#       #   end
#       # elsif parse_page.at("meta[property='twitter:image']")
#       #   @image = parse_page.at("meta[property='twitter:image']")['content']
#       # else
#       #   @image = 'https://static1.squarespace.com/static/57600285f699bb9740cbd53b/t/57cf0af315d5dba471549ecb/1473186552334/'
#       # end
#
#       # FIND IMAGE CREDIT
#       image_phrases = ['art by', 'image by', 'image ©', 'image credit', 'credit', 'copyright', 'image copyright']
#       instances = image_phrases.map { |text| site_text_string.index(text) }
#       if ind = instances.find_index { |t| t.class == Fixnum }
#         @image_credit = site_text_string[instances[ind], 75]
#       else
#         if @site_name && @published_time
#           @image_credit = "© #{@site_name} #{@published_time.strftime('%Y')}"
#         else
#           @image_credit = "NEEDS IMAGE CREDIT"
#         end
#       end
#
#       # FIND DESCRIPTION
#       if parse_page.at("meta[property='og:description']")
#         @description = parse_page.at("meta[property='og:description']")['content']
#       elsif parse_page.at("meta[property='twitter:description']")
#         @description = parse_page.at("meta[property='twitter:description']")['content']
#       else
#         @description = nil
#       end
#
#       # FIND SITE NAME
#       if parse_page.at("meta[property='og:site_name']")
#         @site_name = parse_page.at("meta[property='og:site_name']")['content']
#       elsif url.include? 'ancientworldonline'
#         @site_name = 'Ancient World Online'
#       elsif url.include? 'rfk'
#         @site_name = 'Classics at the Intersections'
#       elsif parse_page.at("meta[property='al:android:app_name']")
#         @site_name = parse_page.at("meta[property='al:android:app_name']")['content']
#       else
#         @site_name = nil
#       end
#
#       # FIND PERMANENT URL
#       if parse_page.at("link[rel='canonical']")
#         @url = parse_page.at("link[rel='canonical']")['href']
#       elsif parse_page.at("meta[name='parsely-page']")
#         if JSON.parse(parse_page.at("meta[name='parsely-page']")['content'])['link']
#           @url = JSON.parse(parse_page.at("meta[name='parsely-page']")['content'])['link']
#         else
#           @url = url
#         end
#       elsif parse_page.at("meta[property='og:url']")
#         @url = parse_page.at("meta[property='og:url']")['content']
#       else
#         @url = url
#       end
#
#       # FIND DATE AND TIME PUBLISHED
#       if parse_page.at("meta[property='article:published_time']")
#         @published_time = parse_page.at("meta[property='article:published_time']")['content'].to_datetime
#       elsif parse_page.at("meta[name='parsely-page']")
#         if JSON.parse(parse_page.at("meta[name='parsely-page']")['content'])['pub_date']
#           @published_time = JSON.parse(parse_page.at("meta[name='parsely-page']")['content'])['pub_date'].to_datetime
#         else
#           @published_time = nil
#         end
#       elsif parse_page.at("script[type='application/ld+json']")
#         if JSON.parse(parse_page.at("script[type='application/ld+json']"))['datePublished']
#           @published_time = JSON.parse(parse_page.at("script[type='application/ld+json']"))['datePublished'].to_datetime
#         else
#           @published_time = nil
#         end
#       elsif parse_page.at("meta[name='pdate']")
#         @published_time = parse_page.at("meta[name='pdate']")['content'].to_datetime
#       elsif url[/[12][0-9][0-9][0-9]\/[01][0-9]\/[0-3][0-9]/]
#         @published_time = url[/[12][0-9][0-9][0-9]\/[01][0-9]\/[0-3][0-9]/].to_datetime
#       else
#         @published_time = nil
#       end
#
#       # FIND PUBLISHED TAGS
#       @tags = []
#       # @tags << @published_time.strftime('%B %Y') unless @published_time.nil?
#       @tags << @site_name.gsub(/,/, '') unless @site_name.nil?
#       @tags << @author.gsub(/,/, '') unless @author.nil?
#       if parse_page.at("meta[name='keywords']")
#         @tags += parse_page.at("meta[name='keywords']")['content'].split(',')
#       elsif parse_page.at("meta[name='parsely-page']")
#         if JSON.parse(parse_page.at("meta[name='parsely-page']")['content'])['tags']
#         @tags += JSON.parse(parse_page.at("meta[name='parsely-page']")['content'])['tags']
#         end
#       # elsif parse_page.at("script[type='application/ld+json']")['keywords']
#       #   @tags += JSON.parse(parse_page.at("script[type='application/ld+json']"))['keywords'].to_a
#       elsif parse_page.at("meta[property='article:tag']")
#         @tags += [parse_page.at("meta[property='article:tag']")['content']]
#       elsif parse_page.at("meta[name='collections']")
#         @tags += parse_page.at("meta[name='collections']")['content'].split(",").to_a
#       else
#         @tags
#       end
#       # FILTER AND ALIAS TAGS FOR COMMON KEYWORDS
#       @tags.concat @calais_tags unless @boilerpipe_text.include? '<html>'
#       @tags.detrump
#
#       if @author
#         parts = @author.split(' ')
#         @author_last_name = parts[-1]
#         @author_first_name = parts[0..-2].join(' ')
#
#       else
#         @author_first_name = nil
#         @author_last_name = nil
#       end
#
#       @parsed = {
#        title: @title,
#        author_first_name: @author_first_name,
#        author_last_name: @author_last_name,
#        type_of: @type_of,
#        image: @image,
#        image_credit: @image_credit,
#        description: @description,
#        site_name: @site_name,
#        url: @url,
#        published_time: @published_time,
#        tags: @tags,
#        site_text: parse_page,
#        boilerpipe_text: @boilerpipe_text
#       }
#       return @parsed
#     end
#   else
#     @parsed = {
#       title: nil,
#       author_first_name: nil,
#       author_last_name: nil,
#       type_of: "article",
#       image: nil,
#       image_credit: nil,
#       description: "an article shared by the Paideia Institute",
#       site_name: nil,
#       url: url,
#       published_time: nil,
#       tags: nil,
#       site_text: nil,
#       boilerpipe_text: nil
#     }
#     return @parsed
#   end
# end
