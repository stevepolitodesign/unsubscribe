module Unsubscribe
  class MailerSubscription < ApplicationRecord
    INCLUDED_MAILERS = Unsubscribe::SETTINGS.mailers.map{ |mailer| mailer[:class] }.freeze

    belongs_to :owner, polymorphic: true

    before_validation :validate_configured_mailers

    validates :subscribed, inclusion: [true, false], allow_nil: true
    validates :mailer, presence: true
    validates :mailer, inclusion: INCLUDED_MAILERS
    validates :owner_id, uniqueness: { scope: [:mailer, :owner_type] }

    def self.has_configured_mailers?
      Unsubscribe::SETTINGS.mailers.present? && Unsubscribe::SETTINGS.mailers.map{ |mailer| mailer[:class] }.present?
    end

    private

    def validate_configured_mailers
      raise Unsubscribe::Error, "Please add mailers to config/initializers/unsubscribe.rb" unless Unsubscribe::MailerSubscription.has_configured_mailers?
    end

  end
end
