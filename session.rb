require 'time'

class Session
	attr_accessor :talks

	VALID_TIME_REGEX = /^([01]?[0-9]|2[0-3])\:[0-5][0-9]$/

	def initialize
		@end_time = @start_time = 0
		self.reset
	end

	def start_time
		"#{(@start_time / 60).abs}:#{@start_time % 60}"
	end

	def start_time=(new_time)
		validate_time(new_time)
		@start_time = get_minutes(new_time)
	end

	def end_time
		"#{(@end_time / 60).abs}:#{@end_time % 60}"
	end

	def end_time=(new_time)
		validate_time(new_time)
		@end_time = get_minutes(new_time)
	end

	def current_length
		result = 0
		self.talks.each {|t| result += t.duration }
		result
	end

	def max_length
		raise 'Unknown start time' if @start_time.nil?
		raise 'Unknown end time' if @end_time.nil?
		@end_time - @start_time
	end

	def reset
		self.talks = []
	end

	def add_talk(talk)
		if self.current_length + talk.duration <= self.max_length
			self.talks << talk
			return true
		end
		false
	end

	def is_full?
		self.current_length == self.max_length
	end

	protected

	def validate_time(new_time)
		raise "#{new_time} is not a valid time. PLease use hh:mm format"  unless new_time.to_s =~ VALID_TIME_REGEX
	end

	def get_minutes(new_time)
		time_parts = new_time.split(':').map {|p| p.to_i}
		time_parts[0] * 60 + time_parts[1]
	end
end