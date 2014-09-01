class Tubarao
    attr_reader :x, :y, :alive, :pts
   
    def initialize(window)
        @window = window
        @icon = Gosu::Image.new(@window, 'tubarao_a.png', true)
        @x = 0#- rand(200) #determina de onde vai aparecer inicialmente inimigos no eixo X
        @y = rand(120..195) #rand(@window.height - 500) #nivel superior para aparecer objetos
        @alive = true
        @beep = Gosu::Sample.new(@window, "kill_shark.ogg")
        @pts = 0
    end
   #controla o aparecimento de objetos inimigos
    def update(laser) 
        @x = @x + 1
        if @x > @window.width
            @x = 0
            @y =  rand(200..360) #rand(@window.height) #nivel inferior para aparecer objetos   
        end
        hit_by?(laser)
        score(laser)
        if(@alive == false) then
            @beep.play
            
        end
    end
    def score(laser)
        if(laser == false) then
            @pts = @pts + 10
        end
    end
   
    def draw
        @icon.draw(@x, @y, 5)
    end
   
    def hit_by?(laser)
        if Gosu::distance(laser.y, laser.x, @y, @x) < 20
            @alive = false
        end
    end
   
end