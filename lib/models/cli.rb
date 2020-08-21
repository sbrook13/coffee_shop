require 'pry'
class Cli
    attr_accessor :user, :name

    def initialize 
        @user = nil

    end

    def self.prompt
        TTY::Prompt.new(
            symbols: {marker:'☕️'}
        )
    end

    def self.spinner
        TTY::Spinner.new("[:spinner] Coffee's brewing ...", format: :star)
    end

    def start
        prompt = TTY::Prompt.new
        system "clear"
        App.play_music
        App.print_coffee_image
        sleep(1)
        puts "\n"
        puts "WELCOME TO THE DIRTY BEAN COFFEE SHOP!" 
        sleep(1)
        puts "\n"
        if Customer.all.count == 0
            Customer.sign_up
        else
            is_new_customer = prompt.yes?('Have you been in before?')
            if is_new_customer == true
                Customer.names 
            else
                Customer.sign_up
            end
        end
    end  

    def self.return_customer_menu
        prompt = TTY::Prompt.new
        menu = ["New Order", "See Past Orders", "I'll come back another time. >> EXIT"]
        choice = prompt.select("How can we help you today?", menu)
            if choice == "New Order"
                Order.order_options
            elsif choice == "See Past Orders"
                system "clear"
                Customer.show_past_orders
            else
                goodbye
            end    
    end     

    def self.prep_drink
        # spinner.auto_spin
        sleep(2)
        # spinner.stop(" ☕️ Coffee's ready!")
        sleep(0.5)
        choices = ["Order Again", "Exit"]
        answer = prompt.select("What else can we help you with?", choices)
            if answer == "Order Again"
                Order.order_options
            else
                goodbye
            end
    end

    def self.goodbye
        system "clear"
        App.print_end_image
        puts "\n"
        puts "Goodbye!"
        sleep(1)
        App.stop_music
        abort
    end  


end