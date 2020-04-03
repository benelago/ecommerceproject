require 'nokogiri'
require 'httparty'
require 'byebug'

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

# def tax_scraper
#     url = 'http://www.calculconversion.com/sales-tax-calculator-hst-gst.html'
#     unparsed_page = HTTParty.get(url)
#     parsed_page = Nokogiri::HTML(unparsed_page)
#     tax_list = parsed_page.css('tr')
  
#     taxes = []
  
#     tax_list.each.with_index do |tax, index|
#       if index != 0
#         tax_by_province = {
#           province: tax.css('th').text,
#           gst: tax.css('td')[1].text.strip.sub('%', ''),
#           pst: tax.css('td')[2].text.strip.sub('%', '')
#         }
#         taxes << tax_by_province
#       end
#     end
#     taxes
#   end
  
#   TAXES = tax_scraper
  
#   TAXES.each do |tax|
#     Province.create(name: province["name"])
#   end




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
        # quality: gun.css('ul:nth-of-type(2n)').css('li:nth-of-type(4n)').css('span')['class'] == nil ? "" : gun.css('ul:nth-of-type(2n)').css('li:nth-of-type(4n)').css('span')['class']
        }
        list << x
    end
    list
end

guns = gungeon

randomprice = rand(10..999)

guns.each 







shoottype = ["Automatic","Beam","Burst","Charged","Semiautomatic","Varies"]

shoottype.each do |shoot|
  Guntype.create(name: shoot)
end


qualitygrades = ('A'..'F').to_a

qualitygrades.each do |grade|
  Quality.create(name: grade)
end



puts "Created #{Quality.count}"
puts "Created #{Guntype.count}"