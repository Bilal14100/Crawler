FactoryBot.define do
  factory :amazon_serp do
    parsed_at { DateTime.now }
    active {true}
    url { "https://www.amazon.com/s?k=mouse&ref=nb_sb_noss" }
  end
end
