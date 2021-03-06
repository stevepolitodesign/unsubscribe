require "test_helper"

module Unsubscribe
  class MailerTest < ActionMailer::TestCase
    setup do
      @user = users(:two)
      @mailer_subscription = @user.mailer_subscriptions.create!(
        subscribed: false,
        mailer: "MarketingMailer"
      )
    end

    test "should prevent delivery" do
      assert_no_emails do
        MarketingMailer.with(
          recipient: @user
        ).promotion.deliver_now
      end

      @mailer_subscription.toggle!(:subscribed)

      assert_emails 1 do
        MarketingMailer.with(
          recipient: @user
        ).promotion.deliver_now
      end
    end

    test "should set headers" do
      @mailer_subscription.toggle!(:subscribed)

      email = MarketingMailer.with(
        recipient: @user
      ).promotion

      assert_not_nil email.header["List-Unsubscribe"]
    end
  end
end
