class CreateOrdersTable < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :drink
      t.references :user
    end
  end
end
