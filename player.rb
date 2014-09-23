class Player
	attr_reader :lives, :x, :y, :laser, :direcao, :exploded, :mostrar_vidas	
    attr_accessor :pts, :coletados, :mostrar_mergulhadores
	def initialize(window)
		@window = window
		@icon = Gosu::Image::load_tiles(@window, 'subyellow_all.png', 65, 22, true)
		@x = window.width / 2
		@y = window.height / 2
		@explosao = Gosu::Image::load_tiles(@window, 'explosao.png', 56, 18, true)
		@exploded = false
		@lives = 3
		@laser = Laser.new(self, @window)
		@direcao = 1
		@chave = 1
		@ponto_decarrega = 95
		@mostrar_vidas = 0
	end

	def update
		if @window.button_down? Gosu::Button::KbLeft
			move_left
			@direcao=-1
		end
		if @window.button_down? Gosu::Button::KbRight
			move_right
			@direcao=1
		end
		if @window.button_down? Gosu::Button::KbDown
			move_down
		end
		if @window.button_down? Gosu::Button::KbUp
			move_up
		end
		if @window.button_down? Gosu::Button::KbSpace
			@laser.shoot(@x, @y, @direcao)
		end
		@laser.update
		if (@y >= 95) then
			@ponto_decarrega = 95
		end
	end

	def move_right
		@x = @x + 5
		if @x > @window.width-50
			@x = @window.width-50
		end
	end
	
	def move_left
		@x = @x - 5
		if @x < 0
			@x = 0
		end
	end
	
	def move_down
		@y = @y + 5
		if @y > 360
			@y = 360
		end
	end
	
	def move_up
		@y = @y - 5
		if @y < 95
			@y = 95
		end
	end
	
	def draw
		if @exploded
			explosao=@explosao[Gosu::milliseconds / 100  % @explosao.size]
       		explosao.draw(@x - explosao.width/2.0, @y - explosao.height / 2.0, 4)

		elsif @direcao==1			
			icon = @icon[Gosu::milliseconds / 100 % @icon.size]
       		icon.draw(@x - icon.width / 2.0, @y - icon.height / 2.0, 2, @direcao)
			@laser.draw
		else
			icon = @icon[Gosu::milliseconds / 100 % @icon.size]
       		icon.draw(@x + icon.width, @y - icon.height / 2.0, 2, @direcao)
			@laser.draw
		end
	end

	#função para decrementar vida quando array do oxigenio chegar a 0
	def vidas_removida_oxigenio(barra)
		if(barra==true)then
			@lives = @lives - 1
			@mostrar_vidas = @mostrar_vidas - 1.0/3
			@exploded = barra
		end
	end

	#regenera o nível do oxigenio quando os mergulhadores são descarregados na superficie
	def descarregar_mergulhadores(oxigenio)
		if (@y >= 105) then
			@chave = 1
		end
		if (@y == @ponto_decarrega and @window.coletados ==7) then
			@window.coletados = 0
			@chave = 0
			@window.mostrar_mergulhadores = -1
			oxigenio.porcentagem = 1.0
			@window.pts += 100
		elsif (@y == @ponto_decarrega and @window.coletados>0 and @window.coletados<7 and @chave==1) then
			@window.coletados = @window.coletados - 1
			@chave = 0
			@window.mostrar_mergulhadores = @window.mostrar_mergulhadores - 1.0/7
			@window.pts += 10
			if (oxigenio.porcentagem<1.0) then
				oxigenio.porcentagem = oxigenio.porcentagem + 0.1
			end

		elsif (@y == @ponto_decarrega and @window.coletados == 0 and @chave == 1) then
			@ponto_decarrega = 50
			@exploded = true
			if (@lives > 0) then
				@lives = @lives - 1
				@mostrar_vidas = @mostrar_vidas - 1.0/3
				@y = 100	
			end
			@exploded		
		end		
	end

	def hit_by?(inimigos) #nesta função onde tinha "bullets" e "bullet" mudei para "inimigos" e "inimigo"
		if (@direcao==1)
			@exploded = inimigos.any? {|inimigo| Gosu::distance(inimigo.x, inimigo.y, @x+15, @y+5) < 30}
			if @exploded
				@lives = @lives - 1
				@mostrar_vidas = @mostrar_vidas - 1.0/3
			end
			@exploded
		else 
			@exploded = inimigos.any? {|inimigo| Gosu::distance(inimigo.x, inimigo.y, @x-50, @y+5) < 30}
			if @exploded
				@lives = @lives - 1
				@mostrar_vidas = @mostrar_vidas - 1.0/3
			end
			@exploded
		end	
	end

	def reset_position
		@x = rand(@window.width)
		@y = rand(90..380)
	end
end
