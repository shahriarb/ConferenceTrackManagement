class ConferencePlanner

	# To plan, I calculate different permutations of talks orders and then try to fit a permutation into different sessions of tracks
	def plan(talks, conference)
		successful_plan = false

		#To protect against sorted list
		talks = talks.shuffle

		# Using factorial to calculate permutations
		# https://en.wikipedia.org/wiki/Factorial_number_system#Permutations
		factorials = get_factorials(talks.size)

		for index in 0..talks.size-1
			talks_perm = []
			temp_perm = talks.dup
			position_code = index
			talks.size.downto(1) do |position|
				selected = (position_code / factorials[position-1]).ceil
				talks_perm << temp_perm[selected]
				position_code = position_code % factorials[position-1]
				temp_perm.delete_at(selected)
			end

			#try to find a successful plan for this permutation
			successful_plan = plan_for_permutation(talks_perm, conference)
			break if successful_plan
		end

		raise "It seems we can not fit talks to #{conference.tracks.size} track(s)" unless successful_plan

		conference
	end

	#Try to add talks into sessions by choosing different starting points in permutation
	def plan_for_permutation(talks_permutation, conference)
		successful_plan = false
		for starting_point in 0..(talks_permutation.size-1)
			conference.all_sessions.each {|session| session.reset}

			talks_order = talks_permutation[starting_point..-1]
			talks_order += talks_permutation[0..starting_point-1] unless starting_point == 0
			talks_order.each_with_index do |talk, index|
				#try to add talk to one of sessions
				talk_added = conference.all_sessions.any? {|session| session.add_talk(talk)}
				#start again with a new starting point if talk can not be added to any session
				break unless talk_added
				#if it is last talk , check tracks. if all tracks are full we have a successful plan
				successful_plan = conference.tracks.all? {|track| track.is_full?} if index == talks_order.size - 1
			end

			break if successful_plan
		end
		successful_plan
	end

	private

	def get_factorials(size)
		result = []
		result[0] = 1
		for index in 1..size-1
			result[index] = result[index-1] * index
		end
		result
	end

end