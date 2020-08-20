class Drink < ActiveRecord::Base
    has_many :orders
    has_many :customers, through: :orders

    def self.all_drinks
        self.all.map(&:name)
    end

end