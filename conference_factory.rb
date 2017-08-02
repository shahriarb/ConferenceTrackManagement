require './conference'
require './track'
require './session'
require './open_end_session'

class ConferenceFactory

	def self.new_conference(tracks_count)
		result = Conference.new

		tracks_count.times do
			track = Track.new
			morning_session = Session.new
			morning_session.start_time = '09:00'
			morning_session.end_time = '12:00'
			track.sessions << morning_session
			afternoon_session = OpenEndSession.new
			afternoon_session.start_time = '13:00'
			afternoon_session.soft_end_time = '16:00'
			afternoon_session.end_time = '17:00'
			track.sessions << afternoon_session
			result.tracks << track
		end

		result

	end
end