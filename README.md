# Buschtelefon

With *buschtelefon* you can setup a gossiping meshnet.
All of it should behave just like human beings tattling at a
coffee party.

There basically are two features:
* Nodes make coffee klatsch available between each other automatically.
* Nodes can be asked about stale information to fight FOMO.

Communication happens via UDP. Autodiscovery of nodes is not
implemented (yet).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'buschtelefon'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install buschtelefon

## Usage

You can setup your tattling meshnet the following way:

```ruby
include Buschtelefon

aunt_may = NetTattler.new(port: 1337)
aunt_ruth = RemoteTattler.new(host: 'example.com', port: 1337) 
aunt_may.connect(aunt_ruth)

aunt_may.feed(Gossip.new('Renuo can do blockchain consulting!'))
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
