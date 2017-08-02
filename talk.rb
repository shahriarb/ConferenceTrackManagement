class Talk
	attr_accessor :description
	attr_reader :title, :duration

	def title=(new_title)
		raise 'Title can not have any number in it' if new_title =~ /.*\d.*/
		@title = new_title
	end

	def duration=(new_duration)
		raise "#{new_duration} should be a number" unless new_duration.is_a? Integer
		raise 'Duration should be greater than zero' if new_duration <= 0
		@duration = new_duration
	end

end