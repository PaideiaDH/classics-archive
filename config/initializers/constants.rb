# frozen_string_literal: true
ADMINS = [32, 15, 23, 37, 38]

RSS_SOURCES = [
  'https://eidolon.pub/feed',
  'https://thesphinxblog.com/feed/',
  'https://rfkclassics.blogspot.com/feeds/posts/default?alt=rss',
  'https://www.the-tls.co.uk/category/a-dons-life/feed/',
  'https://www.theguardian.com/education/classics/rss',
  'http://ancientworldonline.blogspot.com/feeds/posts/default?alt=rss',
  'https://www.latinitium.com/blog?format=rss',
  'http://ancientimes.blogspot.com/feeds/posts/default?alt=rss'
].freeze

TAG_RECS = [
  'Latin',
  'Ancient Greek',
  'Ancient Roman Culture',
  'Ancient Greek Culture',
  'Italian',
  'Modern Greek',
  'Ancient Rome',
  'Middle Ages',
  'Renaissance',
  'Art',
  'Music',
  'Education',
  'Pedagogy',
  'Language',
  'Archaeology',
  'Race',
  'Gender',
  'Diversity',
  'Politics',
  'History',
  'Philosophy',
  'Literature',
  'Feminism',
  'Metascholarship',
  'Ancient vs. Modern',
  'Social Justice',
  'Religion',
  'Western Civilization',
  'Translation',
  'Heritage',
  'Emotion',
  'Museums',
  'International Relations',
  'Racism',
  'Populism',
  'Manuscript',
  'Globalization',
  'Foreign Policy',
  'Mythology',
  'Art History',
  'Film',
  'Sexuality',
  'Inequality',
  'Pop Culture',
  'Humor',
  'Reception',
  'Food',
  'Orientalism',
  'Ancient Science',
  'Greek Tragedy',
  'Law'
].sort.map { |t| [t] }.freeze

CONTENT_TYPES = [
  'News',
  'Blog Post',
  'Editorial',
  'Journal Article',
  'Book Review',
  'Film Review',
  'Theater Review',
  'Television Review',
  'Art Review',
  'Essay',
  'Photography',
  'Interview'
].freeze

ALL_ARTICLES = Article.includes(:tags)
ALL_AUTHORS =  ALL_ARTICLES.select(&:approved?).map(&:author_full_name).uniq.join(',')
ALL_PUBLISHERS = Article.all.select(&:approved?).map(&:site_name).uniq.join(',')
ALL_TAGS = ActsAsTaggableOn::Tag.all.order(taggings_count: :desc).map(&:name)
