Given("there's tattler {string}") do |tattler|
  tattlers[tattler] = Tattler.new
end

Given("{string} is connected to {string}") do |tattlerA, tattlerB|
  tattlers[tattlerA].connect(tattlers[tattlerB])
end

When("{string} gossips about {string}") do |tattler, gossip|
  puts "tattler #{tattlers[tattler]} talks"
end

Then("{string} hears {string}") do |tattler, gossip|
  puts "tattler #{tattlers[tattler]} hears"
end