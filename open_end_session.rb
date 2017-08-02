require './session'

class OpenEndSession < Session
	attr_reader  :soft_end_time

	def soft_end_time=(new_time)
		raise "#{new_time} is not a valid time as soft end"  unless new_time.to_s =~ Session::VALID_DATE_REGEX
		@soft_end_time = Time.parse(new_time.to_s)
	end

	def soft_end_length
		raise 'Unknown start time' if @start_time.nil?
		raise 'Unknown soft end time' if @soft_end_time.nil?
		((@soft_end_time - @start_time) / 60).round
	end

	def is_full?
		(self.current_length >= self.soft_end_length) && (self.current_length <= self.max_length)
	end

end