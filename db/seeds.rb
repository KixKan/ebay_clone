require 'faker'

images = Dir.entries(File.open(File.join(Rails.root, "public/sample_images/"))) - [".", ".."]

500.times do
  item =  Item.find_or_create_by(name: Faker::Lorem.word,
                         description: Faker::Lorem.paragraph,
                         price: Faker::Number.number(2),
                         email: "jeromecharles@example.com")

  item.image.store!(File.open(File.join(Rails.root, File.join("public/sample_images/", images.sample))))
  item.save
end

500.times do
  item =  Item.find_or_create_by(name: Faker::Lorem.word,
                         description: Faker::Lorem.paragraph,
                         price: Faker::Number.number(2),
                         email: "andaraluca@example.com")

  item.image.store!(File.open(File.join(Rails.root, File.join("public/sample_images/", images.sample))))
  item.save
end
