# TRAKBOT

**Track Changes. Stay Informed.**

A Rails 7.1 web application that monitors website changes including price drops, content updates, and availability changes. Get notified when something important changes on your tracked websites.

---

## Project Status

Currently in active development following an 8-phase roadmap to production deployment.

### Phase 1: Core CRUD Functionality ✅ COMPLETED
- [x] Full RESTful tracker management (create, read, update, delete)
- [x] User authentication with Devise
- [x] Tracker model with validations
- [x] Bootstrap 5 responsive UI
- [x] User-scoped tracker management
- [x] Home page with feature showcase
- [x] Navigation and user dropdown

### Phase 2: Web Scraping Engine 🚧 NEXT
- [ ] HTTP client for fetching web pages
- [ ] HTML parsing with Nokogiri
- [ ] Content extraction service
- [ ] Snapshot model for storing historical data
- [ ] Error handling for failed requests

### Phase 3: Background Jobs & Scheduling
- [ ] Sidekiq/Solid Queue setup
- [ ] Periodic tracker checking
- [ ] Change detection algorithm
- [ ] Job monitoring

### Phase 4: Notifications
- [ ] Email notifications for changes
- [ ] In-app notification system
- [ ] Notification preferences

### Phase 5: Polish & UX
- [ ] Dashboard with visual indicators
- [ ] Pause/resume tracking
- [ ] Tracker categorization
- [ ] Charts and trends

### Phase 6: Testing & Quality
- [ ] Model, controller, and system tests
- [ ] Security audit
- [ ] Authorization with Pundit
- [ ] Rate limiting

### Phase 7: Production Readiness
- [ ] Environment configuration
- [ ] Error monitoring (Sentry/Rollbar)
- [ ] Performance optimization
- [ ] Documentation

### Phase 8: Deployment
- [ ] Platform selection (Heroku/Fly.io/Railway/Render)
- [ ] Production database setup
- [ ] Redis configuration
- [ ] Monitoring and alerts

---

## Tech Stack

### Core Framework
- **Ruby**: 3.3.5
- **Rails**: 7.1.5.1
- **Database**: PostgreSQL

### Frontend
- **CSS Framework**: Bootstrap 5.2
- **Icons**: Font Awesome 6.1
- **JavaScript**: Stimulus JS + Turbo (Hotwired)
- **Forms**: Simple Form

### Authentication
- **Devise**: User authentication and session management

### Deployment
- **Docker**: Multi-stage production-ready Dockerfile
- **Web Server**: Puma

### Planned Additions
- HTTParty/Faraday (HTTP requests)
- Nokogiri (HTML parsing)
- Sidekiq + Redis (background jobs)
- Pundit (authorization)
- Rollbar (error tracking)
- Chartkick (data visualization)

---

## Database Schema

### Users
```ruby
- email (string, unique, required)
- encrypted_password (string, required)
- first_name (string)
- last_name (string)
- reset_password_token (string, unique)
- reset_password_sent_at (datetime)
- remember_created_at (datetime)
```

### Trackers
```ruby
- user_id (bigint, foreign key, required)
- link (string, required) - URL to track
- description (string, required, 3-500 chars) - What you're tracking
- keywords (string, optional) - Keywords to focus on
- created_at (datetime)
- updated_at (datetime)
```

**Relationships:**
- User `has_many` Trackers (dependent: :destroy)
- Tracker `belongs_to` User

---

## Getting Started

### Prerequisites
- Ruby 3.3.5
- PostgreSQL
- Node.js (for asset compilation)

### Setup

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd trakbot
   ```

2. **Install dependencies**
   ```bash
   bundle install
   ```

3. **Setup database**
   ```bash
   rails db:create
   rails db:migrate
   ```

4. **Start the server**
   ```bash
   rails server
   ```

5. **Visit the application**
   Open [http://localhost:3000](http://localhost:3000)

### Docker Setup

```bash
docker build -t trakbot .
docker run -p 3000:3000 -e RAILS_ENV=production trakbot
```

---

## Features (Phase 1)

### User Management
- Sign up with email and password
- Sign in / Sign out
- Password reset functionality
- Profile editing

### Tracker Management
- **Create Trackers**: Add URLs to monitor with descriptions and optional keywords
- **View Trackers**: Browse all your trackers in a card-based grid layout
- **Edit Trackers**: Update tracker details anytime
- **Delete Trackers**: Remove trackers you no longer need
- **Validation**: Ensures valid URLs and proper descriptions

### UI/UX
- Responsive Bootstrap 5 design
- Mobile-friendly navigation
- Flash messages for user feedback
- Empty state messaging
- Intuitive forms with helpful hints

---

## Usage

### Creating Your First Tracker

1. Sign up for an account or sign in
2. Click "New Tracker" in the navbar or "Add New Tracker" button
3. Enter the URL you want to track (e.g., `https://www.udemy.com/course/python-bootcamp/`)
4. Add a description (e.g., "Python Course on Udemy")
5. Optionally add keywords to focus on (e.g., "price")
6. Click "Create Tracker"

### Managing Trackers

- **View All**: Navigate to "My Trackers" to see all your tracked URLs
- **View Details**: Click "View" on any tracker card
- **Edit**: Click "Edit" to update the URL, description, or keywords
- **Delete**: Click "Delete" and confirm to remove a tracker

---

## Project Structure

```
app/
├── controllers/
│   ├── application_controller.rb    # Global authentication requirement
│   ├── pages_controller.rb          # Home page
│   └── trackers_controller.rb       # Tracker CRUD operations
├── models/
│   ├── user.rb                      # User authentication + tracker association
│   └── tracker.rb                   # Tracker validations + user association
├── views/
│   ├── trackers/
│   │   ├── index.html.erb           # Tracker list
│   │   ├── show.html.erb            # Tracker details
│   │   ├── new.html.erb             # New tracker form
│   │   ├── edit.html.erb            # Edit tracker form
│   │   └── _form.html.erb           # Form partial
│   ├── pages/
│   │   └── home.html.erb            # Landing page
│   └── shared/
│       ├── _navbar.html.erb         # Navigation bar
│       └── _flashes.html.erb        # Flash messages
config/
├── routes.rb                        # RESTful routes
└── database.yml                     # PostgreSQL configuration
```

---

## Development Roadmap Timeline

- **Phase 1** (Week 1): ✅ Core CRUD - COMPLETED
- **Phase 2** (Week 2): Web Scraping Engine
- **Phase 3** (Week 3): Background Jobs & Scheduling
- **Phase 4** (Week 4): Notifications
- **Phase 5** (Week 5): Polish & UX
- **Phase 6** (Week 6): Testing & Quality
- **Phase 7** (Week 7): Production Readiness
- **Phase 8** (Week 8): Deployment

**Estimated Time to Production:** 8-10 weeks

---

## Testing

Currently using Rails Test::Unit framework with Capybara for system tests.

**Run tests:**
```bash
rails test
```

*Note: Comprehensive test implementation was completed in Phase 1. Further quality enhancements are planned for Phase 6.*

---

## Contributing

This is a personal project currently in active development. Contributions, ideas, and feedback are welcome!

---

## Security Considerations

### Implemented
- CSRF protection (Rails default)
- Strong parameters in controllers
- Password encryption (Devise bcrypt)
- SQL injection prevention (ActiveRecord)
- User-scoped queries (authorization at model level)

### Planned
- Pundit authorization policies (Phase 6)
- Rate limiting for web scraping (Phase 2)
- Environment variable management for secrets (Phase 7)
- Security headers and CSP (Phase 7)

---

## License

This project is built for educational and personal use.

---

## Acknowledgments

- Initial Rails template from [Le Wagon](https://github.com/lewagon/rails-templates)
- Built with Claude Code AI assistant

---

## Contact

For questions or suggestions, please open an issue in the repository.

---

**Last Updated:** November 2025 - Phase 1 Complete
