class App

    def initialize
        @play_music = play_music
    end

    def self.play_music
        pid = fork{exec 'afplay', "./lib/models/barradeen-bedtime-after-a-coffee.mp3"}
    end

    def self.stop_music
        sleep(20)
        pid = fork{exec 'killall', 'afplay'}
        
    end
   
    def self.print_coffee_image
        Catpix::print_image("./lib/models/coffee1.png",
        options = {
        :limit_x => 1.0,
        :limit_y => 0,
        :center_x => true,
        :center_y => true,
        :bg => "white",
        :bg_fill => true})
    end

    def self.print_end_image
        Catpix::print_image("./lib/models/end_coffee.png",
        options = {
        :limit_x => 1.0,
        :limit_y => 0,
        :center_x => true,
        :center_y => true,
        :bg => "transparent",
        :bg_fill => false})
    end  

end