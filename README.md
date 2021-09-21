# Unsubscribe
Automatically unsubscribe from emails in Rails. 

## Usage
```ruby
class MarketingMailer < ApplicationMailer  
  include Unsubscribe::Mailer

  unsubscribe_settings name: "Marketing Emails", description: "Updates on promotions and sales."
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
