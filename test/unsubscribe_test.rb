require "test_helper"

class UnsubscribeTest < ActiveSupport::TestCase
  test "it has a version number" do
    assert Unsubscribe::VERSION
  end

  test "default subscription_strategy is opt_out" do
    assert_equal :opt_out, Unsubscribe.subscription_strategy
  end

  test "can set subscription_strategy" do
    assert Unsubscribe.respond_to?(:subscription_strategy)
    assert Unsubscribe.respond_to?(:subscription_strategy=)
  end

  test "can be configured" do
    assert Unsubscribe.respond_to?(:setup)
  end

end
