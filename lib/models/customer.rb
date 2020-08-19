class Customer < ActiveRecord::Base
    has_many :orders
    has_many :drinks, through: :orders

    validates :name, presence: true



    def save_drink(drink)
        drink_choice = Order.create(customer: self, drink: drink)
    end
end
