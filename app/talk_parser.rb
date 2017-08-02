require_relative './talk'

class TalkParser
	LIGHTNING_DURATION = 5

	def self.parse(talk_description)
		raise 'Parse error. Correct format is: Title of talk with no number (#min|lightning)' unless talk_description =~ /^[^0-9]*\s((\d.(?i)min)|((?i)lightning))$/
		result = Talk.new
		result.description = talk_description.strip()
		words = talk_description.split(' ')
		duration = words.last
		if duration.downcase == 'lightning'
			result.duration = LIGHTNING_DURATION
		else
			result.duration = duration.gsub('min','').to_i
		end
		result.title = words[0..-2].join(' ')
		result
	end
end