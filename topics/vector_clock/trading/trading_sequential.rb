require "./participant.rb"

# create participants
bob = Participant.new("bob")
alice = Participant.new("alice")
eve = Participant.new("eve")

# bid by bob
bid1 = bob.bid
alice.receive(bid1)
eve.receive(bid1)

# bid by alice
bid2 = alice.bid
eve.receive(bid2)
bob.receive(bid2)

# bid by eve
bid3 = eve.bid
bob.receive(bid3)
eve.receive(bid3)

# lets collect all bids in a random order
puts "\nbids in random order:"
bids = [bid1, bid2, bid3].shuffle
bids.each{ |bid| puts bid }

# lets order them by their timestamp
puts "\nbids in timestamp order:"
bids = VectorClock.sort(bids)
bids.each{ |bid| puts bid }