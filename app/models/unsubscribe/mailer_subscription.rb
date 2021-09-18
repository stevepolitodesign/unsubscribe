module Unsubscribe
  class MailerSubscription < ApplicationRecord
    belongs_to :owner
  end
end
