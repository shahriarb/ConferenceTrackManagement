require './conference'
require './session'
require './open_end_session'

class ConferencePlanner
	def self.plan(talks,conference)
		all_sessions = []

		conference.tracks.each {|t| all_sessions << t.sessions}
		all_sessions.flatten!

		successful_plan = false
		starting_point = 0
		while !successful_plan && starting_point < talks.size

			all_sessions.each {|session| session.reset}

			talks_order = talks[starting_point..-1]
			talks_order +=  talks[0..starting_point-1]  unless starting_point == 0
			talks_order.each_with_index do |talk, index|
				talk_added = false
				all_sessions.each do |session|
					talk_added = session.add_talk(talk)
				end

				if talk_added
					if index == talks_order.size - 1
						#All talks added, we have a successful ordering
						successful_plan = true
					end
				else
					#This order is not working go for next order
					starting_point += 1
					break
				end
			end
		end

		raise "It seems we can not fit talks to #{conference.tracks.size} track(s)" unless successful_plan

		raise 'There are still empty slots in conference plan' unless conference.tracks.all {|track| track.is_completed?  }

		conference
	end
end