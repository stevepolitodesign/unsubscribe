module Unsubscribe
  class MailerSubscription < ApplicationRecord
    belongs_to :owner, polymorphic: true

    validates :subscribed, inclusion: [true, false], allow_nil: true
    validates :mailer, presence: true
    validates :owner_id, uniqueness: { scope: [:mailer, :owner_type] }
    validate :mailer_should_exist

    # TODO: Add i18n
    def action
      subscribed? ? "Unsubscribe from" : "Subscribe to"
    end

    def call_to_action
      "#{action} #{name}"
    end

    def description
      details[:description]
    end

    def name
      details[:name].present? ? details[:name] : mailer
    end

    def details
      begin
        mailer.constantize.unsubscribe_settings
      rescue NoMethodError
        raise Unsubscribe::Error, "Make sure to include Unsubscribe::Mailer in #{mailer}"
      end
    end
    
    private

    def mailer_should_exist
      begin
        errors.add(:mailer, "is not a enbled") unless mailer.constantize.unsubscribe_settings[:enabled]
      rescue NameError
        errors.add(:mailer, "is not a Mailer")
      end
    end

  end
end
