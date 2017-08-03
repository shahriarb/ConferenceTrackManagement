require 'test/unit'
require_relative '.././app/conference_factory'

class ConferenceFactoryTest < Test::Unit::TestCase
	def test_new_conference
		conference = ConferenceFactory.new_conference(2)
		assert_equal 2, conference.tracks.size

		assert_block do
			conference.tracks.all? {|track| track.is_a? Track}
		end

		assert_block do
			conference.tracks.all? do |track|
				track.morning_session.start_time == '09:00' && track.morning_session.end_time == '12:00' && track.morning_session.talks.empty?
			end
		end

		assert_block do
			conference.tracks.all? do |track|
				track.afternoon_session.start_time == '13:00' && track.afternoon_session.soft_end_time == '16:00' &&
				track.afternoon_session.end_time == '17:00' && track.afternoon_session.talks.empty?
			end
		end
	end
end