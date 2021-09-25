module Unsubscribe
  class MailerSubscription < ApplicationRecord
    belongs_to :owner, polymorphic: true

    validates :subscribed, inclusion: [true, false], allow_nil: true
    validates :mailer, presence: true
    validates :owner_id, uniqueness: {scope: [:mailer, :owner_type]}
    validate :mailer_should_exist

    def action
      case subscribed
      when nil
        I18n.t("unsubscribe.action.unsubscribe")
      else
        subscribed? ? I18n.t("unsubscribe.action.unsubscribe") : I18n.t("unsubscribe.action.subscribe")
      end
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
      mailer.constantize.unsubscribe_settings
    rescue NoMethodError
      raise Unsubscribe::Error, "Make sure to include Unsubscribe::Mailer in #{mailer}"
    end

    private

    def mailer_should_exist
      errors.add(:mailer, "is not a enbled") unless mailer.constantize.enabled
    rescue NameError
      errors.add(:mailer, "is not a Mailer")
    end
  end
end
