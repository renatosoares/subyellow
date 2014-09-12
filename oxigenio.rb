require 'gosu'

class Oxigenio 
	attr_reader :tempo, :barra
	attr_accessor :porcentagem

	def initialize (window, player)
		@player = player
		@window = window
		@barra = Array.new(10) {|n| 1}
		@tempo_resto = 400
		@tempo = 0
		@porcentagem = 1.1
		#@player = Player.new(self)
	end
	def update
		@tempo = (@tempo + 1) % @tempo_resto #Gosu::milliseconds / 1000 % 10
		if (@tempo == 2) then
			@porcentagem -= 0.1 
			# @barra.pop(1)	
		end
		if (@barra.size <= 0.5) then
			@tempo_resto = 300
		end
	
	end


	def draw
		# @barra_vermelha.draw(10, 380, 10)
		# @barra_branca.draw(100, 380, 11)
		# @tempo.draw
	end

	def oxigenio_vidas 
		if (@barra.size < 1) then
			true
		end 

	end
	def restaura_oxigenio(completa)
		if (completa) then
			@porcentagem = 1.1
		end
	end
	# def draw
 #    imagem= @imagens[Gosu::milliseconds / 100 % @imagens.size]
 #    imagem.draw(@x - imagem.width / 2.0, @y - imagem.height / 2.0,
 #        1, 1, 1, @color, :add)
 #  end 
end
