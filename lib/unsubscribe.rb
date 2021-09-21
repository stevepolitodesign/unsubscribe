require "unsubscribe/version"
require "unsubscribe/engine"

module Unsubscribe

  # TODO: Make this a separate file
  SETTINGS = OpenStruct.new(
    subscription_strategy: :opt_out
  ).freeze

  # TODO: Make this a separate file
  class Error < StandardError
  end

  # TODO: Make this a separate file
  module Mailer
    extend ActiveSupport::Concern

    class_methods do
      def unsubscribe_settings(name: nil, description: nil)
        cattr_accessor :unsubscribe_settings, default: { enabled: true, name: name, description: description }
      end
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
      when :opt_out
        Unsubscribe::MailerSubscription.find_by(
          owner: self,
          mailer: mailer,
          subscribed: false
        ).nil?
      when :opt_in
        Unsubscribe::MailerSubscription.find_by(
          owner: self,
          mailer: mailer,
          subscribed: true
        ).present?
      end
    end
  end

  # https://guides.rubyonrails.org/engines.html#configuring-an-engine  
  # TODO: Raise an exception value is anything other than :opt_in or :opt_out
  mattr_accessor :subscription_strategy
  @@subscription_strategy = SETTINGS.subscription_strategy

  def self.setup
    yield self
  end
end
