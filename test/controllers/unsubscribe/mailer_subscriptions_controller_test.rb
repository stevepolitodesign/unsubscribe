require "test_helper"

module Unsubscribe
  class MailerSubscriptionsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @user = users(:two)
    end

    test "should get" do
      get mailer_subscription_path(@user.to_sgid(for: :mailer_subscription), mailer: "MarketingMailer")
      assert_response :ok
    end

    test "should create" do
      assert_difference("Unsubscribe::MailerSubscription.count", 1) do
        post mailer_subscriptions_path, params: { id: @user.to_sgid(for: :mailer_subscription), mailer_subscription: { owner_id: @user.id } }
      end
      
      assert_not @user.mailer_subscriptions.last.subscribed? 
    end   

    test "should update" do
      flunk
    end

    test "should handle bad token" do
      flunk
    end
  end
end
