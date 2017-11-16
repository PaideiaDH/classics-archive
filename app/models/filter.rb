module Filter
  def describe_filters(hash)
    fils = []
    hash.each { |k,v|
      unless k == "sorted_by"
        if k == 'published_since'
          pieces = v.split(' - ')
          start_date = Date.strptime(pieces[0], "%m/%d/%Y")
          end_date = Date.strptime(pieces[1], "%m/%d/%Y")
          cal_start = start_date.strftime('%D')
          cal_end = end_date.strftime('%D')
          fils << "published between #{cal_start} and #{cal_end}"
        elsif k == 'with_tag'
          or_statement = listify v, 'or'
          fils << "with tag #{or_statement}"
        elsif k == 'with_all_tags'
          and_statement = listify v
          fils << "with tags #{and_statement}"
        else
          fils << "#{k.humanize.downcase} #{v}"
        end
      end
    }
    fils.join(' and ')
  end
end
