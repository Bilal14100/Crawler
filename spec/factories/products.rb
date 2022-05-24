FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    price {"$9.04"}
    customer_review {"4.6 out of 5 stars"}
    customer_review_count {rand(1..10000)}
    shipping_message {}
    asin {(0...10).map { ('a'..'z').to_a[rand(26)] }.join}
    image {"https://m.media-amazon.com/images/I/61i0CV-tKpL._AC_UY218_.jpg"}
    url {"https://www.amazon.com/AmazonBasics-3-Button-Wired-Computer-1-Pack/dp/B005EJH6RW/"}
    is_prime {[true, false].sample}
  end
end
