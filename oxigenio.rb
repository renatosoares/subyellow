require 'gosu'

class Oxigenio 
	attr_reader :barra
	attr_accessor :porcentagem, :tempo

	def initialize (window, player)
		@player = player
		@window = window
		@barra = Array.new(10) {|n| 1}
		@tempo_resto = 400
		@tempo = 0
		@porcentagem = 1.1
	end

	def update
		@tempo = (@tempo + 1) % @tempo_resto #Gosu::milliseconds / 1000 % 10
		if (@tempo == 2 and @porcentagem>0.1) then
			@porcentagem -= 0.1 
		end
		if (@porcentagem <= 0.5) then
			@tempo_resto = 300
		end	
	end

	def oxigenio_vidas 
		if (@porcentagem < 0.1) then
			true
		end 

	end
	def restaura_oxigenio(completa)
		if (completa) then
			@porcentagem = 1.1
		end
	end
end
