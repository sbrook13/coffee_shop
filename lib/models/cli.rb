class Cli
    attr_accessor :user, :name

    def initialize user=nil
        @user = nil
        @prompt = tty_prompt
        @sweet = nil
        @syrup = nil
        @temp = nil
        @milk = nil
        @milk_alt = nil
        @caffeine = nil
        @final_choice = nil
    end

    def tty_prompt
        TTY::Prompt.new(
            symbols: {marker:'☕️'}            
        )
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
<<<<<<< HEAD
<<<<<<< HEAD
=======

>>>>>>> 03a88f2e836fb1ca03370b555ad63cc5da94cf7d
=======

>>>>>>> 7638095c99b224967b77ec463da2e0d581b0425d
        coffee_or_tea
    end    

    def coffee_or_tea
        system "clear"
        
        choices = %w(Tea Coffee)
        type = @prompt.select("What type of drink would you like?", choices, symbols: { marker: ">" })
            if type == "Tea"
                puts "Sorry this is just a coffeehouse. But we highly recommend the Teahouse in Boulder!"
                sleep(1)
                start_over = @prompt.yes?("Do you to order a coffee instead?")
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
        menu_options = ["I need help deciding..", "I don't know, surprise me!", "I'll come back another time. >> EXIT"]
        choice = @prompt.select("You came to the right place! Do you know what you want to order?", menu_options)
            if choice == "I need help deciding.."
                system "clear"
                puts "Great, let's get some more info."
                sleep(0.5)
                puts "\n"
                drink_options
            elsif choice == "I don't know, surprise me!"
                random_drink
            else
                goodbye
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
            puts "Hmmmm.... Let me think...."
            sleep(2.5)
            results
        else
            puts "Let's try again..."
            sleep(1.25)
            drink_options
        end
    end

    def results    
        drinks = Drink.where(milk: @milk.to_i, sweet: @sweet || nil)
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
            i+=1
            end    
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
            save_final
        end
    end

    def save_final
        @prompt.yes?("Do you want to save this drink?")
        @final_choice = Drink.find_by name: selection
    end

    def random_drink
        puts "\n"
        puts "Here's a crowd pleaser:"
        puts "\n"
        random = Drink.all.sample
        puts random.name
        puts random.description
        puts "______________________________"
        answer = @prompt.yes?("Does that sound good?")
        if answer == true
            save_final
        else
            puts "I'll think of another one..."
            random_drink
        end    
    end

    def goodbye
        system "clear"
        puts "Goodbye, " + @name.capitalize + "!"
        sleep(1.5)
        abort
    end    

end