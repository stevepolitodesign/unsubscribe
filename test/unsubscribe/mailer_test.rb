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
          recipient: @user,
        ).promotion.deliver_now
      end
  
      @mailer_subscription.toggle!(:subscribed)
  
      assert_emails 1 do
        MarketingMailer.with(
          recipient: @user,
        ).promotion.deliver_now
      end    
    end

    test "should set headers" do
      @mailer_subscription.toggle!(:subscribed)

      email = MarketingMailer.with(
        recipient: @user,
      ).promotion

      assert_not_nil email.header["List-Unsubscribe"]
    end

  end
end

#<Mail::Message:13620, Multipart: true, Headers: <Date: Thu, 23 Sep 2021 22:26:06 -0400>, <From: from@example.com>, <To: two@example.com>, <Message-ID: <614d373e50942_362fbcc27aa@Steves-MBP.fios-router.home.mail>>, <Subject: Promotion>, <Mime-Version: 1.0>, <Content-Type: multipart/alternative; boundary="--==_mimepart_614d373e4fe49_362fbcc26b4"; charset=UTF-8>, <Content-Transfer-Encoding: 7bit>, <List-Unsubscribe: <http://example.com/unsubscribe/mailer_subscriptions/BAh7CEkiCGdpZAY6BkVUSSIfZ2lkOi8vZHVtbXkvVXNlci8yOTg0ODYzNzQGOwBUSSIMcHVycG9zZQY7AFQ6GG1haWxlcl9zdWJzY3JpcHRpb25JIg9leHBpcmVzX2F0BjsAVEkiHTIwMjEtMTAtMjRUMDI6MjY6MDYuMzE4WgY7AFQ=--fda2ec79d834aeba73324b278dacaa9d187d01bf?mailer=MarketingMailer>>>