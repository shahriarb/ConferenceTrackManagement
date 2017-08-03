require_relative './talk_parser'
require_relative './output_handler'

class InputFileReader
	def self.read_from_file(file_name)
		raise "can not find #{file_name}" unless File.exist?(file_name)

		input_talks = []
		input_errors = []
		line_index = 0
		File.readlines(file_name).each do |line|
			line_index += 1
			begin
				input_talks << TalkParser.parse(line)
			rescue => exc
				input_errors << {line: line_index, error: exc.message}
				raise OutputHandler.new.format_input_error(input_errors) if input_errors.size > 2
			end
		end
		return input_talks, input_errors
	end
end