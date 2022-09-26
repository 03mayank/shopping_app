FactoryBot.define do
  factory :product do
    name { 	'SONY Alpha ILCE-6400L' }
    description { 'Mirrorless Camera with 16-50mm Power Zoom Lens (Black)'} 
    price { 79990 } 
    stock { 1000 } 
    product_images { [Rack::Test::UploadedFile.new('spec/factories/fixtures/camera.png', 'image/png'), 
      Rack::Test::UploadedFile.new('spec/factories/fixtures/camera1.png', 'image/png')] }
    association :category
  end
end
