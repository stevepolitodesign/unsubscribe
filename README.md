# Unsubscribe

Automatically unsubscribe from emails in Rails. 

## Usage

```ruby
class User < ApplicationRecord
  include Unsubscribe::Owner
end
```

```ruby
class MarketingMailer < ApplicationMailer  
  include Unsubscribe::Mailer

  unsubscribe_settings name: "Marketing Emails", description: "Updates on promotions and sales."
end
```


## Configuration

By default an `Owner` will be subscribed to all Mailers. If you wish to make it so an `Owner` needs to opt-in to receive a Mailer, set `Unsubscribe.subscription_strategy` to `:opt_in`. The default value is `:opt_out`.

```ruby
# config/initializers/unsubscribe.rb
Unsubscribe.setup do |config|
  config.subscription_strategy = :opt_in
end
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'unsubscribe'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install unsubscribe
```

## Contributing

Contribution directions go here.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).