module Publisher
  def publisher(html, url)
    if html.at("meta[property='og:site_name']")
      site_name = html.at("meta[property='og:site_name']")['content']
    elsif url.include? 'ancientworldonline'
      site_name = 'Ancient World Online'
    elsif url.include? 'rfk'
      site_name = 'Classics at the Intersections'
    elsif html.at("meta[property='al:android:app_name']")
      site_name = html.at("meta[property='al:android:app_name']")['content']
    else
      site_name = nil
    end
    site_name
  end
end
