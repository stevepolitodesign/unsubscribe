require "test_helper"

module Unsubscribe
  class MailerSubscriptionsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @user = users(:two)
    end

    test "should get" do
      get mailer_subscription_path(@user.to_sgid_for_mailer_subscription, mailer: "MarketingMailer")
      assert_response :ok
    end

    test "should create" do
      assert_difference("@user.mailer_subscriptions.count", 1) do
        post mailer_subscriptions_path, params: 
          { 
            id: @user.to_sgid_for_mailer_subscription,
            mailer_subscription: { 
              owner_id: @user.id,
              owner_type: "User",
              subscribed: false,
              mailer: "MarketingMailer"
            }
          }
      end
    end   

    test "should update" do
      @mailer_subscription = unsubscribe_mailer_subscriptions(:one)
      @user = @mailer_subscription.owner
      original_subsribed_value = @mailer_subscription.subscribed

      put mailer_subscription_path(@user.to_sgid_for_mailer_subscription), params: {
        mailer_subscription_id: @mailer_subscription.id
      }

      assert_not_equal original_subsribed_value, @mailer_subscription.reload.subscribed 
    end

    test "should handle bad token" do
      assert_raises(ActiveRecord::RecordNotFound) do
        get mailer_subscription_path("bad_token", mailer: "MarketingMailer")
      end
    end

    test "should handle unauthorized on create" do
      Unsubscribe::MailerSubscription.destroy_all
      @another_user = users(:one)

      assert_no_difference("Unsubscribe::MailerSubscription.count", 1) do
        post mailer_subscriptions_path, params: 
          { 
            id: @user.to_sgid_for_mailer_subscription,
            mailer_subscription: { 
              owner_id: @another_user.id,
              owner_type: "User",
              subscribed: false,
              mailer: "MarketingMailer"
            }
          }
      end
    end

    test "should handle unauthorized on update" do
      @mailer_subscription_from_another_owner = unsubscribe_mailer_subscriptions(:one)

      original_subsribed_value = @mailer_subscription_from_another_owner.subscribed

      put mailer_subscription_path(@user.to_sgid_for_mailer_subscription), params: {
        mailer_subscription_id: @mailer_subscription_from_another_owner.id
      }

      assert_equal original_subsribed_value, @mailer_subscription_from_another_owner.reload.subscribed 
    end
    
  end
end
