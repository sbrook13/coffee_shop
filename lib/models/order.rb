class Order < ActiveRecord::Base
    belongs_to :drink
    belongs_to :customer

   
    def self.prompt
        TTY::Prompt.new(
            symbols: {marker:'☕️'}
        )
    end

    def self.assign_customer(name)
        @@customer = Customer.all.find_by(name: name)
    end

    def self.order_options
        puts "I'd be happy to help get the perfectly curated cup for you."
        sleep(1.5)
        puts "\n"
        menu_options = ["I need help deciding..", "I don't know, surprise me!", "I'll come back another time. >> EXIT"]
        choice =prompt.select("Do you know what you want to order?", menu_options)
            if choice == "I need help deciding.."
                system "clear"
                puts "Great, let's get some more info."
                sleep(0.5)
                puts "\n"
                coffee_or_tea
            elsif choice == "I don't know, surprise me!"
                random_drink
            else
                Cli.goodbye
            end       
    end

    def self.coffee_or_tea
        system "clear"
        choices = %w(Tea Coffee)
        type = prompt.select("What type of drink would you like?", choices)
            if type == "Tea"
                puts "Sorry this is just a coffeehouse. But we highly recommend the Teahouse in Boulder!"
                sleep(1)
                start_over = prompt.yes?("Do you to order a coffee instead?")
                    if start_over == true
                        system "clear"
                        puts "You came to the right place!"
                        drink_options
                    else
                        Cli.goodbye
                    end
            else
                system "clear"
                drink_options                 
            end  
    end 

    def self.drink_options
        @@caffeine = prompt.yes?("Do you want a caffeinated drink?")
        @@milk = prompt.select("How much milk do you want in your drink? (on a scale 0-3)", %w(0 1 2 3))
            if @@milk == "0"
                puts "\n"
                puts "~~ No milk - noted! ~~"
                puts "\n"
            else
                @@milk_alt = prompt.select("Which type of milk would you like:", %w(Whole Nonfat Almond Soy Oat))
            end
        @@sweet = prompt.yes?("Do you want a sweet drink?")
            if @@sweet == true
                @@syrup = prompt.select("What flavor do you want in your drink?", %w(Vanilla Mocha Caramel Coconut))
            else
                puts "\n"
                puts "~~ Yeah... you're sweet enough! ~~"
                puts "\n"
                sleep(0.5)
            end
        @@temp = prompt.select("Do you want it hot or cold?", %w(Hot Iced Blended))
        confirm_choice
    end

    def self.confirm_choice     
        system "clear"
        if @@milk == "0"
            if @@sweet == true
                confirm = prompt.yes?("So you want a " + @@temp.downcase + " " + @@syrup.downcase + " drink?")
            else
                confirm = prompt.yes?("So you want a " + @@temp.downcase + " drink?")
            end    
        else  
            if @@sweet == true
                confirm = prompt.yes?("So you want a " + @@temp.downcase + " " + @@syrup.downcase + " drink with " + @@milk_alt.downcase + " milk?")
            else
                confirm = prompt.yes?("So you want a " + @@temp.downcase + " drink with " + @@milk_alt.downcase + " milk?")
            end   
        end
        
        if confirm == true
            # spinner.auto_spin
            sleep(2)
            # spinner.stop(" ☕️ Coffee's ready!")
            sleep(1.5)
            results
        else
            puts "Let's try again..."
            sleep(1.25)
            drink_options
        end
    end

    def self.results    
        drinks = Drink.where(milk: [@@milk.to_i, nil], sweet: [@@sweet, nil], temp: [@@temp.downcase, nil])
        system "clear"
        puts "Here's my suggestion(s):"
        puts "\n"
        i = 1
        drink_choices = []
        drinks.each do |drink|
            if @@caffeine == false
                if @@sweet == false
                    if @@milk == "0"
                        puts "Option #{i}: #{@@temp} Decaf #{drink.name}" 
                        puts drink.description
                        puts "______________________________"
                        drink_choices << "#{@@temp} Decaf #{drink.name}"
                    else
                        puts "Option #{i}: #{@@temp} Decaf #{drink.name} with #{@@milk_alt} milk" 
                        puts drink.description
                        puts "______________________________"
                        drink_choices << "#{@@temp} Decaf #{drink.name} with #{@@milk_alt} milk"
                    end
                else
                    if @@milk == "0"
                        puts "Option #{i}: #{@@temp} Decaf #{@@syrup} #{drink.name}" 
                        puts drink.description
                        puts "______________________________"
                        drink_choices << "#{@@temp} Decaf #{@@syrup} #{drink.name}"
                    else
                        puts "Option #{i}: #{@@temp} Decaf #{@@syrup} #{drink.name} with #{@@milk_alt} milk" 
                        puts drink.description
                        puts "______________________________"  
                        drink_choices << "#{@@temp} Decaf #{@@syrup} #{drink.name} with #{@@milk_alt} milk"
                    end  
                end         
            else
                if @@sweet == false
                    if @@milk == "0"
                        puts "Option #{i}: #{@@temp} #{drink.name}" 
                        puts drink.description
                        puts "______________________________"
                        drink_choices << "#{@@temp} #{drink.name}"
                    else
                        puts "Option #{i}: #{@@temp} #{drink.name} with #{@@milk_alt} milk" 
                        puts drink.description
                        puts "______________________________"
                        drink_choices << "#{@@temp} #{drink.name} with #{@@ilk_alt} milk"
                    end
                else
                    if @@milk == "0"
                        puts "Option #{i}: #{@@temp} #{@@syrup} #{drink.name}" 
                        puts drink.description
                        puts "______________________________"
                        drink_choices << "#{@@temp} #{@@syrup} #{drink.name}" 
                    else
                        puts "Option #{i}: #{@@temp} #{@@syrup} #{drink.name} with #{@@milk_alt} milk" 
                        puts drink.description
                        puts "______________________________"
                        drink_choices << "#{@@temp} #{@@syrup} #{drink.name} with #{@@milk_alt} milk"
                    end
                end        
            puts "\n"
            end    
            i+=1
        end  
        sleep(1.5)
        puts"\n"
        drink_choices << "Surprise me!"
        selection = prompt.select("Which sounds good to you?", drink_choices)

        if selection == "Surprise me!"
            random_drink
        else
            puts "Good choice!"
            @@final_choice = Drink.find_by(name: selection)
            @@ordered_drink = selection
            save_final
        end
    end

    def self.random_drink
        system "clear"
        puts "\n"
        puts "Here's a crowd pleaser:"
        puts "\n"
        random = Drink.all.sample
        puts random.name
        puts random.description
        puts "______________________________"
        options = ["Yes", "Try Another Random Drink", "Start Over"]
        answer = prompt.select("Does that sound good?", options)
        if answer == "Yes"
            @@final_choice = Drink.find_by(name: random.name)
            @@ordered_drink = random.name
            save_final
        elsif answer == "Start Over"
            system "clear"
            order_options
        else
            puts "I'll think of another one..."
            sleep(1)
            random_drink
        end    
    end

    def self.save_final
        save_drink = prompt.yes?("Do you want to order this drink?")
        binding.pry
        system "clear"
        if save_drink
            Order.create(customer: @@customer, drink: @@final_choice, ordered_drink: @@ordered_drink)
            Cli.prep_drink
        else
            puts "Let's try another drink!"
            puts "\n"
            Order.order_options
        end    
    end

end