require 'dotenv/load'
require 'contentful'
require 'redcarpet'

require_relative 'region'

#prepare markdown renderer
markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)

client = Contentful::Client.new(
  access_token: ENV['CONTENTFUL_ACCESS_TOKEN'],
  space: ENV['CONTENTFUL_SPACE'],
  api_url: 'preview.contentful.com'
)

# get all regions
entries = client.entries(content_type: 'region')

entries.each do |entry|

  body = markdown.render(entry.body)

  banner = client.asset(entry.banner_image.id).image_url width: 300, height: 200, format: 'jpg', quality: 100

  #Hotfix: prefix with 'https:' as we preview with file://
  banner = "https:#{banner}"

  media = entry.media.map do |image|
    "https:#{client.asset(image.id).image_url width: 200, height: 100, format: 'jpg', quality: 50}"
  end

  region = Region.new(entry.title, entry.subtitle, body, banner, media)

  File.open("output/contentful/#{entry.id}.html", 'w') do |f|
    f.write region.render('Contentful')
  end
end

