require "unsubscribe/version"
require "unsubscribe/engine"

module Unsubscribe
  DEFAULT_MAILER_VALUE = [].freeze
  DEFAULT_SUBSCRIPTION_STRATEGY_VALUE = :opt_out
  SUBSCRIPTION_STRATEGIES = %i(opt_in opt_out).freeze

  class Error < StandardError
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
