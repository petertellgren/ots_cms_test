require 'dotenv/load'
require 'contentstack'

require_relative 'region'

client = Contentstack::Client.new(
  ENV['CONTENTSTACK_API_KEY'],
  ENV['CONTENTSTACK_ACCESS_TOKEN'],
  ENV['CONTENTSTACK_ENVIROMENT']
)

query = client.content_type('region_page').query
entries = query.include_schema.fetch

entries.each do |entry|
  banner = client.asset(entry.get('banner_image').fetch(:uid)).fetch
  banner_url = banner.url + '?width=300&height=200&format=jpg&quality=100'

  media = entry.get('media').fetch(:file).map do |file|
    asset = client.asset(file.fetch(:uid)).fetch
    asset.url + '?width=200&height=100&format=jpg&quality=50'
  end

  region = Region.new(entry.get('title'), entry.get('subtitle'), entry.get('body'), banner_url, media)

  File.open("output/contentstack/#{entry.get('uid')}.html", 'w') do |f|
    f.write region.render('Contentstack')
  end
end
