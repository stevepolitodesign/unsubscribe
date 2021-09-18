Unsubscribe.setup do |config| 
  config.mailers = [
    {
      class: "MarketingMailer",
      name: "Marketing Emails",
      description: "Updates on promotions and sales."
    },
  ]
end