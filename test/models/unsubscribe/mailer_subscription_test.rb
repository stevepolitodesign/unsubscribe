require "test_helper"

module Unsubscribe
  class MailerSubscriptionTest < ActiveSupport::TestCase
    setup do
      @owner = users(:two)
      @mailer_subscription = @owner.mailer_subscriptions.new(mailer: "MarketingMailer")
    end

    test "should be valid" do
      assert @mailer_subscription.valid?
    end

    test "should be unique across owner and mailer" do
      @mailer_subscription.save!
      @duplicate_mailer_subscription = @owner.mailer_subscriptions.new(mailer: "MarketingMailer")
      assert_not @duplicate_mailer_subscription.valid?
    end

    test "should have a mailer" do
      @mailer_subscription.mailer = nil
      assert_not @mailer_subscription.valid?
    end

    test "should be deleted when owner is deleted" do
      @mailer_subscription.save!
      assert_difference("Unsubscribe::MailerSubscription.count", -1) do
        @mailer_subscription.owner.destroy!
      end
    end

    test "should return details" do
      assert_kind_of Hash, @mailer_subscription.details
    end

    test "should raise exception if mailer does not exist" do
      @mailer_subscription.mailer = "SomeFakeMailer"
      assert_raises(Unsubscribe::Error) do
        @mailer_subscription.details
      end
    end

    test "should raise exception if mailer does not respond to unsubscribe_settings" do
      @mailer_subscription.mailer = "Security"  
      assert_raises(Unsubscribe::Error) do
        @mailer_subscription.details
      end
    end    

    test "should return name" do
      assert_equal "Marketing Emails", @mailer_subscription.name
    end

    test "should return description" do
      assert_equal "Updates on promotions and sales.", @mailer_subscription.description
    end

    test "should return action" do
      assert_equal "Subscribe to", @mailer_subscription.action
      @mailer_subscription.subscribed = true
      assert_equal "Unsubscribe from", @mailer_subscription.action
    end

    test "should return call_to_action" do
      assert_equal "Subscribe to Marketing Emails", @mailer_subscription.call_to_action
    end

  end
end
