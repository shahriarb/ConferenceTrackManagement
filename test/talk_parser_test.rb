require 'test/unit'
require_relative '.././app/talk_parser'

class TalkParserTest < Test::Unit::TestCase

	def test_title
		#title should not contain number
		exception = assert_raise (RuntimeError ) {TalkParser.parse('around the world in 80 days 30min')}
		assert_equal'Parse error. Correct format is: Title of talk with no number (#min|lightning)', exception.message

		#title should be description minus last word
		talk = TalkParser.parse('I am testing title 15min')
		assert_equal 'I am testing title', talk.title

		talk = TalkParser.parse('I am testing title lightning')
		assert_equal 'I am testing title', talk.title
	end

	def test_duration
		#duration should be #min or lightning
		exception = assert_raise (RuntimeError ) {TalkParser.parse('test me 30minutes')}
		assert_equal'Parse error. Correct format is: Title of talk with no number (#min|lightning)', exception.message

		exception = assert_raise (RuntimeError ) {TalkParser.parse('test me')}
		assert_equal'Parse error. Correct format is: Title of talk with no number (#min|lightning)', exception.message

		talk = TalkParser.parse('Test for correct minutes parse 30min')
		assert_equal 30, talk.duration

		talk = TalkParser.parse('Test for correct lightning parse lightning')
		assert_equal TalkParser::LIGHTNING_DURATION, talk.duration
	end

end