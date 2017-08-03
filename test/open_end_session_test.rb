require 'test/unit'
require_relative '.././app/open_end_session'
require_relative '.././app/talk_parser'

class OpenEndSessionTest < Test::Unit::TestCase

	def test_initial_state
		session = OpenEndSession.new
		assert_equal '00:00', session.soft_end_time
	end

	def test_soft_end_time
		session = OpenEndSession.new
		session.soft_end_time = '1:30'
		assert_equal '01:30', session.soft_end_time

		session.soft_end_time = '18:41'
		assert_equal '18:41', session.soft_end_time

		session.soft_end_time = '23:59'
		assert_equal '23:59', session.soft_end_time

		exception = assert_raise (RuntimeError ) {session.soft_end_time = '24:00'}
		assert_equal'24:00 is not a valid time. Please use hh:mm format', exception.message
	end

	def test_soft_end_length
		session = OpenEndSession.new
		assert_equal 0, session.soft_end_length

		session.start_time = '13:00'
		assert_equal 0, session.soft_end_length

		session.end_time = '17:00'
		assert_equal 0, session.soft_end_length

		session.soft_end_time = '16:00'
		assert_equal 180, session.soft_end_length

		session.add_talk(TalkParser.parse('Test it 30min'))
		assert_equal 180, session.soft_end_length
	end

	def test_is_full?
		session = OpenEndSession.new
		assert_equal true, session.is_full?

		session.start_time = '13:00'
		session.soft_end_time = '16:00'
		session.end_time = '17:00'
		assert_equal false, session.is_full?

		session.add_talk(TalkParser.parse('Test it 30min'))
		session.add_talk(TalkParser.parse('Test it 30min'))
		session.add_talk(TalkParser.parse('Test it 30min'))
		assert_equal false, session.is_full?

		session.add_talk(TalkParser.parse('Test it again 90min'))
		assert_equal true, session.is_full?

		assert_equal true,session.add_talk(TalkParser.parse('Test it again lightning'))
		assert_equal true, session.is_full?

		assert_equal true,session.add_talk(TalkParser.parse('Test it again long 55min'))
		assert_equal true, session.is_full?

		assert_equal false,session.add_talk(TalkParser.parse('Test it again lightning'))
		assert_equal true, session.is_full?
	end

end