class Window < Gosu::Window
    attr_reader :running

    def initialize

        super(640,480,false)
        self.caption = "Sub_Yellow"
        @player = Player.new(self)
        @tubarao = rand(1..2).times.map {Tubarao.new(self)}
        @subinimigo = rand(1..3).times.map {SubInimigo.new(self)}
        @mergulhador = 1.times.map {Mergulhador.new(self)}
        @timer = Timer.new(self, @tubarao, @subinimigo, @mergulhador) #objeto para controlar o tempo de aparição dos inimigos
        @running = true
        @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
        @texto = Gosu::Font.new(self, Gosu::default_font_name, 20)
        @background = Gosu::Image.new(self, "fundo.png", true)
        @superficie = Gosu::Image.new(self, "mar_superficie.png", true)
        #@inicio = Gosu::Sample.new(@window, "start_game.mp3")
        @oxigenio = Oxigenio.new(self, @player)
        @barra_oxigenio = Gosu::Font.new(self, Gosu::default_font_name, 20)
        @tempo_barra_oxigenio = Gosu::Font.new(self, Gosu::default_font_name, 20)
        @contador_mergulhador = Gosu::Font.new(self, Gosu::default_font_name, 20)
        @escreve_roda_tempo = Gosu::Font.new(self, Gosu::default_font_name, 20)
        @mare= Gosu::Image::load_tiles(self, 'mare.png', 640, 21, true)
        @barra_branca = Gosu::Image.new(self, "barra_branca.png", true)
        @barra_vermelha = Gosu::Image.new(self, "barra_vermelha.png", true)
        
    end
    
    def update
        # para11 = false
        # @roda_tempo = Gosu::milliseconds / 100 % 10 #Time.now#
        # if (para11) then
        #     @running = false
        # elsif(@roda_tempo == 9 and @running == false and para11 == true) then
        #     @running = true
        # end
        if @running

            if @player.hit_by? live_inimigos 
                @running = false
            elsif (@oxigenio.oxigenio_vidas) then
                @running = false
                @player.vidas_removida_oxigenio(@oxigenio.oxigenio_vidas)
            elsif 
                @player.descarregar_mergulhadores(@oxigenio)
<<<<<<< HEAD
                if (@player.exploded) then
                    @running = false
                end
=======
                #para11 = true 

                #@running = false
                # count = 0
                # if(not @running and count < 60)then
                #     count = count + 1
                # else
                #     @running = true
                #     count = 0
                # end 
>>>>>>> b0d592356b8ef480a9b7bcd3a0ab242716b46792
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
        @player.mergulhador_coletado(resgate_mergulhador)
        

       
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
        # @barra_oxigenio.draw("oxigenio: #{@oxigenio.draw}", 200, 406, 3.0, 1.5, 1.0, 0xffffffff)
        @superficie.draw(0, 98, 6)
        #@texto.draw("score: #{@tubarao[0].pts}", 20, 40, 3.0, 1.0, 1.0, 0xffffffff)
        @contador_mergulhador.draw("Megulhadores: #{@player.coletados}", 220, 425, 3.0, 1.0, 1.0, 0xffffffff)
        @font.draw("Lives: #{@player.lives}", 10, 10, 3.0, 1.0, 1.0, 0xffffffff)
<<<<<<< HEAD
        #@escreve_roda_tempo.draw("tempo agora: #{@roda_tempo}", 220, 300, 3.0, 1.0, 1.0, 0xffffffff)
=======
        @escreve_roda_tempo.draw("tempo agora: #{@roda_tempo}", 220, 300, 3.0, 1.0, 1.0, 0xffffffff)
>>>>>>> b0d592356b8ef480a9b7bcd3a0ab242716b46792
        mare = @mare[Gosu::milliseconds / 100 % @mare.size]
        mare.draw(0, 96, 15)
        @barra_vermelha.draw(150, 410, 10)
        @barra_branca.draw(150, 410, 11, @oxigenio.porcentagem)
    end
    
    def button_down id
        close if id == Gosu::KbEscape
    end
end