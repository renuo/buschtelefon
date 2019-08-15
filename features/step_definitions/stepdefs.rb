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
  sleep 0.1
  expect(tattlers[tattler].knowledge).to include(Gossip.new(gossip))
end

Then("{string} doesn't know about {string}") do |tattler, gossip|
  sleep 0.1
  expect(tattlers[tattler].knowledge).not_to include(Gossip.new(gossip))
end

Given("there is a network tattler {string}") do |tattler_name|
  tattlers[tattler_name] = NetTattler.new
  Thread.new {  tattlers[tattler_name].listen }
  sleep 0.1
end

Given("{string} is remotely connected to {string}") do |network_tattler_name, remote_tattler_name|
  remote_tattler = RemoteTattler.new(host: 'localhost', port: tattlers[remote_tattler_name].port)
  tattlers[network_tattler_name].connect(remote_tattler)
end
