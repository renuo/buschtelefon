Given("there is a tattler {string}") do |tattler_name|
  tattlers[tattler_name] = Tattler.new
end

Given("{string} is connected to {string}") do |tattlerA, tattlerB|
  tattlers[tattlerA].connect(tattlers[tattlerB])
end

When("{string} gossips about {string}") do |tattler, gossip|
  tattlers[tattler].feed(Gossip.new(gossip))
end

Then("{string} knows about {string}") do |tattler, gossip|
  expect(tattlers[tattler].knowledge).to include(Gossip.new(gossip))
end

Then("{string} doesn't know about {string}") do |tattler, gossip|
  expect(tattlers[tattler].knowledge).not_to include(Gossip.new(gossip))
end
