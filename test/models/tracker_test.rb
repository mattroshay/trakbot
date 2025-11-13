require "test_helper"

class TrackerTest < ActiveSupport::TestCase
  test "valid tracker should be valid" do
    tracker = Tracker.new(
      user: users(:one),
      link: "https://www.example.com",
      description: "Test tracker description"
    )
    assert tracker.valid?
  end

  test "should belong to user" do
    tracker = trackers(:python_course)
    assert_respond_to tracker, :user
    assert_instance_of User, tracker.user
  end

  test "should require link" do
    tracker = Tracker.new(
      user: users(:one),
      description: "Test description"
    )
    assert_not tracker.valid?
    assert_includes tracker.errors[:link], "can't be blank"
  end

  test "should require valid URL format" do
    tracker = Tracker.new(
      user: users(:one),
      link: "not-a-valid-url",
      description: "Test description"
    )
    assert_not tracker.valid?
    assert_includes tracker.errors[:link], "must be a valid URL"
  end

  test "should accept http URLs" do
    tracker = Tracker.new(
      user: users(:one),
      link: "http://www.example.com",
      description: "Test description"
    )
    assert tracker.valid?
  end

  test "should accept https URLs" do
    tracker = Tracker.new(
      user: users(:one),
      link: "https://www.example.com",
      description: "Test description"
    )
    assert tracker.valid?
  end

  test "should reject URLs without protocol" do
    tracker = Tracker.new(
      user: users(:one),
      link: "www.example.com",
      description: "Test description"
    )
    assert_not tracker.valid?
    assert_includes tracker.errors[:link], "must be a valid URL"
  end

  test "should require description" do
    tracker = Tracker.new(
      user: users(:one),
      link: "https://www.example.com"
    )
    assert_not tracker.valid?
    assert_includes tracker.errors[:description], "can't be blank"
  end

  test "should reject description shorter than 3 characters" do
    tracker = Tracker.new(
      user: users(:one),
      link: "https://www.example.com",
      description: "AB"
    )
    assert_not tracker.valid?
    assert_includes tracker.errors[:description], "is too short (minimum is 3 characters)"
  end

  test "should reject description longer than 500 characters" do
    tracker = Tracker.new(
      user: users(:one),
      link: "https://www.example.com",
      description: "A" * 501
    )
    assert_not tracker.valid?
    assert_includes tracker.errors[:description], "is too long (maximum is 500 characters)"
  end

  test "keywords should be optional" do
    tracker = Tracker.new(
      user: users(:one),
      link: "https://www.example.com",
      description: "Test description",
      keywords: nil
    )
    assert tracker.valid?
  end
end
