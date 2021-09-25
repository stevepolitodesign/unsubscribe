# Unsubscribe

Automatically unsubscribe from emails in Rails.

## Usage

1. Run `rails unsubscribe:install:migrations`.
2. Run `rails db:migrate`.
3. Add `include Unsubscribe::Owner` to a `Model`. The `Model` must have an `email` column.

```ruby
class User < ApplicationRecord
  include Unsubscribe::Owner
end
```

4. Add `include Unsubscribe::Mailer` to a `Mailer`.
5. Call `unsubscribe_settings` and optionally set a `name` and `description`.
6. Set `mail to:` to `@recipient.email`. The `@recipient` is an instance of whatever Class `include Unsubscribe::Owner` was added to.

```ruby
class MarketingMailer < ApplicationMailer  
  include Unsubscribe::Mailer

  unsubscribe_settings name: "Marketing Emails", description: "Updates on promotions and sales."

  def promotion
    mail to: @recipient.email
  end  
end
```

7. Call the `Mailer` with a `recipient` parameter.

```ruby
  MarketingMailer.with(
    recipient: User.first
  ).promotion.deliver_now
```
 
8. Add the `@unsubscribe_url` link to the `Mailer`.

```html+erb
<%= link_to "Unsubscribe", @unsubscribe_url %>
```

9. Optionally run `rails g unsubscribe:views` if you want to modify the existing templates.

## Configuration

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