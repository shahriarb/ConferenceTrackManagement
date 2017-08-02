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
					break if talk_added
				end

				if talk_added
					if index == talks_order.size - 1
						#All talks fit into tracks. lets check if all tracks are completed
						successful_plan = conference.tracks.all? {|track| track.is_completed?  }
					end
				else
					#This order is not working. go for next order
					break
				end
			end
			starting_point += 1 unless successful_plan
		end

		raise "It seems we can not fit talks to #{conference.tracks.size} track(s)" unless successful_plan

		conference
	end
end