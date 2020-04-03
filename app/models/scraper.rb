require 'nokogiri'
require 'httparty'
require 'byebug'

#Scraping data for seeding of other websites. B)
class Scraper
  def gungeon
    url = 'https://gungeongod.com/'
    unparsed_page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(unparsed_page)
    guns = parsed_page.css('section:first-of-type').css('.sp-text')
    list = []
    guns.each do |gun|
      x = {
        name: gun.css('h3').text,
        description: gun.css('ul:first-of-type').css('li:first-of-type').text,
        guntype: gun.css('ul:nth-of-type(2n)').css('li:first-of-type').text
      }

      list << x
    end
    list
  end

  def scrape_taxes
    taxes_url = "http://www.calculconversion.com/sales-tax-calculator-hst-gst.html"
    unparsed = HTTParty.get(taxes_url)
    parsed = Nokogiri::HTML(unparsed)

    taxes = []
    tax_listings = parsed.css(".text_calcul").css("table").css("tr")
    tax_listings.each.with_index do |tax_listing, index|
      if index != 0
        tax_by_province = {
          province:  tax_listing.css("th").text,
          tax_names: tax_listing.css("td")[0].text.split("+"),
          prov_tax:  tax_listing.css("td")[1].text.strip.sub("%", "").to_i,
          govt_tax:  tax_listing.css("td")[2].text.strip.sub("%", "").to_i
        }

        taxes << tax_by_province
      end
    end
    taxes
  end

end