class AddOrderedDrinkToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :ordered_drink, :string
  end
end
