class VectorClock
  attr_reader :id, :timestamp

  def initialize id
    @id = id
    @timestamp = {}
    @timestamp[@id] = 0
  end
  
  # advance own timestamp
  def tick
    @timestamp = @timestamp.clone
    @timestamp[@id] += 1
  end

  # merge incoming timestamp and take max values
  def update(incoming_timestamp)
    @timestamp = @timestamp.merge(incoming_timestamp) do |id, v1, v2|
      [v1, v2].max
    end
    tick
  end

  # compare two vectors
  def self.compare(a, b)
    # a == b => 0
    return 0 if a == b

    # no history shared
    if (a.keys & b.keys).empty?
      raise "#{a} and #{b} don't share any history and cannot be compared"
    end

    # collect all keys from both vectors
    ids = (a.keys + b.keys).uniq

    # combine them into matched pairs
    pairs = ids.map do |id|
      [a[id] || 0, b[id] || 0]
    end

    # condition: each element of a <= b
    less_or_equal = pairs.all? { |pair| pair[0] <= pair[1] }
    
    # condition: at least one element of a < b
    less = pairs.any? { |pair| pair[0] < pair[1] }

    # a, b => -1
    return -1 if less_or_equal && less

    # is a concurrent with b?
    less    = pairs.any? { |pair| pair[0] < pair[1] }
    greater = pairs.any? { |pair| pair[0] > pair[1] }
    if less && greater
      raise "#{a} and #{b} are concurrent and cannot be compared"
    end
    
    # b, a => 1
    1
  end

  # sort a list of events by their timestamp vectors
  def self.sort(events)
    events.sort do |e1, e2|
      compare(e1[:timestamp], e2[:timestamp])
    end
  end
end