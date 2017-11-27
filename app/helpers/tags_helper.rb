module TagsHelper
  # remove related tags and replace with desired tag
  # intended to replace all DJT tags* ('Donald Trump', 'Trump', etc.) to 'trump'
  # *ActsAsTaggableOn::Tag.all.select { |t| /trump/.match(t.name) }.map(&:name)

  def map_related_tags(object, desired_tag_name, array_of_related)
    unless (object.tag_list & array_of_related).empty?
      object.tag_list.remove(array_of_related)
      object.tag_list << desired_tag_name
      object.save
      object.reload
    end
  end

end
