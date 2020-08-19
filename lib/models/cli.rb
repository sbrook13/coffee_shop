class Cli
    attr_accessor :user, :name

    def initialize user=nil
        @user = nil
    end

    def start
        system "clear"
        puts "WELCOME TO THE DIRTY BEAN COFFEE SHOP!" 
        sleep(1)
        puts "Can I get your name?"
        @name = gets.strip
        system "clear"
        puts "Thanks, " + @name.capitalize + "!"
        sleep(0.5)
        puts "\n"
        puts "I'd be happy to help get the perfectly curated cup for you."
        sleep(1.5)
        puts "\n"
        Drink.all
        # coffee_or_tea
    end    

    def coffee_or_tea
        prompt = TTY::Prompt.new
        system "clear"
        
        choices = %w(Tea Coffee)
        type = prompt.select("What type of drink would you like?", choices, symbols: { marker: ">" })
            if type == "Tea"
                puts "Sorry this is just a coffeehouse. But we highly recommend the Teahouse in Boulder!"
                sleep(1)
                start_over = prompt.yes?("Do you to order a coffee instead?")
                    if start_over == true
                        system "clear"
                        order_options
                    else
                        goodbye
                    end
            else
                system "clear"
                order_options                 
            end  
    end  

    def order_options
        prompt = TTY::Prompt.new
        menu_options = ["I need help deciding..", "I don't know, surprise me!", "I'll come back another time. >> EXIT"]
        choice = prompt.select("You came to the right place! Do you know what you want to order?", menu_options)
            if choice == "I need help deciding.."
                system "clear"
                puts "Great, let's get some more info."
                puts "\n"
                drink_options
            elsif choice == "I don't know, surprise me!"
                random_drink
            else
                goodbye
            end       
    end

    def drink_options
        prompt = TTY::Prompt.new(symbols: {marker: '>'})
        caffeine = prompt.yes?("Do you want a caffeinated drink?")
        milk = prompt.yes?("Do you want milk in your drink?")
            if milk == true
                milk_alt = prompt.select("Which type of milk would you like:", %w(Whole Nonfat Almond Soy Oat))
            else
                puts "Got it."
            end
        sweet = prompt.yes?("Do you want a sweet drink?")
            if sweet == true
                syrup = prompt.select("What flavor do you want in your drink?", %w(Vanilla Mocha Caramel Coconut))
            else
                puts "\n ~~ Yeah... you're sweet enough! ~~"
                puts "\n"
                sleep(0.5)
            end
        temp = prompt.select("Do you want it hot or cold?", %w(Hot Iced Blended)) 
        system "clear"
        if milk == true
            if syrup == true
                confirm = prompt.yes?("So you want a " + temp.downcase + " " + syrup.downcase + " drink with " + milk_alt.downcase + " milk?")
            else
                confirm = prompt.yes?("So you want a " + temp.downcase + " drink with " + milk_alt.downcase + " milk?")
            end    
        else  
            if syrup == true
                confirm = prompt.yes?("So you want a " + temp.downcase + " " + syrup.downcase + " drink?")
            else
                confirm = prompt.yes?("So you want a " + temp.downcase + " drink?")
            end    
        end
        
        system "clear"
        if confirm == true
            puts "Hmmmm.... Let me think...."
            sleep(2.5)
            puts "Here's my suggestion:"
        else
            puts "Let's try again..."
            sleep(1.25)
            drink_options
        end
        
        # drinks = Drink.where(milk: milk, sweet: sweet)                    
    end

    def goodbye
        system "clear"
        puts "Goodbye, " + @name.capitalize + "!"
        sleep(1.5)
        abort
    end    

end