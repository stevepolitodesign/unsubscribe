module Unsubscribe
  class MailerSubscription < ApplicationRecord
    belongs_to :owner, polymorphic: true

    validates :subscribed, inclusion: [true, false], allow_nil: true
    validates :mailer, presence: true
    validates :owner_id, uniqueness: { scope: [:mailer, :owner_type] }

    def name
      binding.irb
      
    end
  end
end
