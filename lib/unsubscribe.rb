require "unsubscribe/version"
require "unsubscribe/engine"

module Unsubscribe

  # TODO: Make this a separate file
  SETTINGS = OpenStruct.new(
    subscription_strategy: :opt_out,
  ).freeze

  # TODO: Make this a separate file
  class Error < StandardError
  end

  # TODO: Make this a separate file
  module Mailer
    extend ActiveSupport::Concern

    included do
      before_action :set_recipient
      before_action :set_unsubscribe_url, if: :should_unsubscribe?
      after_action :prevent_delivery_if_recipient_opted_out, if: :should_unsubscribe?
    end

    class_methods do
      def unsubscribe_settings(name: nil, description: nil)
        cattr_accessor :unsubscribe_settings, default: { enabled: true, name: name, description: description }
      end
    end

    private
  
    def prevent_delivery_if_recipient_opted_out
      mail.perform_deliveries = @recipient.subscribed_to_mailer? self.class.to_s
    end
  
    def set_recipient
      @recipient = params[:recipient]
    end
    
    def set_unsubscribe_url
      @unsubscribe_url = unsubscribe.mailer_subscription_url(@recipient.to_sgid_for_mailer_subscription, mailer: self.class)
    end  
  
    def should_unsubscribe?
      @recipient.present? && @recipient.respond_to?(:subscribed_to_mailer?)
    end

  end

  # TODO: Make this a separate file 
  module Owner
    extend ActiveSupport::Concern

    included do
      has_many :mailer_subscriptions, class_name: "Unsubscribe::MailerSubscription", as: :owner, inverse_of: :owner, dependent: :destroy
    end

    def subscribed_to_mailer?(mailer)
      case Unsubscribe.subscription_strategy
      when :opt_in
        Unsubscribe::MailerSubscription.find_by(
          owner: self,
          mailer: mailer,
          subscribed: true
        ).present?
      else
        Unsubscribe::MailerSubscription.find_by(
          owner: self,
          mailer: mailer,
          subscribed: false
        ).nil?
      end
    end

    def to_sgid_for_mailer_subscription
      self.to_sgid(for: :mailer_subscription)
    end
  end

  mattr_accessor :subscription_strategy
  @@subscription_strategy = SETTINGS.subscription_strategy

  def self.setup
    yield self
  end
end
