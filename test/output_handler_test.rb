require 'test/unit'
require_relative '.././app/output_handler'
require_relative '.././app/session'
require_relative '.././app/talk_parser'
require_relative '.././app/conference'
require_relative '.././app/conference_factory'

class OutputHandlerTest < Test::Unit::TestCase

	def setup
		@output_handler = OutputHandler.new
	end

	def test_format_input_error
		input_errors = [{line: 10, error: 'Invalid talk format'}, {line: 21, error: 'Invalid time'} ]
		output = @output_handler.format_input_error(input_errors)

		assert_match /Too many errors in input file :\n\n.*/ , output
		output.gsub!("Too many errors in input file :\n\n",'')

		assert_block do
			input_errors.all? {|error|  /.*Line #{error[:line]}: #{error[:error]}.*/ =~ output}
		end
	end

	def test_format_session_output
		session = Session.new
		session.start_time = '9:00'
		session.end_time = '12:00'
		session.add_talk(TalkParser.parse('Test it 30min'))
		session.add_talk(TalkParser.parse('Test another time 30min'))
		session.add_talk(TalkParser.parse('Test it again lightning'))


		output = @output_handler.format_session_output(session)
		assert_equal 3, output.size
		assert_equal '09:00AM Test it 30min', output[0]
		assert_equal '09:30AM Test another time 30min', output[1]
		assert_equal '10:00AM Test it again lightning', output[2]
	end

	def test_format_conference_output
		conference = ConferenceFactory.new_conference(1)

		conference.tracks.first.morning_session.add_talk(TalkParser.parse('Morning test it 30min'))
		conference.tracks.first.morning_session.add_talk(TalkParser.parse('Morning test another time 30min'))
		conference.tracks.first.morning_session.add_talk(TalkParser.parse('Morning test it again lightning'))
		conference.tracks.first.afternoon_session.add_talk(TalkParser.parse('Afternoon test it 30min'))
		conference.tracks.first.afternoon_session.add_talk(TalkParser.parse('Afternoon test another time 30min'))
		conference.tracks.first.afternoon_session.add_talk(TalkParser.parse('Afternoon test it again lightning'))

		output = @output_handler.format_conference_output(conference)

		assert_equal 9, output.size

		assert_equal 'Track 1', output[0]

		morning_session_output = @output_handler.format_session_output(conference.tracks.first.morning_session)
		assert_equal morning_session_output, output[1..3]

		assert_equal '12:00PM Lunch', output[4]

		afternoon_session_output = @output_handler.format_session_output(conference.tracks.first.afternoon_session)
		assert_equal afternoon_session_output, output[5..7]

		assert_equal '05:00PM Networking Event', output[8]

	end
end