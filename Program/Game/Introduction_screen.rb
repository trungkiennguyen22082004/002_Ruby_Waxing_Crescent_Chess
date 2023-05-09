class Chess < Gosu::Window
    def intro_screen_setting_up()
        @screen = 0

        # Set up the variables for the logos in intro screen
        @image_swinburne_logo = Gosu::Image.new('Media/Image_Swinburne_logo.png')
        @image_moon_logo = Gosu::Image.new('Media/Image_Moon_Logo.png')

        @sound_intro = Gosu::Sample.new('Media/Sound_Linux_Startup.wav')

        @x_1 = 610
        @y_1 = 240
        @x_2 = 300
        @y_2 = 40
        @z_1 = @z_2 = 0
    end

    def intro_screen_updating()
        if (@x_1 >= 270)
            @x_1 -= 5
        else
            @y_1 -= 2 if (@y_1 >= 140)
        end
        if (@x_1 >= 310)
            @z_1 = -1
        else
            @z_1 = 0
        end

        if (@x_2 <= 680)
            @x_2 += 5
        else
            @y_2 += 2 if (@y_2 <= 140)
        end
        if (@y_2 < 80)
            @z_2 = -1
        else
            @z_2 = 0
        end
    end

    def intro_screen_drawing()
        draw_quad(1200, 800, Gosu::Color.argb(0xff_00008b), 0, 800, Gosu::Color.argb(0xff_00008b), 0, 400, Gosu::Color::BLACK, 1200, 400, Gosu::Color::BLACK, 0)
            
        # Make movement for the logos
        Gosu.draw_rect(0, 0, 600, 200, Gosu::Color::BLACK, 0)
        Gosu.draw_rect(600, 0, 600, 200, Gosu::Color::BLACK, -1)
        Gosu.draw_rect(0, 200, 600, 200, Gosu::Color::BLACK, -1)
        Gosu.draw_rect(600, 200, 600, 200, Gosu::Color::BLACK, 0)

        @image_swinburne_logo.draw(@x_1, @y_1, @z_1)

        @image_moon_logo.draw(@x_2, @y_2, @z_2, 0.2, 0.2)

        @sound_intro.play(1.5) if (Gosu.milliseconds >= 250) && (Gosu.milliseconds < (250 + (50 / 3)))
        @screen = 1 if (Gosu.milliseconds > 5000)                                  # Change to main screen after 5 seconds
    end
end