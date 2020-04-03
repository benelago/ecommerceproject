require 'nokogiri'
require 'httparty'
require 'byebug'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?


# def gungeon
#     url = 'https://gungeongod.com/'
#     unparsed_page = HTTParty.get(url)
#     parsed_page = Nokogiri::HTML(unparsed_page)
#     guns = parsed_page.css('section:first-of-type').css('.sp-text')

#     list = []

#     guns.each do |gun|
#         x = {
#         name: gun.css('h3').text,
#         description: gun.css('ul:first-of-type').css('li:first-of-type').text,
#         guntype: gun.css('ul:nth-of-type(2n)').css('li:first-of-type').text
#         # quality: gun.css('ul:nth-of-type(2n)').css('li:nth-of-type(4n)').css('span')['class'] == nil ? "" : gun.css('ul:nth-of-type(2n)').css('li:nth-of-type(4n)').css('span')['class']
#         }
#         list << x
#     end
#     guns
# end

# pp gungeon