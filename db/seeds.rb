# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'
require 'open_uri_redirections'

200.times do
  Article.create!(
    title: Faker::Book.title,
    url: Faker::Internet.url,
    author_last_name: Faker::Name.last_name,
    author_first_name: Faker::LordOfTheRings.character,
    description: Faker::Hobbit.quote,
    type_of: CONTENT_TYPES.sample,
    boilerpipe_text: Faker::Hipster.paragraphs(10),
    site_text: 'nullerino',
    site_name: Faker::Book.publisher,
    image: 'https://www.gstatic.com/webp/gallery3/1_webp_ll.png',
    image_credit: 'N/A',
    approved: true,
    featured: false,
    published_time: Faker::Date.between(20.years.ago, Date.today).to_datetime,
    approved_by: 1,
    submitted_by: 1
  )
end
