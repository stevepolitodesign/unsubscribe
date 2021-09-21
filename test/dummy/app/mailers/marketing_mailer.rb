class MarketingMailer < ApplicationMailer  
  include Unsubscribe::Mailer

  unsubscribe_settings name: "Marketing Mailer", description: "Updates on promotions and sales."

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.marketing_mailer.promotion.subject
  #
  def promotion
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
