require './talk_parser'
require './output_handler'
require './conference'
require './conference_factory'
require './conference_planner'

DEFAULT_DATA_FILE = 'base_input.txt'

abort 'you can only pass one params' if ARGV.size > 1

file_name = ARGV.size == 1 ? ARGV.first : DEFAULT_DATA_FILE

abort "can not find #{file_name}" unless File.exist?(file_name)

input_talks = []
input_errors = []
line_index = 0
File.readlines(file_name).each do |line|
	line_index += 1
	begin
		input_talks << TalkParser.parse(line)
	rescue => exc
		input_errors << {line: line_index, error: exc.message}
		abort OutputHandler.new.format_input_error(input_errors) if input_errors.size > 2
	end
end

abort OutputHandler.new.format_input_error(input_errors) unless input_errors.empty?

conference = ConferenceFactory.new_conference(2)

conference = ConferencePlanner.plan(input_talks,conference)

conference.tracks.each_with_index do |track, i|
    puts "Track #{i + 1}"
	track.sessions.each_with_index do |session, j|
		puts "Session #{j + 1}"
		session.talks.each do |talk|
			puts "#{talk.title} ===> #{talk.duration} minutes"
		end
	end
end


