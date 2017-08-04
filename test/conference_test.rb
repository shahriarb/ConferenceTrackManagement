require 'test/unit'
require_relative '.././app/conference'
require_relative '.././app/track'

class ConferenceTest < Test::Unit::TestCase

	def test_initial_state
		conference = Conference.new
		assert_equal Array, conference.tracks.class
		assert_equal 0, conference.tracks.size
	end

	def test_all_sessions
		conference = Conference.new
		assert_equal [],conference.all_sessions

		2.times do
			track = Track.new
			track.morning_session.start_time = '09:00'
			track.morning_session.end_time = '12:00'
			track.afternoon_session.start_time = '13:00'
			track.afternoon_session.soft_end_time = '16:00'
			track.afternoon_session.end_time = '17:00'
			conference.tracks << track
		end
		assert_equal 4,conference.all_sessions.size

	end

end