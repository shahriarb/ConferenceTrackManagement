class OutputHandler
	def format_input_error(input_errors)
		"Too many errors in input file :\n\n #{input_errors.map {|e| "Line #{e[:line]}: #{e[:error]}"}}"
	end
end