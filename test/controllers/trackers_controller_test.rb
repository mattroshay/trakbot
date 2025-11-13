require "test_helper"

class TrackersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @other_user = users(:two)
    @tracker = trackers(:python_course)
    @other_tracker = trackers(:job_posting)
  end

  # Authentication tests
  test "should redirect to sign in if not logged in" do
    get trackers_url
    assert_redirected_to new_user_session_path
  end

  test "should redirect create to sign in if not logged in" do
    assert_no_difference('Tracker.count') do
      post trackers_url, params: { tracker: { link: "https://example.com", description: "Test" } }
    end
    assert_redirected_to new_user_session_path
  end

  # Index tests
  test "should get index when logged in" do
    sign_in @user
    get trackers_url
    assert_response :success
  end

  test "should only show current user's trackers in index" do
    sign_in @user
    get trackers_url
    assert_response :success
    assert_select "h5.card-title", text: @tracker.description
    assert_select "h5.card-title", text: @other_tracker.description, count: 0
  end

  # Show tests
  test "should show tracker when logged in as owner" do
    sign_in @user
    get tracker_url(@tracker)
    assert_response :success
  end

  test "should not show other user's tracker" do
    sign_in @user
    assert_raises(ActiveRecord::RecordNotFound) do
      get tracker_url(@other_tracker)
    end
  end

  # New tests
  test "should get new when logged in" do
    sign_in @user
    get new_tracker_url
    assert_response :success
  end

  # Create tests
  test "should create tracker when logged in with valid data" do
    sign_in @user
    assert_difference('Tracker.count', 1) do
      post trackers_url, params: {
        tracker: {
          link: "https://www.newsite.com",
          description: "New tracker description",
          keywords: "test"
        }
      }
    end
    assert_redirected_to tracker_path(Tracker.last)
    assert_equal "Tracker was successfully created.", flash[:notice]
    assert_equal @user.id, Tracker.last.user_id
  end

  test "should not create tracker with invalid URL" do
    sign_in @user
    assert_no_difference('Tracker.count') do
      post trackers_url, params: {
        tracker: {
          link: "not-a-url",
          description: "Test description"
        }
      }
    end
    assert_response :unprocessable_entity
  end

  test "should not create tracker with short description" do
    sign_in @user
    assert_no_difference('Tracker.count') do
      post trackers_url, params: {
        tracker: {
          link: "https://www.example.com",
          description: "AB"
        }
      }
    end
    assert_response :unprocessable_entity
  end

  # Edit tests
  test "should get edit when logged in as owner" do
    sign_in @user
    get edit_tracker_url(@tracker)
    assert_response :success
  end

  test "should not get edit for other user's tracker" do
    sign_in @user
    assert_raises(ActiveRecord::RecordNotFound) do
      get edit_tracker_url(@other_tracker)
    end
  end

  # Update tests
  test "should update tracker when logged in as owner" do
    sign_in @user
    new_description = "Updated description"
    patch tracker_url(@tracker), params: {
      tracker: {
        description: new_description
      }
    }
    assert_redirected_to tracker_path(@tracker)
    assert_equal "Tracker was successfully updated.", flash[:notice]
    @tracker.reload
    assert_equal new_description, @tracker.description
  end

  test "should not update other user's tracker" do
    sign_in @user
    assert_raises(ActiveRecord::RecordNotFound) do
      patch tracker_url(@other_tracker), params: {
        tracker: { description: "Hacked description" }
      }
    end
  end

  test "should not update tracker with invalid data" do
    sign_in @user
    patch tracker_url(@tracker), params: {
      tracker: {
        link: "invalid-url"
      }
    }
    assert_response :unprocessable_entity
  end

  # Destroy tests
  test "should destroy tracker when logged in as owner" do
    sign_in @user
    assert_difference('Tracker.count', -1) do
      delete tracker_url(@tracker)
    end
    assert_redirected_to trackers_path
    assert_equal "Tracker was successfully deleted.", flash[:notice]
  end

  test "should not destroy other user's tracker" do
    sign_in @user
    assert_no_difference('Tracker.count') do
      assert_raises(ActiveRecord::RecordNotFound) do
        delete tracker_url(@other_tracker)
      end
    end
  end
end
