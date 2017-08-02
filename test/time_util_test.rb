require 'test/unit'
require_relative '.././app/time_util'

class TimeUtilTest < Test::Unit::TestCase

	def test_validate
		assert_equal false,TimeUtil.validate('IV:XI')
		assert_equal false,TimeUtil.validate('1920')

		assert_equal true,TimeUtil.validate('19:20')
		assert_equal false,TimeUtil.validate('29:20')
		assert_equal false,TimeUtil.validate('19:70')

		assert_equal true,TimeUtil.validate('09:10')
		assert_equal true,TimeUtil.validate('9:10')

		assert_equal true,TimeUtil.validate('9:01')
		assert_equal false,TimeUtil.validate('9:1')

		assert_equal false,TimeUtil.validate('09:10AM')
		assert_equal true,TimeUtil.validate('21:10')
		assert_equal false,TimeUtil.validate('09:10PM')
	end

	def test_get_minute
		assert_equal 60, TimeUtil.get_minutes('1:00')
		assert_equal 61, TimeUtil.get_minutes('1:01')
		assert_equal 600, TimeUtil.get_minutes('10:00')
		assert_equal 1210, TimeUtil.get_minutes('20:10')
	end

	def test_get_string
		assert_equal '01:00', TimeUtil.get_string(60)
		assert_equal '01:01', TimeUtil.get_string(61)
		assert_equal '10:00', TimeUtil.get_string(600)
		assert_equal '20:10', TimeUtil.get_string(1210)
	end

	def test_get_string_ampm
		assert_equal '01:00AM', TimeUtil.get_string_ampm(60)
		assert_equal '01:00PM', TimeUtil.get_string_ampm(780)
		assert_equal '00:00AM', TimeUtil.get_string_ampm(0)
		assert_equal '12:00PM', TimeUtil.get_string_ampm(720)
		assert_equal '12:01PM', TimeUtil.get_string_ampm(721)
	end
end