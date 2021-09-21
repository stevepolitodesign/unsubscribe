require "test_helper"

class SecurityMailerTest < ActionMailer::TestCase
  test "notice" do
    mail = SecurityMailer.notice
    assert_equal "Notice", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
