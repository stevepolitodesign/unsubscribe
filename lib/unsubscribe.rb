require "unsubscribe/version"
require "unsubscribe/engine"

module Unsubscribe
  class Error < StandardError
  end

  # https://guides.rubyonrails.org/engines.html#configuring-an-engine

  # TODO: Raise an exception if this is not an array
  # TODO: Raise an exception if the Mailer does not exist
  # raise Unsubscribe::Error "mailers should be an array" unless Unsubscribe.mailers.class == Array
  mattr_accessor :mailers
  @@mailers = []
  
  # TODO: Raise an exception value is anything other than :opt_in or :opt_out
  mattr_accessor :subscription_strategy
  @@subscription_strategy = :opt_out

  def self.setup
    yield self
  end
end
