require 'test/unit'
require_relative '.././app/track'
require_relative '.././app/talk_parser'

class TrackTest < Test::Unit::TestCase

	def test_initial_state
		track = Track.new
		assert_not_equal nil, track.morning_session
		assert_equal Session, track.morning_session.class

		assert_not_equal nil, track.afternoon_session
		assert_equal OpenEndSession, track.afternoon_session.class

	end

	def test_is_completed?
		track = Track.new
		assert_equal true, track.is_completed?

		track.morning_session.start_time = '9:00'
		track.morning_session.end_time = '12:00'
		assert_equal false, track.is_completed?

		track.morning_session.add_talk(TalkParser.parse('Test it 30min'))
		assert_equal false, track.is_completed?

		track.morning_session.add_talk(TalkParser.parse('Test it 150min'))
		assert_equal true, track.is_completed?

		track.afternoon_session.start_time = '13:00'
		track.afternoon_session.soft_end_time = '16:00'
		track.afternoon_session.end_time = '17:00'
		assert_equal false, track.is_completed?

		track.afternoon_session.add_talk(TalkParser.parse('Test it 30min'))
		track.afternoon_session.add_talk(TalkParser.parse('Test it 30min'))
		track.afternoon_session.add_talk(TalkParser.parse('Test it 30min'))
		assert_equal false, track.is_completed?

		track.afternoon_session.add_talk(TalkParser.parse('Test it again 90min'))
		assert_equal true, track.is_completed?

		assert_equal true,track.afternoon_session.add_talk(TalkParser.parse('Test it again lightning'))
		assert_equal true, track.is_completed?

		assert_equal true,track.afternoon_session.add_talk(TalkParser.parse('Test it again long 55min'))
		assert_equal true, track.is_completed?

		assert_equal false,track.afternoon_session.add_talk(TalkParser.parse('Test it again lightning'))
		assert_equal true, track.is_completed?

		track.morning_session.reset
		assert_equal false, track.is_completed?
	end

end