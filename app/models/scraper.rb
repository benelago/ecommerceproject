require 'nokogiri'
require 'httparty'
require 'byebug'

# in scraper.rb
class Aso
    def gunrape
      url = 'https://gungeongod.com/'
      unparsed_page = HTTParty.get(url)
      parsed_page = Nokogiri::HTML(unparsed_page)
      guns = parsed_page.css('section:first-of-type').css('.sp-text')
  
      list = []
  
      guns.each do |gun|
        x = {
          name: gun.css('h3').text
        }
        list << x
      end
      list
    end
  end
  
