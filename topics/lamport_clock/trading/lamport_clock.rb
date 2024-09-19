class LamportClock
  attr_reader :timestamp

  def initialize
    @timestamp = 0
  end
  
  # advance own timestamp
  def tick
    @timestamp += 1
  end

  # select greater timestamp and advance
  def update(incoming_timestamp)
    @timestamp = [@timestamp, incoming_timestamp].max
    tick
  end
  
  # compare two timestamps
  def self.compare(a, b)
    # concurrent
    if a == b
      raise "#{a} and #{b} are concurrent and cannot be compared"
    end

    # a, b => -1
    return -1 if a < b
    
    # b, a => 1
    1
  end
  
  # sort a list of events by their timestamps
  def self.sort(events)
    events.sort do |e1, e2|
      compare(e1[:timestamp], e2[:timestamp])
    end
  end
end