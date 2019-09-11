# Buschtelefon

[![Travis Build Status](https://travis-ci.org/renuo/buschtelefon.svg?branch=master)](https://travis-ci.org/renuo/buschtelefon)

With *buschtelefon* you can setup a gossiping meshnet.
All of it should behave just like human beings tattling at a
coffee party.

There basically are two features:
* Nodes make coffee klatsch available between each other automatically.
* Nodes can be asked about stale information to fight FOMO.

Communication happens via UDP. Autodiscovery of nodes is not
implemented (yet).

## Installation

You can use this gem with Ruby versions starting from 2.1.
Add the following line to your application's Gemfile:

```ruby
gem 'buschtelefon'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install buschtelefon

## Usage

You can setup your local tattling meshnet the following way:

```ruby
require 'buschtelefon'
include Buschtelefon

aunt_may = NetTattler.new
aunt_ruth = NetTattler.new
remote_aunt_ruth = RemoteTattler.new(host: 'localhost', port: aunt_ruth.port)

aunt_may.connect(remote_aunt_ruth)

Thread.new { aunt_may.listen }
Thread.new { aunt_ruth.listen }

aunt_may.feed(Gossip.new('Did you hear about the cool company "Renuo"?'))

puts aunt_may.knowledge
puts aunt_ruth.knowledge
```

## Development

After checking out the repo, run `bin/setup` to install dependencies.
Then, run `bin/check` to run the tests. You can also run `bin/console`
for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`,
and then run `bundle exec rake release`, which will create a git tag
for the version, push git commits and tags, and push the `.gem` file
to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
<https://github.com/renuo/buschtelefon>.

## License

The gem is available as open source under the terms of
the [MIT License](https://opensource.org/licenses/MIT).
