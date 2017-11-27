class Array
  def included_in?(array)
    array.to_set.superset?(to_set)
  end
  def detrump
    self.each do |item|
      if /trump/i =~ item
        item.replace('Trump')
      elsif /latin/i =~ item
        item.replace('Latin')
      elsif /greek/i =~ item
        item.replace('Greek')
      elsif /yorker/i =~ item
        item.replace('The New Yorker')
      elsif /atlantic/i =~ item
        item.replace('The Atlantic')
      elsif /vatican/i =~ item
        item.replace('The Vatican')
      elsif /book/i =~ item
        item.replace('Books')
      elsif /news/i =~ item
        item.replace('News')
      else
        item
      end
    end
    self.uniq!
  end
  self
end
