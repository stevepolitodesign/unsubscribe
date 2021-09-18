require "test_helper"

module Unsubscribe
  class MailerSubscriptionTest < ActiveSupport::TestCase
    setup do
      Unsubscribe.mailers = [{
        class: "MarketingMailer",
        name: "Marketing Emails",
        description: "Updates on promotions and sales."        
      }]
      @owner = users(:two)
      @mailer_subscription = @owner.mailer_subscriptions.new(mailer: "MarketingMailer")
    end

    test "should be valid" do
      assert @mailer_subscription.valid?
    end

    test "should be unique across owner and mailer" do
      @mailer_subscription.save!
      @duplicate_mailer_subscription = @owner.mailer_subscriptions.new(mailer: "MarketingMailer")
      assert_not @mailer_subscription.valid?
    end

    test "should have a mailer" do
      @mailer_subscription.mailer = nil
      assert_not @mailer_subscription.valid?
    end

    test "mailer should be in list" do
      invalid_mailers = %w(Foo Bar Baz)
      invalid_mailers.each do |invalid_mailer|
        @mailer_subscription.mailer = invalid_mailer
        assert_not @mailer_subscription.valid?
      end
    end

    test "should be deleted when owner is deleted" do
      flunk
    end

    test "should return details" do
      flunk
    end

    test "should return name" do
      flunk
    end

    test "should return description" do
      flunk
    end

    test "should return action" do
      flunk
    end

    test "should return call_to_action" do
      flunk
    end

    # TODO: Test this it's a hash with keys of class, name and description
    test "should raise exception if Unsubscribe::SETTINGS.mailers is not properly formatted" do
      flunk
    end

  end
end
