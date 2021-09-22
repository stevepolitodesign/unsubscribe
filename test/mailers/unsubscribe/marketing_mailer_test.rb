require "test_helper"

module Unsubscribe
  class MarketingMailerTest < ActionMailer::TestCase
    setup do
      @user = users(:two)
      @mailer_subscription = @user.mailer_subscriptions.create!(
        subscribed: false,
        mailer: "MarketingMailer" 
      )
    end

    test "should not deliver if owner is unsubscribed" do
      
    end
  end
end
