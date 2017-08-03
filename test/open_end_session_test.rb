require 'test/unit'
require_relative '.././app/open_end_session'
require_relative '.././app/talk_parser'

class TalkParserTest < Test::Unit::TestCase

	def test_initial_state
		session = OpenEndSession.new
		assert_equal '00:00', session.soft_end_time
	end

=begin
	def test_start_time
		session = Session.new
		session.start_time = '1:30'
		assert_equal '01:30', session.start_time

		session.start_time = '18:41'
		assert_equal '18:41', session.start_time

		session.start_time = '23:59'
		assert_equal '23:59', session.start_time

		exception = assert_raise (RuntimeError ) {session.start_time = '24:00'}
		assert_equal'24:00 is not a valid time. Please use hh:mm format', exception.message
	end

	def test_end_time
		session = Session.new
		session.end_time = '1:30'
		assert_equal '01:30', session.end_time

		session.end_time = '18:41'
		assert_equal '18:41', session.end_time

		session.end_time = '23:59'
		assert_equal '23:59', session.end_time

		exception = assert_raise (RuntimeError ) {session.end_time = '24:00'}
		assert_equal'24:00 is not a valid time. Please use hh:mm format', exception.message
	end

	def test_add_talk
		session = Session.new
		assert_equal 0, session.talks.size
		talk = TalkParser.parse('Test it 30min')

		#Strat/End time is not set. we should not be able to add a talk
		assert_equal false, session.add_talk(talk)
		assert_equal 0, session.talks.size

		session.start_time = '9:00'
		assert_equal false, session.add_talk(talk)
		assert_equal 0, session.talks.size

		session.end_time = '12:00'
		assert_equal true, session.add_talk(talk)
		assert_equal 1, session.talks.size
		assert_equal'Test it',session.talks[0].title
		assert_equal 30,session.talks[0].duration

		assert_equal true, session.add_talk(TalkParser.parse('Two hours talk 120min'))
		assert_equal 2, session.talks.size
		assert_equal'Test it',session.talks[0].title
		assert_equal 30,session.talks[0].duration
		assert_equal'Two hours talk',session.talks[1].title
		assert_equal 120,session.talks[1].duration

		#More than Session length
		assert_equal false, session.add_talk(TalkParser.parse('Two hours talk 120min'))
		assert_equal 2, session.talks.size
	end

	def test_current_length
		session = Session.new
		assert_equal 0, session.current_length

		session.start_time = '9:00'
		assert_equal 0, session.current_length
		session.end_time = '12:00'
		assert_equal 0, session.current_length

		session.add_talk(TalkParser.parse('Test it 30min'))
		assert_equal 30, session.current_length

		session.add_talk(TalkParser.parse('Two hours talk 120min'))
		assert_equal 150, session.current_length

		#More than Session length
		session.add_talk(TalkParser.parse('Two hours talk 120min'))
		assert_equal 150, session.current_length
	end

	def test_max_length
		session = Session.new
		assert_equal 0, session.max_length

		session.start_time = '9:00'
		assert_equal 0, session.max_length

		session.end_time = '12:00'
		assert_equal 180, session.max_length

		session.add_talk(TalkParser.parse('Test it 30min'))
		assert_equal 180, session.max_length
	end


	def test_reset
		session = Session.new
		assert_equal 0, session.talks.size

		session.start_time = '9:00'
		session.end_time = '12:00'

		session.reset
		assert_equal 0, session.talks.size

		session.add_talk(TalkParser.parse('Test it 30min'))
		session.add_talk(TalkParser.parse('Test it 30min'))
		session.add_talk(TalkParser.parse('Test it 30min'))
		assert_equal 3, session.talks.size

		session.reset
		assert_equal 0, session.talks.size
	end

	def test_is_full?
		session = Session.new
		assert_equal true, session.is_full?

		session.start_time = '9:00'
		session.end_time = '12:00'
		assert_equal false, session.is_full?

		session.add_talk(TalkParser.parse('Test it 30min'))
		session.add_talk(TalkParser.parse('Test it 30min'))
		session.add_talk(TalkParser.parse('Test it 30min'))
		assert_equal false, session.is_full?

		session.add_talk(TalkParser.parse('Test it again 90min'))
		assert_equal true, session.is_full?

		assert_equal false,session.add_talk(TalkParser.parse('Test it again lightning'))
		assert_equal true, session.is_full?
	end
=end
end