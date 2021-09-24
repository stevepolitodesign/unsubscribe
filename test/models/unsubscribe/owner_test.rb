# TODO: This should probably be placed in unsubscribe/owner_test
require "test_helper"

module Unsubscribe
  class OwnerTest < ActiveSupport::TestCase

    setup do
      @user = users(:two)
      MailerSubscription.destroy_all
    end
    
    test "subscribed_to_mailer? should return correct value" do
      assert @user.subscribed_to_mailer? "MarketingMailer"

      @user.mailer_subscriptions.create!(
        mailer: "MarketingMailer",
        subscribed: false
      )

      assert_not @user.subscribed_to_mailer? "MarketingMailer"
    end
   
  end
end