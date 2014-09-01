require 'gosu'

class Oxigenio 
	attr_reader :tempo, :barra

	def initialize (window)
		@window = window
		@barra = Array.new(10) {|n| 1 * 1}
		@tempo_resto = 400
		@tempo = 0
	end
	def update

		@tempo = (@tempo + 1) % @tempo_resto #Gosu::milliseconds / 1000 % 10
		if (@tempo == 2) then
		
			@barra.pop(1)	
		end
	end

		
	
	def draw

		@barra.draw
		@tempo.draw
	end
	# def draw
 #    imagem= @imagens[Gosu::milliseconds / 100 % @imagens.size]
 #    imagem.draw(@x - imagem.width / 2.0, @y - imagem.height / 2.0,
 #        1, 1, 1, @color, :add)
 #  end 
end
