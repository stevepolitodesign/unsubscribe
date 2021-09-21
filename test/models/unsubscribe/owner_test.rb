require "test_helper"

module Unsubscribe
  class OwnerTest < ActiveSupport::TestCase

    setup do
      @user = users(:two)
      MailerSubscription.destroy_all
    end
    
    test "subscribed_to_mailer? should return true when subscription_strategy is opt_out" do
      Unsubscribe.subscription_strategy = :opt_out

      assert @user.subscribed_to_mailer? "MarketingMailer"

      @user.mailer_subscriptions.create!(
        mailer: "MarketingMailer",
        subscribed: false
      )

      assert_not @user.subscribed_to_mailer? "MarketingMailer"
    end

    test "subscribed_to_mailer? should return true when subscription_strategy is opt_in" do
      Unsubscribe.subscription_strategy = :opt_in

      assert_not @user.subscribed_to_mailer? "MarketingMailer"

      @user.mailer_subscriptions.create!(
        mailer: "MarketingMailer",
        subscribed: true
      )

      assert @user.subscribed_to_mailer? "MarketingMailer"
    end    
  end
end