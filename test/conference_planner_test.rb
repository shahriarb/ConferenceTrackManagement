require 'test/unit'
require_relative '.././app/input_file_reader'
require_relative '.././app/conference_factory'
require_relative '.././app/conference_planner'

class ConferencePlannerTest < Test::Unit::TestCase
	def test_plan
		conference_planner = ConferencePlanner.new

		input_talks, _ = InputFileReader.read_from_file('data/base_input.txt')
		conference = conference_planner.plan(input_talks,ConferenceFactory.new_conference(2))
		assert_block do
			conference.tracks.all? {|track| track.is_full?}
		end

		input_talks, _ = InputFileReader.read_from_file('data/short_input.txt')
		exception = assert_raise (RuntimeError ) {conference_planner.plan(input_talks,ConferenceFactory.new_conference(2))}
		assert_equal'It seems we can not fit talks to 2 track(s)', exception.message

		input_talks, _ = InputFileReader.read_from_file('data/long_input.txt')
		exception = assert_raise (RuntimeError ) {conference_planner.plan(input_talks,ConferenceFactory.new_conference(2))}
		assert_equal'It seems we can not fit talks to 2 track(s)', exception.message

		input_talks, _ = InputFileReader.read_from_file('data/long_talk.txt')
		exception = assert_raise (RuntimeError ) {conference_planner.plan(input_talks,ConferenceFactory.new_conference(2))}
		assert_equal'It seems we can not fit talks to 2 track(s)', exception.message

	end

	def test_plan_for_permutation
		conference_planner = ConferencePlanner.new

		input_talks, _ = InputFileReader.read_from_file('data/base_input.txt')
		successful_plan = conference_planner.plan_for_permutation(input_talks,ConferenceFactory.new_conference(2))
		assert_equal true,successful_plan
	end
end