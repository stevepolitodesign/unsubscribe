# Unsubscribe
Automatically unsubscribe from emails in Rails. 

## Usage
```ruby
Unsubscribe.setup do |config|
  # Must be an array of Hashes.
  # The class key should be the name of a Mailer
  config.mailers = [
    {
      class: "MarketingMailer",
      name: "Marketing Emails",
      description: "Updates on promotions and sales."
    },
  ]

  # Must be :opt_in or :opt_out
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
