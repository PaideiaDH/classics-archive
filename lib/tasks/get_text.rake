namespace :ArticleText do
  desc 'updates articles missing boilerpipe text'
  task update: :environment do
    include Text
    Text.backfill
    puts "Texts updated #{Time.now}"
  end
end
