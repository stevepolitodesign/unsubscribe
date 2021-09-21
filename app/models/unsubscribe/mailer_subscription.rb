module Unsubscribe
  class MailerSubscription < ApplicationRecord
    belongs_to :owner, polymorphic: true

    validates :subscribed, inclusion: [true, false], allow_nil: true
    validates :mailer, presence: true
    validates :owner_id, uniqueness: { scope: [:mailer, :owner_type] }

    def name
      details[:name]
    end

    def details
      begin
        mailer.constantize.unsubscribe_settings
      rescue NoMethodError
        raise Unsubscribe::Error, "Make sure to include Unsubscribe::Mailer in #{mailer}"
      end
    end

  end
end
