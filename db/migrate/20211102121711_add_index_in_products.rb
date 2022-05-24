class AddIndexInProducts < ActiveRecord::Migration[6.0]
  def change
    add_index :products, :asin
  end
end
