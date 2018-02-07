require 'dotenv/load'
require 'buttercms-ruby'

require_relative 'region'

ButterCMS::api_token = ENV['BUTTERCMS_API_TOKEN']

entries = ButterCMS::Page.list('region')

def resize(url, width, height)
  image_id = /\.com\/(.+)/.match(url).captures.first
  "https://fs.buttercms.com/resize=width:#{width},height:#{height}/#{image_id}"
end

entries.each do |entry|

  banner = resize(entry.fields.banner_image, 300, 200)

  media = entry.fields.media.map do |file|
    resize(file.file, 200, 100)
  end

  region = Region.new(entry.fields.title, entry.fields.subtitle, entry.fields.body, banner, media )

  File.open("output/buttercms/#{entry.slug}.html", 'w') do |f|
    f.write region.render('ButterCMS')
  end

end

