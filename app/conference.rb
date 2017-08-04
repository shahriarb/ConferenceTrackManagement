class Conference
	attr_accessor :tracks

	def initialize
		self.tracks = []
	end

	def all_sessions
		result = []
		self.tracks.each do |track|
			result << track.morning_session
			result << track.afternoon_session
		end
		result
	end
end