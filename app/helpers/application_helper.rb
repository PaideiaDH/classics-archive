module ApplicationHelper
  def acronym(name)
     name.scan(/[[:upper:]]/).join("")
  end

  def get_text(url)
    boilerpipe_url = "https://boilerpipe-web.appspot.com/extract?url=#{URI.escape(url)}&extractor=ArticleExtractor&output=text&extractImages=&token="
    return HTTParty.get(boilerpipe_url).to_s.force_encoding("UTF-8")
  end

  def listify(arr, conjunction = 'and')
    if arr.length == 1
      arr[0]
    else
      last = arr[-1]
      beginning = arr[0..-2]
      "#{beginning.join(', ')} #{conjunction} #{last}"
    end
  end
end
