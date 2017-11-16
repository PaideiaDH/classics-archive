require 'open-uri'

class Article < ActiveRecord::Base
  include Aylien

  attr_reader :image_remote_url,
              :article_length,
              :author_full_name,
              :pretty_date
  attr_accessor :image_credit

  acts_as_taggable
  acts_as_taggable_on :tags
  has_attached_file :image,
                    default_url: '/images/:style/missing.png',
                    preserve_files: true,
                    styles: {
                      card_top: '500x500'
                    }
  searchkick batch_size: 100

  paginates_per 15

  filterrific(
    default_filter_params: { sorted_by: 'published_on_desc' },
    available_filters: %i[
      sorted_by
      with_query
      with_tag
      with_all_tags
      by_author
      published_by
      published_since
      of_type
    ]
  )

  scope :with_query, (lambda { |query|
    return nil if query.blank?

    ids = search(
      query,
      fields: %i[boilerpipe_text calais_tags],
      match: :word_start
    ).map &:id
    where id: ids
  })

  scope :sorted_by, (lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = sort_option =~ /desc$/ ? 'desc' : 'asc'
    case sort_option.to_s
    when /^random/
      order(
        'RANDOM()'
      ).where(
        approved: true
      )
    when /^published_by_/
      order(
        "articles.site_name #{direction}"
      ).where(
        approved: true
      )
    when /^published_on_/
      order(
        "articles.published_time #{direction}"
      ).where(
        approved: true
      )
    when /^added_on_/
      order(
        "articles.created_at #{direction}"
      ).where(
        approved: true
      )
    when /^by_/
      order(
        "articles.author_last_name #{direction}"
      ).where(
        approved: true
      )
    when /^length_/
      order(
        "LENGTH(articles.boilerpipe_text) #{direction}"
      ).where(
        approved: true
      )
    else
      raise(ArgumentError, "Invalid sort option: #{sort_option.inspect}")
    end
  })

  scope :published_by, (lambda { |query|
    return nil if query.blank?

    ids = search(
      query,
      fields: [:site_name]
    ).map &:id
    where id: ids
  })

  scope :by_author, lambda { |query|

    return nil if query.blank?
    pieces = query.split(' ')
    last_name = pieces[-1]
    first_name = pieces[0..-2].join(' ')

    ids = search(
      last_name,
      fields: [:author_last_name],
      match: :word_start,
      where: { author_first_name: first_name }
    ).map &:id
    where id: ids
  }

  scope :with_tag, lambda { |query|
    ids = search(
      query,
      fields: [:tag_names],
      operator: 'or'
    ).map &:id
    where id: ids
  }

  scope :with_all_tags, lambda { |query|
    ids = search(
      query,
      fields: [:tag_names]
    ).map &:id
    where id: ids
  }

  scope :published_since, (lambda { |query|
    pieces = query.split(' - ')

    start_date = Date.strptime(pieces[0], "%m/%d/%Y")
    end_date = Date.strptime(pieces[1], "%m/%d/%Y")
    date_range = (start_date..end_date).map(&:to_s)
    ids = search(
      where: {
        published_time: date_range
      }
    ).map &:id
    where id: ids
  })

  scope :of_type, (lambda { |query|
    query = query.split(',').reject(&:empty?).uniq

    query.each do |content_type|
      ids = search(
        content_type,
        fields: [:type_of]
      ).map &:id
    end

    uniq_ids = ids.flatten.uniq
    where id: uniq_ids
  })

  def self.options_for_sorted_by
    [
      ['date published ↓', 'published_on_desc'],
      ['date published ↑', 'published_on_asc'],
      ['publication', 'published_by_asc'],
      ['author', 'by_asc'],
      ['random ⚄', 'random']
    ]
  end

  def self.deep_options_for_sorted_by
    [
      ['archived ↓', 'added_on_desc'],
      ['published ↓', 'published_on_desc'],
      ['published ↑', 'published_on_asc'],
      ['author ↓', 'by_asc'],
      ['length ↓', 'length_desc'],
      ['length ↑', 'length_asc'],
      ['random ⚄', 'random']
    ]
  end

  def self.terms
    Article.all.where(approved: true).map(&:calais_tags).flatten.uniq
  end

  validates :title,
            presence: true
  validates :author_first_name,
            presence: true
  validates :author_last_name,
            presence: true
  validates :type_of,
            presence: true
  validates :image,
            presence: true
  validates :image_credit,
            presence: true
  validates :description,
            presence: true
  validates :url,
            presence: true,
            uniqueness: true
  validates :published_time,
            presence: true
  validates_attachment_content_type :image,
                                    content_type: [
                                      'image/jpg',
                                      'image/jpeg',
                                      'image/png',
                                      'image/gif'
                                    ]

  def image_remote_url(url_value)
    self.image = URI.parse(url_value)
    @image_remote_url = url_value
  end

  def author_full_name
    "#{author_first_name} #{author_last_name}"
  end

  def pretty_date
    published_time.strftime('%d %B %Y')
  end

  def search_data
    attributes.merge(
      tag_names: tags.map(&:name)
    )
  end
end
