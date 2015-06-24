require 'alexa'

class AlexaController < ApplicationController

  @@alexa = Alexa.new

	def respond
		render text:"This is test"
	end

	def listen
    status, response = @@alexa.process_request(params)
		render json: response, status: status
  end

end
