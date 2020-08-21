class Customer < ActiveRecord::Base
    has_many :orders
    has_many :drinks, through: :orders

    validates :name, presence: true

    def self.prompt
        TTY::Prompt.new(
            symbols: {marker:'☕️'}
        )
    end

    def self.sign_up
        puts "Can I get your name?"
        @@name = gets.strip
        create name: @@name
        welcome
        Order.assign_customer(@@name)
        Order.order_options
    end

    def self.names 
        prompt = TTY::Prompt.new
        system "clear"
        system "figlet WELCOME BACK! | lolcat -a -d 5"
        puts "\n"
        names = Customer.all.reduce([]) do |names, customer|
            names << customer.name
        end.sort
        returning_customer = prompt.select('What is your name:', names)
        @@name = returning_customer
        Order.assign_customer(@@name)
        welcome
        Cli.return_customer_menu
    end

    def self.welcome 
        system "clear"
        puts "Thanks, " + @@name.capitalize + "!"
        sleep(0.5)
        puts "\n"
        @spinner
    end

    def self.find_customer_id
        Customer.all.find_by(name: @@name).id
    end


    def self.show_past_orders
        system "clear"
        reorder = Order.all.map do |order|
            if order.customer_id == find_customer_id
                order.ordered_drink
            end
        end
        reorder << "New Order"
        reorder = reorder.uniq
        order = prompt.select("Select a drink:", reorder)
        if order == "New Order"
            Order.order_options
        else
            @@final_choice = order
            Order.save_final
        end
    end 

end
