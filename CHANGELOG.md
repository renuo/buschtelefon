# Changelog

## 0.5.0

* `Brain` now can batch load gossips to circumvent expensive reorganizations

## 0.4.2

* Fix gemspec link to Github

## 0.4.1

* `NetTattler` can now be configured with a host it should bind to.

## 0.4.0

* `NetTattler` now sends inquired payload back to requester
* `NetTattler` now attaches source information to gossip processor
* `NetTattler` now listens on a system chosen port per default
* `NetTattler` now connects to remotes via `connect_remote` and sends packets
  to them via its outbound port (so it can receive responses)
* We work with IPs now instead of host names
* Default `Brain` capacity is now infinite
* `Tattler` now can load messages directly into its brain

## 0.3.0

* `NetTattler` now yields a `Gossip` instead of a raw message string.
* `Gossip` now uses float unix timestamps

## 0.2.0

* Host port of `NetTattler` is now optional
* `NetTattler` makes a brain dump to a `RemoteTattler` if it
  receives [`"\x05"`](https://en.wikipedia.org/wiki/Enquiry_character)
* `Tattler` exposes its brain as `#knowledge`
* There are now some Cucumber tests

## 0.1.0

* Initial release
