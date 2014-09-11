class Player
	attr_reader :lives, :x, :y, :laser, :direcao, :exploded, :coletados
	def initialize(window)
		@window = window
		@icon = Gosu::Image::load_tiles(@window, 'subyellow_all.png', 65, 22, true)
		@x = window.width / 2
		@y = window.height / 2
		@explosion = Gosu::Image.new(@window, "explosion.png", true)
		@exploded = false
		@lives = 10
		@laser = Laser.new(self, @window)
		@direcao = 1
		@coletados = 0
		@chave = 1
		#@parar = true
		#@oxigenio = Oxigenio.new(self)
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
		if @y < 85
			@y = 85
		end
	end
	def draw
		if @exploded
			@explosion.draw(@x, @y, 4)
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
		if(barra)then
			@lives = @lives - 1
			@exploded = barra
		end
	end

	#coleta mergulhadores e contabiliza a quantidade de resgatados
	def mergulhador_coletado(mergulhadores)
		if (@coletados < 7) then
			# if (@direcao==1)
					if (mergulhadores.any? {|mergulhador| Gosu::distance(mergulhador.x, mergulhador.y, @x, @y) < 20}) then
						@coletados = @coletados + 1
					end
					
			# else 
			# 		if (mergulhadores.any? {|mergulhador| Gosu::distance(mergulhador.x, mergulhador.y, @x+1, @y) < 20}) then
			# 			@coletados = @coletados + 1
			# 		end
			# end
		end
	end
	
	#regenera o nível do oxigenio quando os mergulhadores são descarregados na superficie
	def descarregar_mergulhadores(oxigenio)
		if (@y >= 95) then
			@chave = 1
		end
		if (@y == 85 and @coletados !=0) then
			@coletados = 0
			@chave = 0
			oxigenio.porcentagem = 1.1


		elsif (@y == 85 and @coletados == 0 and @chave == 1) then
			if (@lives > 0) then
				@lives = @lives - 1
				
			end
			@exploded = true
			
		end
	end

	def hit_by?(inimigos) #nesta função onde tinha "bullets" e "bullet" mudei para "inimigos" e "inimigo"
		if (@direcao==1)
			@exploded = inimigos.any? {|inimigo| Gosu::distance(inimigo.x, inimigo.y, @x+15, @y+5) < 30}
			if @exploded
				@lives = @lives - 1
			end
			@exploded
		else 
			@exploded = inimigos.any? {|inimigo| Gosu::distance(inimigo.x, inimigo.y, @x-50, @y+5) < 30}
			if @exploded
				@lives = @lives - 1
			end
			@exploded
		end
	
	
	end

	def reset_position
		@x = rand(@window.width)
		@y = rand(85..380)
	end
end
