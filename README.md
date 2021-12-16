# CloudModel::Api::Hetzner

![RSpec](https://github.com/cloudmodel/cloudmodel-api-hetzner/workflows/RSpec/badge.svg)
![CodeQL](https://github.com/cloudmodel/cloudmodel-api-hetzner/workflows/CodeQL/badge.svg)

Support for Hetzner Hosting API in [CloudModel](https://github.com/cloudmodel/cloudmodel).

## Usage
Adds following ablities to CloudModel:

* Change Hetzner server name on changing CloudModel host´s name
* Sync changes to Hetzner servers and subnets to CloudModel host´s configuration

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'cloudmodel-api-hetzner'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install cloudmodel-api-hetzner
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
