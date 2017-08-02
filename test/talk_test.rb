require 'test/unit'
require_relative '.././app/talk'

class TalkParserTest < Test::Unit::TestCase

	def test_title
		#title should not contain number
		talk = Talk.new
		exception = assert_raise (RuntimeError ) {talk.title = 'around the world in 80 days'}
		assert_equal'Title can not have any number in it', exception.message

		talk.title = 'Correct test'
		assert_equal 'Correct test', talk.title
	end

	def test_duration
		#title should not contain number
		talk = Talk.new
		exception = assert_raise (RuntimeError ) {talk.duration = '10min'}
		assert_equal'10min should be a number', exception.message

		exception = assert_raise (RuntimeError ) {talk.duration = -10}
		assert_equal'Duration should be greater than zero', exception.message

		talk.duration = 45
		assert_equal 45, talk.duration
	end

end