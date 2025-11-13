# TRAKBOT - Phase 1 Testing Guide

## Automated Test Results ✅

**All tests passing:** 33 tests, 76 assertions, 0 failures

### Test Coverage

#### Model Tests (User)
- ✅ User has many trackers association
- ✅ Trackers are destroyed when user is destroyed (dependent: :destroy)
- ✅ Valid user passes validation
- ✅ Email is required
- ✅ Email must be unique

#### Model Tests (Tracker)
- ✅ Valid tracker passes validation
- ✅ Tracker belongs to user
- ✅ Link is required
- ✅ Link must be valid URL format
- ✅ HTTP URLs are accepted
- ✅ HTTPS URLs are accepted
- ✅ URLs without protocol are rejected
- ✅ Description is required
- ✅ Description minimum 3 characters
- ✅ Description maximum 500 characters
- ✅ Keywords are optional

#### Controller Tests (TrackersController)
- ✅ Redirects to sign in when not authenticated
- ✅ Index shows only current user's trackers
- ✅ Show displays tracker for owner
- ✅ Show prevents access to other user's trackers
- ✅ Create works with valid data
- ✅ Create validates URL format
- ✅ Create validates description length
- ✅ Edit accessible to owner only
- ✅ Update works with valid data
- ✅ Update prevents unauthorized access
- ✅ Update validates data
- ✅ Destroy works for owner
- ✅ Destroy prevents unauthorized deletion

---

## Manual Testing Checklist

### 1. User Registration & Authentication ✓

**Sign Up Flow:**
- [ ] Visit http://localhost:3000
- [ ] Click "Get Started" or "Sign Up"
- [ ] Enter email address
- [ ] Enter password (minimum 6 characters)
- [ ] Submit form
- [ ] Should be redirected to trackers index
- [ ] Should see welcome message or flash notification

**Sign In Flow:**
- [ ] Visit http://localhost:3000
- [ ] Click "Sign In"
- [ ] Enter valid email/password
- [ ] Submit form
- [ ] Should be redirected to trackers index

**Sign Out Flow:**
- [ ] Click user dropdown in navbar
- [ ] Click "Log out"
- [ ] Should be signed out and redirected to home page

**Password Reset:**
- [ ] Visit sign in page
- [ ] Click "Forgot your password?"
- [ ] Enter email address
- [ ] Check for password reset instructions (email not actually sent in dev)

---

### 2. Home Page ✓

**When Not Signed In:**
- [ ] Visit http://localhost:3000
- [ ] Should see "Track Changes. Stay Informed." headline
- [ ] Should see "Get Started" and "Sign In" buttons
- [ ] Should see 4 use case examples (Price Changes, Job Postings, Course Updates, Stock Availability)
- [ ] TRAKBOT logo in navbar links to home

**When Signed In:**
- [ ] Visit http://localhost:3000
- [ ] Should see "Go to My Trackers" and "Create New Tracker" buttons instead
- [ ] Navbar should show "Home", "My Trackers", "New Tracker" links
- [ ] User dropdown should show email address

---

### 3. Create Tracker ✓

**Valid Tracker Creation:**
- [ ] Sign in
- [ ] Click "New Tracker" in navbar or "Add New Tracker" button
- [ ] Enter valid URL: `https://www.udemy.com/course/python-bootcamp/`
- [ ] Enter description: "Python Bootcamp on Udemy"
- [ ] Enter keywords (optional): "price"
- [ ] Click "Create Tracker"
- [ ] Should be redirected to tracker detail page
- [ ] Should see success flash message
- [ ] Should display all tracker information

**Validation Errors:**
- [ ] Try creating tracker with invalid URL (e.g., "not-a-url")
  - Should stay on form with error message "Link must be a valid URL"
- [ ] Try creating tracker with URL missing protocol (e.g., "www.udemy.com")
  - Should show validation error
- [ ] Try creating tracker with empty description
  - Should show "Description can't be blank"
- [ ] Try creating tracker with description under 3 characters (e.g., "AB")
  - Should show "Description is too short"
- [ ] Try creating tracker with description over 500 characters
  - Should show "Description is too long"
- [ ] Leave keywords empty
  - Should be accepted (keywords are optional)

---

### 4. View Trackers ✓

**Empty State:**
- [ ] Sign in as new user with no trackers
- [ ] Visit "My Trackers"
- [ ] Should see empty state message "No trackers yet"
- [ ] Should see "Create your first tracker" button

**List View:**
- [ ] Sign in as user with trackers
- [ ] Visit "My Trackers"
- [ ] Should see all trackers in card grid layout
- [ ] Each card should display:
  - Description as title
  - URL (clickable, opens in new tab, truncated to 50 chars)
  - Keywords (if present) as badge
  - "Created X ago" timestamp
  - Three buttons: View, Edit, Delete
- [ ] Trackers should be ordered by newest first

---

### 5. View Tracker Details ✓

- [ ] Click "View" on any tracker card
- [ ] Should see detailed page with:
  - Tracker description as heading
  - Full URL (clickable with external link icon)
  - Keywords section (if present)
  - Creation timestamp
  - Last updated timestamp
  - "Coming Soon" info alert about Phase 2 features
- [ ] Should have "Edit Tracker" and "Delete Tracker" buttons
- [ ] "Back to Trackers" link should work

---

### 6. Edit Tracker ✓

**Successful Edit:**
- [ ] Click "Edit" on a tracker or "Edit Tracker" from detail page
- [ ] Form should be pre-filled with current values
- [ ] Change description to "Updated Python Course"
- [ ] Change URL to `https://www.udemy.com/course/python-complete/`
- [ ] Change keywords to "price, discount"
- [ ] Click "Update Tracker"
- [ ] Should redirect to tracker detail page
- [ ] Should show success message
- [ ] Should display updated information

**Validation on Edit:**
- [ ] Try updating with invalid URL
  - Should stay on edit form with error
- [ ] Try updating with invalid description
  - Should show appropriate validation error
- [ ] Click "Cancel" button
  - Should return to tracker detail page without saving

---

### 7. Delete Tracker ✓

- [ ] Click "Delete" button on tracker card
- [ ] Should show JavaScript confirmation dialog "Are you sure?"
- [ ] Click "OK" to confirm
- [ ] Should be redirected to trackers list
- [ ] Should see success message "Tracker was successfully deleted"
- [ ] Tracker should no longer appear in list
- [ ] Can also delete from tracker detail page

---

### 8. Authorization & Security ✓

**User Isolation:**
- [ ] Create two user accounts (User A and User B)
- [ ] Sign in as User A
- [ ] Create some trackers
- [ ] Sign out
- [ ] Sign in as User B
- [ ] Visit "My Trackers"
- [ ] Should NOT see User A's trackers
- [ ] User B should only see their own trackers

**Direct URL Access (Security Test):**
- [ ] Sign in as User A
- [ ] Note the ID of one of User A's trackers (e.g., tracker/5)
- [ ] Sign out
- [ ] Sign in as User B
- [ ] Try accessing User A's tracker directly: `http://localhost:3000/trackers/5`
- [ ] Should see error page or be redirected (NOT see User A's tracker)
- [ ] Try editing User A's tracker: `http://localhost:3000/trackers/5/edit`
- [ ] Should NOT be able to access it

---

### 9. Navigation & UI ✓

**Navbar (Signed Out):**
- [ ] Shows TRAKBOT logo linking to home
- [ ] Shows "Sign In" link
- [ ] Shows "Sign Up" button (primary styling)

**Navbar (Signed In):**
- [ ] Shows TRAKBOT logo linking to home
- [ ] Shows "Home" link
- [ ] Shows "My Trackers" link
- [ ] Shows "New Tracker" button (primary styling)
- [ ] Shows user dropdown with:
  - Email address as label
  - "Profile" link (goes to Devise edit profile)
  - "Log out" link (red text)

**Responsive Design:**
- [ ] Resize browser to mobile width (<768px)
- [ ] Navbar should collapse to hamburger menu
- [ ] Home page should stack vertically
- [ ] Tracker cards should display one per row
- [ ] All buttons should be finger-friendly
- [ ] Forms should be readable on mobile

---

### 10. Flash Messages ✓

Test that appropriate messages appear for:
- [ ] Successful sign in
- [ ] Successful sign out
- [ ] Tracker created successfully
- [ ] Tracker updated successfully
- [ ] Tracker deleted successfully
- [ ] Validation errors appear inline on forms

---

### 11. Links & External Navigation ✓

- [ ] Tracker list: Click URL in card → Opens in new tab
- [ ] Tracker detail: Click URL → Opens in new tab
- [ ] External link icon appears next to URLs
- [ ] Profile link in dropdown → Goes to Devise profile edit
- [ ] All "Back" buttons work correctly

---

### 12. Edge Cases ✓

**Long URLs:**
- [ ] Create tracker with very long URL (200+ characters)
- [ ] Should be accepted and stored
- [ ] Should be truncated with ellipsis in list view
- [ ] Should display fully in detail view

**Special Characters in Description:**
- [ ] Create tracker with description containing: "Tracking <Product> & "Sales""
- [ ] Should be properly escaped and displayed

**Many Trackers:**
- [ ] Create 10+ trackers
- [ ] List view should display all in grid
- [ ] Should load reasonably fast
- [ ] Scrolling should work

**Keywords:**
- [ ] Create tracker with comma-separated keywords: "price, stock, discount"
- [ ] Should display as single badge
- [ ] Create tracker without keywords
- [ ] Keywords section should not appear

---

## Test Results Summary

### Automated Tests
- **Total Tests:** 33
- **Assertions:** 76
- **Failures:** 0
- **Errors:** 0
- **Status:** ✅ ALL PASSING

### Manual Testing
- [ ] Complete all checklist items above
- [ ] Document any issues found
- [ ] Verify all features work as expected

---

## Known Limitations (Phase 1)

These are expected and will be addressed in future phases:

1. **No actual tracking** - Trackers are stored but not checked for changes
2. **No notifications** - No email or in-app alerts yet
3. **No change history** - No snapshots or diff tracking
4. **No pause/resume** - Can't temporarily disable a tracker
5. **No categories/tags** - Can't organize trackers into groups
6. **No search/filter** - Can't filter tracker list
7. **No pagination** - All trackers load at once
8. **No charts/trends** - No visual representation of changes

---

## Performance Benchmarks

Run these to establish baseline performance:

```bash
# Run all tests
time rails test

# Expected: < 2 seconds
```

---

## How to Run Automated Tests

```bash
# Run all tests
rails test

# Run specific test file
rails test test/models/tracker_test.rb

# Run specific test
rails test test/models/tracker_test.rb:4

# Run with verbose output
rails test -v

# Run and see test coverage (future: add SimpleCov)
# Coming in Phase 6
```

---

## Bug Reporting

If you find issues during testing:

1. Note the exact steps to reproduce
2. Note expected vs actual behavior
3. Check browser console for errors (F12)
4. Check Rails server logs
5. Create an issue or fix immediately

---

**Last Updated:** Phase 1 Complete - November 2025
