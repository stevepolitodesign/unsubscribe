Unsubscribe.setup do |config|
  # FIXME: This is overriding the default value in my test
  # rails test test/unsubscribe_test.rb:8 
  config.mailers = ["MarketingMailer"]
end