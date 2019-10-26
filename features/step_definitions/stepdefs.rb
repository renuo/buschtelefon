Given("there is a tattler {string}") do |tattler_name|
  tattlers[tattler_name] = Tattler.new
end

Given("{string} is connected to {string}") do |tattler_a, tattler_b|
  tattlers[tattler_a].connect(tattlers[tattler_b])
end

Given("{string} knew about {string}") do |tattler, gossip|
  connections_backup = tattlers[tattler].connections.clone
  tattlers[tattler].connections.clear
  tattlers[tattler].feed(Gossip.new(gossip))
  tattlers[tattler].connections.push(*connections_backup)
end

Given("there is a network tattler {string}") do |tattler_name|
  tattlers[tattler_name] = NetTattler.new(host: "127.0.0.1")
  Thread.new { tattlers[tattler_name].listen }
  sleep 0.1
end

Given("{string} is remotely connected to {string}") do |network_tattler_name, remote_tattler_name|
  tattlers[network_tattler_name].connect_remote(host: "127.0.0.1", port: tattlers[remote_tattler_name].port)
end

When("{string} gossips about {string}") do |tattler, gossip|
  tattlers[tattler].feed(Gossip.new(gossip))
end

When("{string} inquires {string}") do |network_tattler_name, remote_tattler_name|
  tattlers[network_tattler_name].remote_connections.find { |remote_tattler|
    remote_tattler.port == tattlers[remote_tattler_name].port
  }.inquire
end

Then("{string} knows about {string}") do |tattler, gossip|
  sleep 0.1
  expect(tattlers[tattler].knowledge).to include(Gossip.new(gossip))
end

Then("{string} doesn't know about {string}") do |tattler, gossip|
  sleep 0.1
  expect(tattlers[tattler].knowledge).not_to include(Gossip.new(gossip))
end
