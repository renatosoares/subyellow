class Window < Gosu::Window

    def initialize
        super(640,480,false)
        self.caption = "Gama"
        @player = Player.new(self)
        @tubarao = rand(1..2).times.map {Tubarao.new(self)}
        @subinimigo = rand(1..3).times.map {SubInimigo.new(self)}
        @mergulhador = 1.times.map {Mergulhador.new(self)}
        @timer = Timer.new(self, @tubarao, @subinimigo, @mergulhador) #objeto para controlar o tempo de aparição dos inimigos
        @running = true
        @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
        @texto = Gosu::Font.new(self, Gosu::default_font_name, 20)
        @background = Gosu::Image.new(self, "fundo.png", true)
        #@inicio = Gosu::Sample.new(@window, "start_game.mp3")
        @oxigenio = Oxigenio.new(self, @player)
        @barra_oxigenio = Gosu::Font.new(self, Gosu::default_font_name, 20)
        @tempo_barra_oxigenio = Gosu::Font.new(self, Gosu::default_font_name, 20)

    end
    
    def update
        if @running

            if @player.hit_by? live_inimigos 
                @running = false
            elsif (@oxigenio.oxigenio_vidas)
                @running = false
            else
                run_game

            end
        end
        
        if not @running and button_down? Gosu::Button::KbR and @player.lives > 0
            @running = true
            @player.reset_position
            @oxigenio.restaura_oxigenio(true)
        end
    end
    
    def run_game
        live_inimigos.each {|tubarao| tubarao.update(@player.laser)}
        live_inimigos.each {|subinimigo| subinimigo.update(@player.laser)}        
        resgate_mergulhador.each {|mergulhador| mergulhador.update(@player)} 
        @player.update
        @timer.update
        @oxigenio.update
        
    end
    def resgate_mergulhador
        @mergulhador.select {|mergulhador| mergulhador.alive == true}

    end
    def live_inimigos
        @tubarao.select {|tubarao| tubarao.alive == true} +
        @subinimigo.select {|subinimigo| subinimigo.alive == true}

    end
    
    def draw
        @background.draw(0,0,1)
        @player.draw
        live_inimigos.each {|subinimigo| subinimigo.draw}
        live_inimigos.each {|tubarao| tubarao.draw}
        resgate_mergulhador.each {|mergulhador| mergulhador.draw}
        @tempo_barra_oxigenio.draw("tempo: #{@oxigenio.tempo.to_i}", 10, 430, 3.0, 1.5, 1.0, 0xffffffff)
        @barra_oxigenio.draw("oxigenio: #{@oxigenio.barra}", 200, 430, 3.0, 1.5, 1.0, 0xffffffff)
    
        @texto.draw("score: #{@tubarao[0].pts}", 20, 40, 3.0, 1.0, 1.0, 0xffffffff)

        @font.draw("Lives: #{@player.lives}", 10, 10, 3.0, 1.0, 1.0, 0xffffffff)
    end
    
    def button_down id
        close if id == Gosu::KbEscape
    end
end