require "test_helper"

class LapTest < ActiveSupport::TestCase
  test "associations" do
    assert_equal laps(:one).race, races(:one)
    assert_equal laps(:one).player, players(:bob)
  end

end
