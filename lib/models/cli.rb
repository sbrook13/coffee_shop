require 'pry'
class Cli
    attr_accessor :user, :name

    def initialize 
        @user = nil
        @prompt = tty_prompt
        @sweet = nil
        @syrup = nil
        @temp = nil
        @milk = nil
        @milk_alt = nil
        @caffeine = nil
        @final_choice = nil
        @spinner = tty_spinner
    end

    def tty_prompt
        TTY::Prompt.new(
            symbols: {marker:'☕️'}
        )
    end

    def tty_spinner
        spinner = TTY::Spinner.new("[:spinner] Coffee's brewing ...", format: :star)
    end

    def start
        system "clear"
        # App.play_music
        # App.print_coffee_image
        sleep(1)
        puts "WELCOME TO THE DIRTY BEAN COFFEE SHOP!" 
        sleep(1)
        puts "\n"
        is_new_customer = @prompt.yes?('Have you been in before?')
        if is_new_customer == true
            names 
        else
            sign_up
        end
    end

    def sign_up
        puts "Can I get your name?"
        @name = gets.strip
        Customer.create name: name
        welcome
        order_options
    end

    def names 
        system "clear"
        puts "WELCOME BACK!"
        puts "\n"
        names = Customer.all.reduce([]) do |names, customer|
            names << customer.name
        end.sort
        returning_customer = @prompt.select('What is your name:', names)
        @name = returning_customer
        welcome
        return_customer_menu
    end

    def welcome 
        system "clear"
        puts "Thanks, " + @name.capitalize + "!"
        sleep(0.5)
        puts "\n"
        puts "I'd be happy to help get the perfectly curated cup for you."
        sleep(1.5)
        puts "\n"
        @spinner
    end    

    def return_customer_menu
        menu = ["New Order", "See Past Orders", "I'll come back another time. >> EXIT"]
        choice = @prompt.select("How can we help you today?", menu)
            if choice == "New Order"
                order_options
            elsif choice == "See Past Orders"
                system "clear"
                show_past_orders
            else
                goodbye
            end    
    end    

    def show_past_orders
        system "clear"
        reorder = Order.all.map do |order|
            if order.customer.name == @name
                order.drink.name
            end.uniq
        end
        reorder << "New Order"
        order = @prompt.select("Select a drink:", reorder)
        if order == "New Order"
            order_options
        else
            @final_choice = order
            save_final
        end
    end 

    def order_options
        menu_options = ["I need help deciding..", "I don't know, surprise me!", "I'll come back another time. >> EXIT"]
        choice = @prompt.select("Do you know what you want to order?", menu_options)
            if choice == "I need help deciding.."
                system "clear"
                puts "Great, let's get some more info."
                sleep(0.5)
                puts "\n"
                coffee_or_tea
            elsif choice == "I don't know, surprise me!"
                random_drink
            else
                goodbye
            end       
    end

    def coffee_or_tea
        system "clear"
        choices = %w(Tea Coffee)
        type = @prompt.select("What type of drink would you like?", choices)
            if type == "Tea"
                puts "Sorry this is just a coffeehouse. But we highly recommend the Teahouse in Boulder!"
                sleep(1)
                start_over = @prompt.yes?("Do you to order a coffee instead?")
                    if start_over == true
                        system "clear"
                        puts "You came to the right place!"
                        drink_options
                    else
                        goodbye
                    end
            else
                system "clear"
                drink_options                 
            end  
    end 

    def drink_options
        @caffeine = @prompt.yes?("Do you want a caffeinated drink?")
        @milk = @prompt.select("How much milk do you want in your drink? (on a scale 0-3)", %w(0 1 2 3))
            if @milk == "0"
                puts "\n"
                puts "~~ No milk - noted! ~~"
                puts "\n"
            else
                @milk_alt = @prompt.select("Which type of milk would you like:", %w(Whole Nonfat Almond Soy Oat))
            end
        @sweet = @prompt.yes?("Do you want a sweet drink?")
            if @sweet == true
                @syrup = @prompt.select("What flavor do you want in your drink?", %w(Vanilla Mocha Caramel Coconut))
            else
                puts "\n"
                puts "~~ Yeah... you're sweet enough! ~~"
                puts "\n"
                sleep(0.5)
            end
        @temp = @prompt.select("Do you want it hot or cold?", %w(Hot Iced Blended))
        confirm_choice
    end

    def confirm_choice     
        system "clear"
        if @milk == "0"
            if @sweet == true
                confirm = @prompt.yes?("So you want a " + @temp.downcase + " " + @syrup.downcase + " drink?")
            else
                confirm = @prompt.yes?("So you want a " + @temp.downcase + " drink?")
            end    
        else  
            if @sweet == true
                confirm = @prompt.yes?("So you want a " + @temp.downcase + " " + @syrup.downcase + " drink with " + @milk_alt.downcase + " milk?")
            else
                confirm = @prompt.yes?("So you want a " + @temp.downcase + " drink with " + @milk_alt.downcase + " milk?")
            end   
        end
        
        if confirm == true
            @spinner.auto_spin
            sleep(2)
            @spinner.stop(" ☕️ Coffee's ready!")
            #thinking just a different description like.. "thinking.." would be better and I copied this to when the order is finalized
            sleep(1.5)
            results
        else
            puts "Let's try again..."
            sleep(1.25)
            drink_options
        end
    end

    def results    
        drinks = Drink.where(milk: [@milk.to_i, nil], sweet: [@sweet, nil], temp: [@temp.downcase, nil])
        system "clear"
        puts "Here's my suggestion(s):"
        puts "\n"
        i = 1
        drinks.each do |drink|
            if @caffeine == false
                if @sweet == false
                    if @milk == "0"
                        puts "Option #{i}: #{@temp} Decaf #{drink.name}" 
                        puts drink.description
                        puts "______________________________"
                    else
                        puts "Option #{i}: #{@temp} Decaf #{drink.name} with #{@milk_alt} milk" 
                        puts drink.description
                        puts "______________________________"
                    end
                else
                    if @milk == "0"
                        puts "Option #{i}: #{@temp} Decaf #{@syrup} #{drink.name}" 
                        puts drink.description
                        puts "______________________________"
                    else
                        puts "Option #{i}: #{@temp} Decaf #{@syrup} #{drink.name} with #{@milk_alt} milk" 
                        puts drink.description
                        puts "______________________________"  
                    end  
                end         
            else
                if @sweet == false
                    if @milk == "0"
                        puts "Option #{i}: #{@temp} #{drink.name}" 
                        puts drink.description
                        puts "______________________________"
                    else
                        puts "Option #{i}: #{@temp} #{drink.name} with #{@milk_alt} milk" 
                        puts drink.description
                        puts "______________________________"
                    end
                else
                    if @milk == "0"
                        puts "Option #{i}: #{@temp} #{@syrup} #{drink.name}" 
                        puts drink.description
                        puts "______________________________"
                    else
                        puts "Option #{i}: #{@temp} #{@syrup} #{drink.name} with #{@milk_alt} milk" 
                        puts drink.description
                        puts "______________________________"
                    end
                end        
            puts "\n"
            end    
            i+=1
        end  
        sleep(1.5)
        puts"\n"
        drink_choices = drinks.all.map(&:name)
        drink_choices << "Surprise me!"
        selection = @prompt.select("Which would you like today?", drink_choices)

        if selection == "Surprise me!"
            random_drink
        else
            puts "Good choice!"
            @final_choice = Drink.find_by(name: selection)
            save_final
        end
    end

    def random_drink
        system "clear"
        puts "\n"
        puts "Here's a crowd pleaser:"
        puts "\n"
        random = Drink.all.sample
        puts random.name
        puts random.description
        puts "______________________________"
        options = ["Yes", "Try Another Random Drink", "Start Over"]
        answer = @prompt.select("Does that sound good?", options)
        if answer == "Yes"
            @final_choice = Drink.find_by(name: random.name)
            save_final
        elsif answer == "Start Over"
            order_options
        else
            puts "I'll think of another one..."
            sleep(1)
            random_drink
        end    
    end

    def save_final
        save_drink = @prompt.yes?("Do you want to order this drink?")
        system "clear"
        if save_drink
            Order.create(customer: Customer.find_by(name: @name), drink: @final_choice)
            prep_drink
        else
            puts "Let's try another drink!"
            puts "\n"
            order_options
        end    
    end

    def prep_drink
        @spinner.auto_spin
        sleep(1.5)
        @spinner.stop(" ☕️ Coffee's ready!")
        sleep(1.5)
        choices = ["Order Again", "Exit"]
        answer = @prompt.select("What else can we help you with?", choices)
            if answer == "Order Again"
                order_options
            else
                goodbye
            end
    end

    def goodbye
        system "clear"
        # App.print_end_image
        puts "Goodbye, " + @name.capitalize + "!"
        sleep(1)
        # App.stop_music
        abort
    end    

end