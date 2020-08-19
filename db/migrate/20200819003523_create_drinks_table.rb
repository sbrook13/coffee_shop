class CreateDrinksTable < ActiveRecord::Migration[6.0]
  def change
    create_table :drinks do |t|
      t.string :name
      t.text :description
      t.boolean :caffeine
      t.string :milk
      t.boolean :sweet
      t.string :temp
    end
  end
end
