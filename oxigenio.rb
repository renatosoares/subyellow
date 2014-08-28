require 'rubygems'
require 'gosu'

class Window < Gosu::Window
	def initialize
		super(640, 480, false)
	end
end

Window.new.show