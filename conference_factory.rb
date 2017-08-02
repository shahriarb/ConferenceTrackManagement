require './conference'
require './session'

class ConferenceFactory

	def self.new_conference(tracks_count)
		result = Conference.new

		tracks_count.times do
			track = Track.new
			morning_session = Session.new
			morning_session.start_time = Time.new('9:00')
			morning_session.end_time = Time.new('12:00')
			track.sessions << morning_session
			afternoon_session = OpenEndSession.new
			afternoon_session.start_time = Time.new('13:00')
			afternoon_session.soft_end_time = Time.new('16:00')
			afternoon_session.end_time = Time.new('17:00')
			track.sessions << afternoon_session
			result.tracks << track
		end

		result

	end
end