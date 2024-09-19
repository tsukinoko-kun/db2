require "./lamport_clock.rb"

class Participant
  attr_reader :id

  def initialize id
    @id = id
    @clock = LamportClock.new
  end

  def receive(bid)
    @clock.update(bid[:timestamp])
    puts "-> #{@id} received bid with timestamp #{bid[:timestamp]}, updated local timestamp #{@clock.timestamp}"
  end

  def bid
    @clock.tick
    puts "\n#{@id} made a new bid at local timestamp #{@clock.timestamp}"
    { by: @id, timestamp: @clock.timestamp }
  end
end