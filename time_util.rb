class TimeUtil

	VALID_TIME_REGEX = /^([01]?[0-9]|2[0-3])\:[0-5][0-9]$/

	def self.validate(new_time)
		new_time.to_s =~ VALID_TIME_REGEX
	end

	def self.get_minutes(new_time)
		time_parts = new_time.split(':').map {|p| p.to_i}
		time_parts[0] * 60 + time_parts[1]
	end

	def self.get_string(minutes)
		(minutes / 60).abs.to_s.rjust(2,'0') + ':' + (minutes % 60).to_s.rjust(2,'0')
	end

	def self.get_string_ampm(minutes)
		hour = (minutes / 60).abs
		if hour > 12
			hour_s = (hour - 12).to_s.rjust(2,'0')
		else
			hour_s = hour.to_s.rjust(2,'0')
		end

		result = hour_s + ':' + (minutes % 60).to_s.rjust(2,'0')

		hour > 11 ? "#{result}PM" : "#{result}AM"
	end


end