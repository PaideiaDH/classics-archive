namespace :all_articles do
  desc 'generates ActiveRecord Relation for all articles in database'
  task generate: :environment do
    ALL_ARTICLES = Article.includes(:tags)
    ALL_AUTHORS =  ALL_ARTICLES.select(&:approved?).map(&:author_full_name).uniq.join(',')
    ALL_PUBLISHERS = Article.all.select(&:approved?).map(&:site_name).uniq.join(',')
    ALL_TAGS = ActsAsTaggableOn::Tag.all.order(taggings_count: :desc).map(&:name)

    puts "Articles ActiveRecord dump updated #{Time.now}"
  end
end
