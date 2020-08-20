class App

    def initialize
        @play_music = play_music
        @banner = banner
    end

    def self.play_music
        pid = fork{exec 'afplay', "/Users/goldenolive/Desktop/tasks/coffee_shop/lib/models/barradeen-bedtime-after-a-coffee.mp3"}
    end



    def self.banner
        box = TTY::Box.frame(width: 63, height: 16, align: :center,) do        
        " '  ____  _      _           ____                    
        '   |  _ \(_)_ __| |_ _   _  | __ )  ___  __ _ _ __   
        '   | | | | | '__| __| | | | |  _ \ / _ \/ _` | '_ \  
        '   | |_| | | |  | |_| |_| | | |_) |  __| (_| | | | | 
        '   |____/|_|_|   \__|\__, | |____/ \___|\__,_|_| |_| 
        '     ____       __  _____/          __  ___          
        '    / ___|___  / _|/ _| ___  ___   / / / \ \         
        '   | |   / _ \| |_| |_ / _ \/ _ \ | | / / | |        
        '   | |__| (_) |  _|  _|  __|  __/ | |/ /  | |        
        '    \____\___/|_| |_|  \___|\___| | /_/   | |        
        '                                   \_\   /_/         
    
            "end
            print box
            puts "\n"
            sleep(3.5)
    end
   
    def self.print_coffee_image
        Catpix::print_image("/Users/goldenolive/Desktop/tasks/coffee_shop/lib/models/image.png",
        options = {
        :limit_x => 1.0,
        :limit_y => 0,
        :center_x => true,
        :center_y => true,
        :bg => "white",
        :bg_fill => true})
    end

end