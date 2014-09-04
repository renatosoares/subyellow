require 'gosu'

class Oxigenio 
	attr_reader :tempo, :barra

	def initialize (window, player)
		@player = player
		@window = window
		@barra = Array.new(10) {|n| 1}
		@tempo_resto = 500
		@tempo = 0
		#@player = Player.new(self)
	end
	def update
		@tempo = (@tempo + 1) % @tempo_resto #Gosu::milliseconds / 1000 % 10
		if (@tempo == 2) then
			@barra.pop(1)	
		end
		if (@barra.size <= 5) then
			@tempo_resto = 200
		end
	
	end


	def draw
		@barra.draw
		@tempo.draw
	end

	def oxigenio_vidas 
		if (@barra.size < 1) then
			true
		end 

	end
	def restaura_oxigenio(completa)
		if (completa) then
			@barra = Array.new(10) {|n| 1 * 1}
		end
	end
	# def draw
 #    imagem= @imagens[Gosu::milliseconds / 100 % @imagens.size]
 #    imagem.draw(@x - imagem.width / 2.0, @y - imagem.height / 2.0,
 #        1, 1, 1, @color, :add)
 #  end 
end
