class Window < Gosu::Window
    attr_reader :running
    attr_accessor :pts, :coletados, :mostrar_mergulhadores

    def initialize
        super(640,480,false)
        self.caption = "Sub_Yellow"
        @player = Player.new(self)
        @tubarao = rand(1..2).times.map {Tubarao.new(self)}
        @subinimigo = rand(1..2).times.map {SubInimigo.new(self)}
        @mergulhador = 1.times.map {Mergulhador.new(self)}
        @timer = Timer.new(self, @tubarao, @subinimigo, @mergulhador) #objeto para controlar o tempo de aparição dos inimigos
        @running = true
        @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
        @background = Gosu::Image.new(self, "fundo.png", true)
        @oxigenio = Oxigenio.new(self, @player)
        @mare= Gosu::Image::load_tiles(self, 'mare.png', 640, 21, true)
        @barra_branca = Gosu::Image.new(self, "barra_branca.png", true)
        @barra_vermelha = Gosu::Image.new(self, "barra_vermelha.png", true)
        @mergulhadores = Gosu::Image.new(self, "mergulhadores.png", true)
        @barra_cinza = Gosu::Image.new(self, "barra_cinza.png", true)
        @vidas = Gosu::Image.new(self, "vidas.png", true)
        @barra_azul = Gosu::Image.new(self, "barra_azul.png", true)
        @pts = 0
        @coletados = 0
        @mostrar_mergulhadores = -1
        @estado="jogando"
    end
    
    def update
        if @running
            if @player.hit_by? live_inimigos 
                @running = false
                @oxigenio.tempo = 0
                @mostrar_mergulhadores = -1
                @coletados = 0
            elsif (@oxigenio.oxigenio_vidas) then
                @running = false
                @player.vidas_removida_oxigenio(@oxigenio.oxigenio_vidas)
                @mostrar_mergulhadores = -1
                @coletados = 0
            elsif 
                @player.descarregar_mergulhadores(@oxigenio)
                if (@player.exploded) then
                    @running = false
                    @oxigenio.tempo = 0
                end
            else
                run_game
            end
        end   
        if (not @running and button_down? Gosu::Button::KbR and @player.lives > 0) then
            @running = true
            @player.reset_position
            @oxigenio.restaura_oxigenio(true)
        end
        if (@player.lives==0 or @pts==50000) then
            @estado="fim"
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
        if (@estado=="jogando") then
            @background.draw(0,0,1)
            @player.draw
            live_inimigos.each {|subinimigo| subinimigo.draw}
            live_inimigos.each {|tubarao| tubarao.draw}
            resgate_mergulhador.each {|mergulhador| mergulhador.draw}
            mare = @mare[Gosu::milliseconds / 100 % @mare.size]
            mare.draw(0, 96, 15)
            @barra_vermelha.draw(150, 412, 10)
            @barra_branca.draw(150, 412, 11, @oxigenio.porcentagem)
            @mergulhadores.draw(150, 427, 12)
            @barra_cinza.draw(374, 427, 13, @mostrar_mergulhadores)
            @vidas.draw(15, 15, 12)
            @barra_azul.draw(115, 15, 13, @player.mostrar_vidas)
            @font.draw("#{@pts}", 590, 15, 3.0, 1.0, 1.0, 0xffffffff)
        elsif(@estado == "fim") then
            @background.draw(0,0,1)
            msg1 = "FIM DE JOGO"
            msg2 = "VOCE FEZ #{@pts} PONTOS"
            x1=(self.width)/2-((@font.text_width(msg1,1)/2))            
            x2=(self.width)/2-((@font.text_width(msg2,1)/2))
            @font.draw(msg1, x1, 200, 3, 1.0, 1.0, 0xffffffff)
            @font.draw(msg2, x2, 225, 3, 1.0, 1.0, 0xffffffff)
        end
    end
    
    def button_down id
        close if id == Gosu::KbEscape
    end
end