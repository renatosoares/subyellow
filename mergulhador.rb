class Mergulhador
    attr_reader :x, :y, :alive
    attr_accessor :coletados, :mostrar_mergulhadores
   
    def initialize(window)
        @window = window
        @icon = Gosu::Image::load_tiles(@window, 'mergulhador_all.png', 38, 36, true)
        @x = 630#- rand(200) #determina de onde vai aparecer inicialmente inimigos no eixo X
        @y = rand(120..200) #rand(@window.height - 500) #nivel superior para aparecer objetos
        @alive = true
        @beep = Gosu::Sample.new(@window, "kill_shark.ogg") 
    end
   
   #controla o aparecimento de objetos inimigos
    def update(player) 
        @x = @x - 1
        if @x == 0
            @x = 630
            @y =  rand(200..350) #rand(@window.height) #nivel inferior para aparecer objetos   
        end
        resgate(player)
        if(@alive == false) then
            @beep.play
            if (@window.coletados<7) then
                @window.coletados += 1
                @window.mostrar_mergulhadores = @window.mostrar_mergulhadores + 1.0/7
            end
        end
    end
   
    def draw
        icon= @icon[Gosu::milliseconds / 100 % @icon.size]
        icon.draw(@x + 1.5*icon.width, @y - icon.height / 2.0, 7, -1)
    end
   
    def resgate(player)
        if Gosu::distance(player.y, player.x, @y, @x) < 20
            @alive = false            
        end
    end
   
end