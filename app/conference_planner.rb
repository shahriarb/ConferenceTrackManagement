class ConferencePlanner
	def self.plan(talks,conference)
		all_sessions = []

		conference.tracks.each do |track|
			all_sessions << track.morning_session
			all_sessions << track.afternoon_session
		end

		successful_plan = false

		factorials = []
		factorials[0] = 1
		for index in 1..talks.size-1
			factorials[index] = factorials[index-1] * index
	    end

		for index in 0..talks.size-1
			talks_perm = []
			temp_perm = talks.dup
			position_code = index
			talks.size.downto(1) do |position|
				selected = (position_code / factorials[position-1]).abs;
				talks_perm << temp_perm[selected]
				position_code = position_code % factorials[position-1];
				temp_perm.delete_at(selected)
			end

			for starting_point in 0..(talks_perm.size-1)
				all_sessions.each {|session| session.reset}

				talks_order = talks_perm[starting_point..-1]
				talks_order +=  talks_perm[0..starting_point-1]  unless starting_point == 0
				talks_order.each_with_index do |talk, index|
					talk_added = all_sessions.any? {|session| session.add_talk(talk)}
					break unless talk_added
					successful_plan = conference.tracks.all? {|track| track.is_completed?  }  if index == talks_order.size - 1
				end

				break if successful_plan
			end

			break if successful_plan
		end

		raise "It seems we can not fit talks to #{conference.tracks.size} track(s)" unless successful_plan

		conference
	end



end