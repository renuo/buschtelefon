# Changelog

## next

* `Gossip` now uses float unix timestamps

## 0.2.0

* Host port of `NetTattler` is now optional
* `NetTattler` makes a brain dump to a `RemoteTattler` if it
  receives [`"\x05"`](https://en.wikipedia.org/wiki/Enquiry_character)
* `Tattler` exposes its brain as `#knowledge`
* There are now some Cucumber tests

## 0.1.0

* Initial release
