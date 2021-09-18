require "unsubscribe/version"
require "unsubscribe/engine"

module Unsubscribe
  # TODO: Make this a separate file
  DEFAULT_MAILER_VALUE = [].freeze
  DEFAULT_SUBSCRIPTION_STRATEGY_VALUE = :opt_out
  SUBSCRIPTION_STRATEGIES = %i(opt_in opt_out).freeze

  # TODO: Make this a separate file
  class Error < StandardError
  end

  # TODO: Make this a separate file 
  module Owner
    extend ActiveSupport::Concern

    included do
      has_many :mailer_subscriptions, class_name: "Unsubscribe::MailerSubscription", as: :owner, inverse_of: :owner
    end
  end

  # https://guides.rubyonrails.org/engines.html#configuring-an-engine

  # TODO: Raise an exception if this is not an array
  # TODO: Raise an exception if the Mailer does not exist
  # raise Unsubscribe::Error "mailers should be an array" unless Unsubscribe.mailers.class == Array
  mattr_accessor :mailers
  @@mailers = DEFAULT_MAILER_VALUE
  
  # TODO: Raise an exception value is anything other than :opt_in or :opt_out
  mattr_accessor :subscription_strategy
  @@subscription_strategy = DEFAULT_SUBSCRIPTION_STRATEGY_VALUE

  def self.setup
    yield self
  end
end
