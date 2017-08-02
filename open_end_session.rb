require './session'

class OpenEndSession < Session
	attr_reader  :soft_end_time

	def soft_end_time=(new_time)
		raise "#{new_time} is not a valid time as soft end"  unless new_time.to_s =~ Session::VALID_DATE_REGEX
		@soft_end_time = Time.parse(new_time.to_s)
	end


end