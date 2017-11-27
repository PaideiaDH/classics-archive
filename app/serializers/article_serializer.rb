class ArticleSerializer < ActiveModel::Serializer
  attributes :id,
             :title,
             :url,
             :description,
             :created_at,
             :author_first_name,
             :author_last_name,
             :site_name,
             :pretty_date

  has_one :image
  has_many :tags
end
