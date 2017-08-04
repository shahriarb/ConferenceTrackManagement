require_relative './input_file_reader'
require_relative './output_handler'
require_relative './conference_factory'
require_relative './conference_planner'

DEFAULT_DATA_FILE = './data/base_input.txt'

abort 'you can only pass one params' if ARGV.size > 1

file_name = ARGV.size == 1 ? ARGV.first : DEFAULT_DATA_FILE

input_talks = []
input_errors = []
begin
	input_talks, input_errors = InputFileReader.read_from_file(file_name)
rescue => exc
	abort exc.message
end

output_handler = OutputHandler.new
abort output_handler.format_input_error(input_errors) unless input_errors.empty?

conference = ConferenceFactory.new_conference(2)

begin
	conference = ConferencePlanner.new.plan(input_talks,conference)
rescue	 => exc
	abort exc.message
end

puts output_handler.format_conference_output(conference).join("\n")

