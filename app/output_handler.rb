class OutputHandler
	def format_input_error(input_errors)
		"Too many errors in input file :\n\n #{input_errors.map {|e| "Line #{e[:line]}: #{e[:error]}"}}"
	end

	def format_conference_output(conference)
		result = []
		conference.tracks.each_with_index do |track, i|
			result << "Track #{i + 1}"
			result += format_session_output(track.morning_session)
			result << '12:00PM Lunch'
			result += format_session_output(track.afternoon_session)
			#According to sample output, The start of networking event always SHOULD show at 05:00PM even if it can start earlier
			result << '05:00PM Networking Event'

		end
		result
	end

	def format_session_output(session)
		result = []
		talk_start = TimeUtil.get_minutes(session.start_time)
		session.talks.each do |talk|
			result << "#{TimeUtil.get_string_ampm(talk_start)} #{talk.description}"
			talk_start += talk.duration
		end
		result
	end

end