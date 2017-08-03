require_relative './conference'
require_relative './track'

class ConferenceFactory

	def self.new_conference(tracks_count)
		result = Conference.new
		tracks_count.times do
			track = Track.new
			track.morning_session.start_time = '09:00'
			track.morning_session.end_time = '12:00'

			track.afternoon_session.start_time = '13:00'
			track.afternoon_session.soft_end_time = '16:00'
			track.afternoon_session.end_time = '17:00'

			result.tracks << track
		end
		result
	end
end