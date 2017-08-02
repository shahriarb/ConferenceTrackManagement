require './talk'

class TalkParser
	LIGHTNING_DURATION = 5

	def self.parse(talk_description)
		raise 'Parse error. Correct format is: Title of talk (#min|lightning) ' unless talk_description =~ /^.*\s((\d.(?i)min)|((?i)lightning))$/
		result = Talk.new
		result.description = talk_description
		words = talk_description.split(' ')
		raise 'Title or Duration is missing' if words.size < 2
		duration = words.last
		if duration.downcase == 'lightning'
			result.duration = LIGHTNING_DURATION
		else
			result.duration = duration.gsub('min','').to_i
		end
		result.title = words[0..-2]
		result
	end
end