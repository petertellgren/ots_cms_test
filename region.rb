require 'erb'

class Region

  attr_accessor :title, :subtitle, :body, :banner, :media, :platform

  def initialize(title, subtitle, body, banner, media = [])
    @title = title
    @subtitle = subtitle
    @body = body
    @banner = banner
    @media = media
    @template = File.read('templates/region.html.erb')
  end

  def render(platform)
    @platform = platform
    ERB.new(@template).result( binding )
  end
end
