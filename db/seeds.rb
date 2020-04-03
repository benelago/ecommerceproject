AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

scrap = Scraper.new

taxes = scrap.scrape_taxes
guns = scrap.gungeon

shoottype = ["Automatic","Beam","Burst","Charged","Semiautomatic","Varies"]
qualitygrades = ('A'..'F').to_a

# Seeding for provinces and taxes
taxes.each do |tax|
  province = tax[:province]
  province_obj = Province.create(name: province)
  taxes = tax[:tax_names]
  pst = tax[:prov_tax]
  gst = tax[:govt_tax]
  taxes.each do |tax|
    if (tax.strip == 'GST')
      province_obj.taxes.create(name: tax.strip, tax: gst)
    else
      province_obj.taxes.create(name: tax.strip, tax: pst)
    end
  end
end

shoottype.each do |shoot|
  Guntype.create(name: shoot)
end

qualitygrades.each do |grade|
  Quality.create(name: grade)
end

guns.each do |gun|
  Product.create(guntype_id: Guntype.all.sample.id, quality_id: Quality.all.sample.id, name: gun[:name], description: gun[:description], price: rand(10..999))
end

puts "Created #{Tax.count} Taxes."
puts "Created #{Province.count} Provinces."
puts "Created #{Quality.count} Qualities."
puts "Created #{Guntype.count} Guntypes."
puts "Created #{Product.count} Products."