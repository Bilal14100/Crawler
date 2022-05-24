class CreateAmazonSerps < ActiveRecord::Migration[6.0]
  def change
    create_table :amazon_serps do |t|
      t.datetime :parsed_at
      t.string :url
      t.boolean :active, default: true
    end
  end
end
