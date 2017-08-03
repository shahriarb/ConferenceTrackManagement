require 'test/unit'
require_relative '.././app/input_file_reader'

class InputFileReaderTest < Test::Unit::TestCase
	def test_read_from_file

		exception = assert_raise (RuntimeError ) {InputFileReader.read_from_file('not_exist.txt')}
		assert_equal'can not find not_exist.txt', exception.message

		input_talks, input_errors = InputFileReader.read_from_file('data/base_input.txt')
		assert_equal true, input_errors.empty?
		assert_equal 19, input_talks.size

		_, input_errors = InputFileReader.read_from_file('data/base_error_input.txt')
		assert_equal 2, input_errors.size
		assert_equal 1, input_errors[0][:line]
		assert_equal 'Parse error. Correct format is: Title of talk with no number (#min|lightning)', input_errors[0][:error]
		assert_equal 11, input_errors[1][:line]
		assert_equal 'Parse error. Correct format is: Title of talk with no number (#min|lightning)', input_errors[1][:error]

		exception = assert_raise (RuntimeError ) {InputFileReader.read_from_file('data/base_too_many_error_input.txt')}
		assert_match /^Too many errors in input file.*/, exception.message

	end
end