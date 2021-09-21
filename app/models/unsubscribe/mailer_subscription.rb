module Unsubscribe
  class MailerSubscription < ApplicationRecord
    belongs_to :owner, polymorphic: true

    validates :subscribed, inclusion: [true, false], allow_nil: true
    validates :mailer, presence: true
    validates :owner_id, uniqueness: { scope: [:mailer, :owner_type] }

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
      rescue NameError
        raise Unsubscribe::Error, "#{mailer} is not a Mailer."
      rescue NoMethodError
        raise Unsubscribe::Error, "Make sure to include Unsubscribe::Mailer in #{mailer}"
      end
    end

  end
end
