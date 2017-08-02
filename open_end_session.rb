require './session'

class OpenEndSession < Session


	def initialize
		super
		@soft_end_time = 0
	end


	def soft_end_time
		"#{(@soft_end_time / 60).abs}:#{@soft_end_time % 60}"
	end

	def soft_end_time=(new_time)
		validate_time(new_time)
		@soft_end_time = get_minutes(new_time)
	end

	def soft_end_length
		raise 'Unknown start time' if @start_time.nil?
		raise 'Unknown soft end time' if @soft_end_time.nil?
		@soft_end_time - @start_time
	end

	def is_full?
		(self.current_length >= self.soft_end_length) && (self.current_length <= self.max_length)
	end

end