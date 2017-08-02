require_relative './session'
require_relative './open_end_session'

class Track
	attr_accessor :morning_session
	attr_accessor :afternoon_session

	def initialize
		@morning_session = Session.new
		@afternoon_session = OpenEndSession.new
	end

	def current_length
		self.morning_session.total_duration + self.afternoon_session.total_duration
	end

	def is_completed?
		morning_session.is_full? && afternoon_session.is_full?
	end
end