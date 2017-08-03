require_relative './session'
require_relative './open_end_session'

class Track
	attr_accessor :morning_session
	attr_accessor :afternoon_session

	def initialize
		@morning_session = Session.new
		@afternoon_session = OpenEndSession.new
	end

	def is_full?
		morning_session.is_full? && afternoon_session.is_full?
	end
end