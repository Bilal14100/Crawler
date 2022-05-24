class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.text :name
      t.string :price
      t.string :customer_review
      t.integer :customer_review_count
      t.text :shipping_message
      t.string :asin
      t.string :image
      t.text :url
      t.boolean :is_prime
      # t.boolean :sponsored_ad
      # t.string :coupon_info
      # t.string :badges_info, array: true
    end
  end
end



