require 'test/unit'
require_relative 'vector_clock'

class TestVectorClock < Test::Unit::TestCase
  def test_tick
    @clock = VectorClock.new("foo")
    @clock.tick
    @clock.tick
    @clock.tick
    assert_equal({"foo" => 3}, @clock.timestamp)
  end

  def test_update
    @clock1 = VectorClock.new("foo")
    @clock2 = VectorClock.new("bar")
    @clock1.tick
    @clock1.tick
    @clock2.tick
    @clock1.update(@clock2.timestamp)
    assert_equal({"foo" => 3, "bar" => 1}, @clock1.timestamp)
  end

  def test_compare
    [
      {
        a: { "foo": 1 },
        b: { "foo": 1 },
        result: 0
      },
      {
        a: { "foo": 1 },
        b: { "foo": 2 },
        result: -1
      },
      {
        a: { "foo": 2 },
        b: { "foo": 1 },
        result: 1
      },
      {
        a: { "foo": 1 },
        b: { "foo": 1, "bar": 2 },
        result: -1
      },
      {
        a: { "foo": 1, "bar": 2 },
        b: { "foo": 1 },
        result: 1
      }
    ].each do |t|
      assert_equal(t[:result], VectorClock.compare(t[:a], t[:b]))
    end
  end
  
  def test_compare_without_history
    assert_raises do
      VectorClock.compare({ "foo": 1 }, { "bar": 2 })
    end
  end
  
  def test_compare_concurrent
    assert_raises do
      VectorClock.compare({ "foo": 1, "bar": 2 }, { "bar": 1, "foo": 2 })
    end
  end
  
  def test_sort
    [
      {
        unsorted_events: [
          { timestamp: {"foo": 2 } },
          { timestamp: {"foo": 4 } },
          { timestamp: {"foo": 3 } },
          { timestamp: {"foo": 1 } },
        ],
        sorted_events: [
          { timestamp: {"foo": 1 } },
          { timestamp: {"foo": 2 } },
          { timestamp: {"foo": 3 } },
          { timestamp: {"foo": 4 } },
        ],
      },
      {
        unsorted_events: [
          { timestamp: {"foo": 2 } },
          { timestamp: {"foo": 4, "bar": 4 } },
          { timestamp: {"foo": 4, "bar": 3 } },
        ],
        sorted_events: [
          { timestamp: {"foo": 2 } },
          { timestamp: {"foo": 4, "bar": 3 } },
          { timestamp: {"foo": 4, "bar": 4 } },
        ],
      },
    ].each do |t|
      assert_equal(t[:sorted_events], VectorClock.sort(t[:unsorted_events]))
    end
  end
  
end