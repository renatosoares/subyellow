class SubInimigo
    attr_reader :x, :y, :alive    
    attr_accessor :pts
   
    def initialize(window)
        @window = window
        @icon = Gosu::Image::load_tiles(@window, 'subinimigo_right_all.png', 35, 23, true)
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
            @window.pts += 10
        end
    end
   
    def draw
        icon= @icon[Gosu::milliseconds / 100 % @icon.size]
        icon.draw(@x + icon.width / 2.0, @y - icon.height / 2.0, 6)
    end
   
    def hit_by?(laser)
        if Gosu::distance(laser.y, laser.x, @y, @x) < 20
            @alive = false
        end
    end
   
end