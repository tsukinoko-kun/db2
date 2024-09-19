require "test_helper"

class RaceTest < ActiveSupport::TestCase
  test "associations" do
    assert_equal races(:one).track, tracks(:choco_island)
    assert_includes races(:one).players, players(:bob)
    assert_includes races(:one).laps, laps(:one)
  end
end
