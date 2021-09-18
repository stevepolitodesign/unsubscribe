require "test_helper"

module Unsubscribe
  class MailerSubscriptionTest < ActiveSupport::TestCase
    setup do
      @mailer_subscription = MailerSubscription.new(mailer: "MarketingMailer")
    end

    test "should be valid" do
      assert @mailer_subscription.valid?
    end

    test "should be unique across owner and mailer" do
      flunk
    end

    test "should have a mailer" do
      @mailer_subscription.mailer = nil
      assert_not @mailer_subscription.valid?
    end

    test "mailer should be in list" do
      valid_mailers = Unsubscribe.mailers = ["MarketingMailer"]
      valid_mailers.each do |valid_mailer|
        @mailer_subscription.mailer = valid_mailer
        assert @mailer_subscription.valid?
      end

      invalid_mailers = %w(Foo Bar Baz)
      invalid_mailers.each do |invalid_mailer|
        @mailer_subscription.mailer = invalid_mailer
        assert_not @mailer_subscription.valid?
      end
    end

    test "should raise exception if Unsubscribe.mailers is not an array" do
      flunk
    end

  end
end
