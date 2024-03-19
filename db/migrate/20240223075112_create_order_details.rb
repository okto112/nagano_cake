class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      t.references :order, foreign_key: { to_table: :orders }, type: :integer
      t.references :item, foreign_key: { to_table: :items }, type: :integer
      t.integer :amount, null: false
      t.integer :purchase_price, null: false
      t.integer :making_status, null: false
      t.timestamps
    end
  end
end
