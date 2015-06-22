class AlexaController < ApplicationController

	def respond
		render text:"This is test"
	end

	def listen
		render text:"Listened"
	end
end
