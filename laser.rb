class Laser
	attr_reader :x, :y
	def initialize(player, window)
		@player = player
		@window = window
		@shooting = false
		@x = @player.x
		@y = @player.y
		@icon = Gosu::Image.new(@window, "tiro_subyellow.png", true)
		@direcao = 1
	end
	def shoot(x,y, direcao)
			@shooting = true
			@direcao =direcao
			@x = x
			@y  = y
	end
	def update
		# if @window.button_down? Gosu::Button::KbLeft and not @shooting
		# 	@direcao=-1
		# end
		# if @window.button_down? Gosu::Button::KbRight and not @shooting
		# 	@direcao=1
		# end
		if @shooting
			if (@direcao==1) then
				@x = @x + 10
				if @x > @window.width
				 	@shooting = false
				end
			else 
				@x = @x - 10
				if @x < 0
				 	@shooting = false
				end
			end
		else
			@x = @player.x
			@y = @player.y
		end
	end
	def draw
		if @shooting
			if @direcao==1
				@icon.draw(@x+15, @y+15, 4)
			else
				@icon.draw(@x-25, @y+15, 4)
			end
		# else
		# 	@icon.draw((@player.x+15),(@player.y+15),4) => laser aparece qd o submarino nao esta atirando
		end
	end
end