require "unsubscribe/version"
require "unsubscribe/engine"

module Unsubscribe
  class Error < StandardError
  end

  # https://guides.rubyonrails.org/engines.html#configuring-an-engine
  mattr_accessor :mailers
  @@mailers = []
end
