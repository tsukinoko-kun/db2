require "test_helper"

class PlayerTest < ActiveSupport::TestCase
  test "associations" do
    assert_equal players(:alice).character, characters(:peach)
    assert_nil players(:alice).race
    
    assert_equal players(:bob).character, characters(:mario)
    assert_equal players(:bob).race, races(:one)
    assert_includes players(:bob).laps, laps(:one)
  end
end
