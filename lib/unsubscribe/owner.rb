module Unsubscribe
  module Owner
    extend ActiveSupport::Concern

    included do
      has_many :mailer_subscriptions, class_name: "Unsubscribe::MailerSubscription", as: :owner, inverse_of: :owner, dependent: :destroy
    end

    def subscribed_to_mailer?(mailer)
      Unsubscribe::MailerSubscription.find_by(
        owner: self,
        mailer: mailer,
        subscribed: false
      ).nil?
    end

    def to_sgid_for_mailer_subscription
      self.to_sgid(for: :mailer_subscription)
    end
  end
end