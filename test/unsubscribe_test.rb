require "test_helper"

class UnsubscribeTest < ActiveSupport::TestCase
  test "it has a version number" do
    assert Unsubscribe::VERSION
  end

  test "default mailers is an empty array" do
    assert_equal [], Unsubscribe.mailers
  end

  test "can set mailers" do
    assert Unsubscribe.respond_to?(:mailers)
    assert Unsubscribe.respond_to?(:mailers=)
  end

  test "default subscription_strategy is opt_out" do
    assert_equal [], Unsubscribe.mailers
  end

  test "can set subscription_strategy" do
    assert Unsubscribe.respond_to?(:subscription_strategy)
    assert Unsubscribe.respond_to?(:subscription_strategy=)
  end  

end
