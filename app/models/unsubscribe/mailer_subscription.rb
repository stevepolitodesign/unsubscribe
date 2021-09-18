module Unsubscribe
  class MailerSubscription < ApplicationRecord
    belongs_to :owner, polymorphic: true
  end
end
