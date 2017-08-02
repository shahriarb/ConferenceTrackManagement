class Track
	attr_accessor :sessions

	def initialize
		self.sessions = []
	end

	def current_length
		self.sessions.empty? ? 0 : sessions.sum {|s| s.total_duration }
	end

	def is_completed?
		self.sessions.all {|session| session.is_full? }
	end
end