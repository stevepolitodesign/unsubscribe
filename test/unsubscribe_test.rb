require "test_helper"

class UnsubscribeTest < ActiveSupport::TestCase
  test "it has a version number" do
    assert Unsubscribe::VERSION
  end

  test "can set mailers" do
    assert Unsubscribe.respond_to?(:mailers)
    assert Unsubscribe.respond_to?(:mailers=)
  end

  test "mailer should be an array" do
    assert_raises(Unsubscribe::Error) do
      Unsubscribe.mailers= "some_string"
    end
  end
end
