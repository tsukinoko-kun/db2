require "test_helper"

class CharacterTest < ActiveSupport::TestCase
  test "associations" do
    assert_includes characters(:peach).players, players(:alice)
  end
end
