class Timer
	def initialize(window, tubarao, subinimigo, mergulhador)
		@subinimigo = subinimigo
		@tubarao = tubarao
		@mergulhador = mergulhador
		@window = window
		@every_n_seconds = 5
		@last_recorded_seconds = 0
		@last_recorded_seconds_mergulhador = 0
		@timer_mergulhador = 6
	end
	
	def update
		if (add_inimigos?) then
			@tubarao << Tubarao.new(@window)
			@subinimigo << SubInimigo.new(@window) 	
		end
		if (add_mergulhador?)
			@mergulhador << Mergulhador.new(@window)
		end
	end
	
	def seconds
		Time.now.to_i#(Time.now-@start_time).to_i
	end

	def add_mergulhador?
		if ((seconds != @last_recorded_seconds_mergulhador) and (seconds % @timer_mergulhador == 0)) then
			@last_recorded_seconds_mergulhador = seconds
			true
		else
			false
		end
	end

	def add_inimigos?
		if ((seconds != @last_recorded_seconds) and (seconds % @every_n_seconds == 0)) then
			@last_recorded_seconds = seconds
			true
		else
			false
		end
	end
end