class SubInimigo
    attr_reader :x, :y, :alive
   
    def initialize(window)
        @window = window
        @icon = Gosu::Image.new(@window, 'subinimigo_right.png', true)
        @x = 630#- rand(200) #determina de onde vai aparecer inicialmente inimigos no eixo X
        @y = rand(120..350) #rand(@window.height - 500) #nivel superior para aparecer objetos
        @alive = true
        @beep = Gosu::Sample.new(@window, "kill_sub.ogg")
    end
   
   #controla o aparecimento de objetos inimigos
    def update(laser) 
        @x = @x - 1
        if @x == 0
            @x = 630
            @y =  rand(120..350) #rand(@window.height) #nivel inferior para aparecer objetos   
        end
        hit_by?(laser)
        if(@alive == false) then
            @beep.play
        end
    end
   
    def draw
        @icon.draw(@x, @y, 6)
    end
   
    def hit_by?(laser)
        if Gosu::distance(laser.y, laser.x, @y, @x) < 20
            @alive = false

        end
    end
   
end