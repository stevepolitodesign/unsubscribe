module Unsubscribe
  # Preview all emails at http://localhost:3000/rails/mailers/marketing_mailer
  class MarketingMailerPreview < ActionMailer::Preview

    # Preview this email at http://localhost:3000/rails/mailers/marketing_mailer/promotion
    def promotion
      MarketingMailer.promotion
    end

  end
end
