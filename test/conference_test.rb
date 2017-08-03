require 'test/unit'
require_relative '.././app/conference'

class ConferenceTest < Test::Unit::TestCase

	def test_initial_state
		conference = Conference.new
		assert_equal Array, conference.tracks.class
		assert_equal 0, conference.tracks.size
	end

end