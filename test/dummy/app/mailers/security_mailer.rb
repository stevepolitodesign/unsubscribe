class SecurityMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.security_mailer.notice.subject
  #
  def notice
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
