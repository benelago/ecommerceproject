
# frozen_string_literal: true

require 'nokogiri'
require 'httparty'
require 'byebug'

Gunpla.destroy_all
Series.destroy_all
Scale.destroy_all

def tax_scraper
  url = 'http://www.calculconversion.com/sales-tax-calculator-hst-gst.html'
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page)
  tax_list = parsed_page.css('tr')

  taxes = []

  tax_list.each.with_index do |tax, index|
    if index != 0
      tax_by_province = {
        province: tax.css('th').text,
        gst: tax.css('td')[1].text.strip.sub('%', ''),
        pst: tax.css('td')[2].text.strip.sub('%', '')
      }
      taxes << tax_by_province
    end
  end
  taxes
end

TAXES = tax_scraper

TAXES.each do |tax|
  Province.create(
    name: tax[:name],
    gst: tax[:gst],
    pst: tax[:pst]
  )
end

SERIES = [
  { name: 'Gundam 00',
    description:
  "Mobile Suit Gundam 00 (機動戦士ガンダム00（ダブルオー）, Kidō Senshi Gandamu Daburu Ō, Mobile Suit Gundam Double-O) is an anime television series, the eleventh installment in Sunrise studio's long-running Gundam franchise[1] comprising two seasons. The series is set on a futuristic Earth and is centered on the exploits of the fictional paramilitary organization Celestial Being and its efforts to rid the world of war and conflict with a series of unique and extremely advanced mecha mobile suits known as 'Gundams'." },
  { name: 'Gundam Seed',
    description:
   "Mobile Suit Gundam SEED (機動戦士ガンダムSEED (シード), Kidō Senshi Gandamu Shīdo) is an anime series developed by Sunrise and directed by Mitsuo Fukuda. The ninth installment in the Gundam franchise, Gundam SEED takes place in a future calendar era, in this case the Cosmic Era, the first to do so. In this era, mankind has developed into two subspecies: Naturals, who reside on Earth, and Coordinators, genetically enhanced humans capable of amazing feats of intellect who emigrate to man-made orbital colonies to escape persecution by natural humans. The story revolves around a young Coordinator Kira Yamato who becomes involved in the war between the two races after a third, neutral faction's space colony is invaded by the Coordinators." },
  { name: 'Iron Blooded Orphans',
    description:
   "Mobile Suit Gundam: Iron-Blooded Orphans (Japanese: 機動戦士ガンダム 鉄血のオルフェンズ, Hepburn: Kidō Senshi Gandamu Tekketsu no Orufenzu), also known as Gundam IBO and G-Tekketsu (Gの鉄血), is a 2015 Japanese mecha anime series and the fourteenth installment in Sunrise's long-running Gundam franchise. It is directed by Tatsuyuki Nagai and written by Mari Okada, a team which previously collaborated on Toradora! and Anohana: The Flower We Saw That Day. It aired in Japan on MBS and other JNN stations from October 4, 2015 to March 27, 2016,[2] making this the first Gundam series to return to a Sunday late afternoon time slot since Mobile Suit Gundam AGE. A second season premiered on October 2, 2016. The series follows the exploits of a group of juvenile soldiers who establish their own security company after rebelling against the adults who betrayed them on a futuristic, terraformed Mars." },
  { name: 'Gundam Wing',
    description:
   "Mobile Suit Gundam Wing (新機動戦記ガンダム Ｗ Shin Kidō Senki Gandamu Uingu?, lit. New Mobile Report Gundam Wing) is a 1995 anime television series created by Sunrise. It began broadcast in Japan on April 7, 1995 with the original English-language run of the series beginning on March 6, 2000 on the popular Cartoon Network's Toonami programming block in the United States; becoming the first Gundam series to be broadcast on American television." },
  { name: 'Gundam Build Fighters',
    description:
   "Gundam Build Fighters (ガンダムビルドファイターズ, Gandamu Birudo Faitāzu) is a 2013 Japanese science fiction anime television series based on Sunrise's long-running Gundam franchise. The series is directed by Kenji Nagasaki of No. 6 and written by Yōsuke Kuroda of Mobile Suit Gundam 00. Character designs were done by both Kenichi Ohnuki and Suzuhito Yasuda. The series was first unveiled under the name '1/144 Gundam Mobile' project by Sunrise,[1] before its official announcement. In contrast to other Gundam series, Gundam Build Fighters focuses on the Gundam model (Gunpla) aspect of the franchise." },
  { name: 'Gundam Build Fighters Try',
    description:
   "Gundam Build Fighters Try (ガンダムビルドファイターズトライ, Gandamu Birudo Faitāzu Torai) is a 2014 Japanese science fiction anime television series based on Sunrise's long-running Gundam franchise, and a sequel to the 2013 series Gundam Build Fighters. Like its predecessor, and in contrast to other Gundam series, Gundam Build Fighters Try features a tournament-based storyline where Gunpla models are built, customized, and battled." },
  { name: 'Gundam Build Divers',
    description:
   "Gundam Build Divers (ガンダムビルドダイバーズ, Gandamu Birudo Daibāzu) is a Japanese science fiction anime television series produced by Sunrise, a spiritual successor to the 2013 anime Gundam Build Fighters, based on the long-running Gundam franchise. It is directed by Shinya Watada (Gundam Build Fighters Try) and written by Noboru Kimura (SoltyRei, Dragonar Academy) with character designs by Juri Toida. It was first teased in December 2017 under the title 'Gundam Build Next Battle Project' until its official reveal in The Gundam Base Tokyo on February 2, 2018. It premiered on all TXN network stations in Japan on April 3, 2018.[1] Unlike the previous series, which focuses on the Gundam model (Gunpla) aspect of the franchise, Gundam Build Divers focuses on a virtual reality massively multiplayer online game in terms of themes and battles." },
  { name: 'Gundam Build Divers RE:Rise',
    description:
   "Gundam Build Divers Re:Rise (ガンダムビルドダイバーズRe:RISE, Gandamu Birudo Daibāzu Re:Rise) is a original net animation anime series produced by Sunrise Beyond. A sequel to the 2018 anime Gundam Build Divers, it is the first Gundam series to be released in the Reiwa period, released to celebrate the franchise's 40th anniversary.[1] The series is directed by Shinya Watada and written by Yasuyuki Muto. Initially announced at the Gundam 40th anniversary video, the series aired on its Gundam Channel streaming service in Japan from October 10 to December 26, 2019.[2] A TV airing of the ONA began on Tokyo MX and later in BS11 on October 12, 2019 as part of the Anime+ lineup.[3] A second season is set to premiere in April 9, 2020.[4] Two spinoffs of the series were later serialized in Kadokawa's Gundam Ace magazine and Hobby Japan." }
].freeze

SERIES.each do |series|
  Series.create(
    name: series[:name],
    description: series[:description]
  )
end

SCALES = [
  '1/144',
  '1/100',
  '1/60'
].freeze

SCALES.each do |scale|
  Scale.create(name: scale)
end

def gunpla_scraper(url)
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page)
  products = parsed_page.css('.product_list').css('li')
  gunpla_list = []

  products.each do |product|
    gunpla = {
      name: product.css('.right-block').css('.product-name').text,
      price: product.css('.right-block').css('.product-price').text.sub('$', '').to_i
    }
    gunpla_list << gunpla
  end
  gunpla_list
end

all_products = [
  {
    scale: '1/144',
    series: 'Gundam 00',
    scrape: gunpla_scraper('https://www.canadiangundam.com/39-1144-scale')
  },
  {
    scale: '1/144',
    series: 'Gundam Build Fighters',
    scrape: gunpla_scraper('https://www.canadiangundam.com/51-1144-scale')
  },
  {
    scale: '1/100',
    series: 'Gundam Seed',
    scrape: gunpla_scraper('https://www.canadiangundam.com/32-master-grade')
  },
  {
    scale: '1/144',
    series: 'Iron Blooded Orphans',
    scrape: gunpla_scraper('https://www.canadiangundam.com/69-1144-scale')
  }
]

all_products.each do |product|
  product[:scrape].each do |scrape|
    Gunpla.create(
      name: scrape[:name],
      price: scrape[:price],
      scale_id: Scale.where(name: product[:scale]).first.id,
      series_id: Series.where(name: product[:series]).first.id
    )
  end
end

puts "Created #{Scale.count} scales"
puts "Created #{Series.count} series"
puts "Created #{Province.count} provinces"
puts "Created #{Gunpla.count} gunplas"

if Rails.env.development?
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
end












require "nokogiri"
require "httparty"
require "byebug"

class Scraper
  def scrape_photographers
    photographer_url = "https://www.pocket-lint.com/apps/news/instagram/131470-incredible-photographers-to-follow-on-instagram-right-now"
    # The HTTParty method takes in our URL string, and returns the HTML from that page.
    unparsed = HTTParty.get(photographer_url)
    # Nokogiri's HTML method then takes in our html arguement, and returns to us a set of nodes
    parsed = Nokogiri::HTML(unparsed)

    photographers = []
    photographer_listings = parsed.css(".text-content").css(".nolinks2")
    photographer_descriptions = parsed.css(".text-content").css("p")
    photographer_listings.each.with_index do |photographer_listing, index|
      photographer = {
        name:        photographer_listing.text,
        description: photographer_descriptions[index + 4].text
      }

      photographers << photographer
    end

    photographers
  end

  def scrape_taxes_by_province
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

  def scrape_categories
    categories_url = "https://www.stocksy.com/blog/types-of-photography/"
    unparsed = HTTParty.get(categories_url)
    parsed = Nokogiri::HTML(unparsed)

    categories = []
    category_listings = parsed.css("div.col-md-6").css("div.margin-bottom-lg:not(.image-block)")
    category_listings.each.with_index do |category_listing, index|
      if index != 0 && index != (category_listings.count - 1)
        category = {
          name:        category_listing.css("h3").text,
          description: category_listing.css("p")[0].text
        }
        categories << category
      end
    end

    categories
  end
end