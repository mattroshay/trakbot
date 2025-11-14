require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should have many trackers" do
    user = users(:one)
    assert_respond_to user, :trackers
  end

  test "should destroy associated trackers when user is destroyed" do
    user = users(:one)
    tracker_count = user.trackers.count
    assert tracker_count > 0, "User should have at least one tracker"

    assert_difference('Tracker.count', -tracker_count) do
      user.destroy
    end
  end

  test "valid user should be valid" do
    user = User.new(
      email: "test@example.com",
      password: "password123",
      password_confirmation: "password123"
    )
    assert user.valid?
  end

  test "should require email" do
    user = User.new(password: "password123")
    assert_not user.valid?
    assert_includes user.errors[:email], "can't be blank"
  end

  test "should require unique email" do
    existing_user = users(:one)
    user = User.new(
      email: existing_user.email,
      password: "password123"
    )
    assert_not user.valid?
    assert_includes user.errors[:email], "has already been taken"
  end
end
