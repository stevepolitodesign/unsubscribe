require "unsubscribe/version"
require "unsubscribe/engine"
require "unsubscribe/error"

module Unsubscribe
  autoload :Mailer, "unsubscribe/mailer"
  autoload :Owner, "unsubscribe/owner"
end