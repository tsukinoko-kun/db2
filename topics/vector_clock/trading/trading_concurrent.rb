require "./participant.rb"

# create participants
bob = Participant.new("bob")
alice = Participant.new("alice")
eve = Participant.new("eve")

# bid by bob
bid1 = bob.bid
alice.receive(bid1)
eve.receive(bid1)

# concurrent bids
bid2 = bob.bid
bid3 = alice.bid
bid4 = eve.bid

# bids are broadcasted
alice.receive(bid2)
alice.receive(bid4)
bob.receive(bid3)
bob.receive(bid4)
eve.receive(bid2)
eve.receive(bid3)

# lets collect all bids in a random order
puts "\nbids in random order:"
bids = [bid1, bid2, bid3, bid4].shuffle
bids.each{ |bid| puts bid }

# lets order them by their timestamp
puts "\nbids in timestamp order:"
bids = VectorClock.sort(bids)
bids.each{ |bid| puts bid }