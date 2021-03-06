require_relative './session'
require_relative './time_util'

class OpenEndSession < Session

	def initialize
		super
		@soft_end_time = 0
	end


	def soft_end_time
		TimeUtil.get_string(@soft_end_time)
	end

	def soft_end_time=(new_time)
		validate_time(new_time)
		@soft_end_time = TimeUtil.get_minutes(new_time)
	end

	def soft_end_length
		length = @soft_end_time - @start_time
		length > 0 ? length : 0
	end

	def is_full?
		(self.current_length >= self.soft_end_length) && (self.current_length <= self.max_length)
	end

end