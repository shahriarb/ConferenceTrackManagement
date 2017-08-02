class Session
	attr_accessor :talks
	attr_reader  :start_time,:end_time

	VALID_DATE_REGEX = /^([01]?[0-9]|2[0-3])\:[0-5][0-9]$/

	def initialize
		reset
	end

	def start_time=(new_time)
		raise "#{new_time} is not a valid start time"  unless new_time.to_s =~ VALID_DATE_REGEX
		@start_time = Time.parse(new_time.to_s)
	end

	def end_time=(new_time)
		raise "#{new_time} is not a valid end time"  unless new_time.to_s =~ VALID_DATE_REGEX
		@end_time = Time.parse(new_time.to_s)
	end

	def current_length
		self.talks.empty? ? 0 : self.talks.sum {|t| t.duration }
	end

	def max_length
		raise 'Unknown start time' if @start_time.nil?
		raise 'Unknown end time' if @end_time.nil?
		((@end_time - @start_time) / 60).round
	end

	def reset
		self.talks = []
	end

	def add_talk(talk)
		if max_length <= current_length + talk.duration
			self.talks << talk
			return true
		else
			return false
		end
	end

	def is_full?
		self.current_length == self.max_length
	end
end