# Afiyyah Connect 🏥

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Supabase](https://img.shields.io/badge/Supabase-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white)](https://supabase.io)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

> A modern healthcare management system for Islamic boarding schools, built with Flutter and Supabase.

## 🎯 What This Solves

Islamic boarding schools (pesantren) face unique challenges managing student health across multiple stakeholders - dormitory staff, clinic, teachers, and Quran instructors. This system replaces manual paper-based processes with real-time digital coordination.

**Key Problems Addressed:**
- Manual health records scattered across WhatsApp groups and paper forms
- No visibility into student health status for teachers during classes
- Inefficient coordination for medical referrals and transportation
- Lost medical history and poor continuity of care

## ✨ Features

### Core Functionality
- **Smart Health Entry** - Auto-complete student info, quick symptom logging
- **Real-time Dashboard** - Live health status across dormitories
- **Medical History** - Complete timeline of student health records
- **Multi-role Access** - Different views for staff, teachers, clinic, administrators
- **Referral Management** - Track external clinic visits and transportation

### Technical Highlights
- **Offline-first** architecture with sync when online
- **Role-based permissions** using Supabase RLS
- **Real-time updates** across all connected devices
- **WhatsApp notifications** for critical health alerts
- **Progressive Web App** + native mobile support

## 🛠️ Tech Stack

- **Frontend**: Flutter (cross-platform mobile + web)
- **Backend**: Supabase (PostgreSQL + real-time + auth)
- **State Management**: Riverpod
- **Architecture**: MVVM
- **Integrations**: Google OAuth, WhatsApp API, Google Drive

## 🚀 Quick Start

### Prerequisites
- Flutter SDK ≥ 3.16.0
- A Supabase project
- Google OAuth credentials (optional)

### Setup

```bash
# Clone and setup
git clone https://github.com/yourusername/afiyyah-connect.git
cd afiyyah-connect
flutter pub get

# Configure environment
cp .env.example .env
# Edit .env with your Supabase credentials

# Run database migrations
supabase db reset  # or import schema manually

# Start development
flutter run
```

### Environment Variables
```env
SUPABASE_URL=your_supabase_project_url
SUPABASE_ANON_KEY=your_supabase_anon_key
GOOGLE_CLIENT_ID=your_google_oauth_id  # optional
WHATSAPP_ACCESS_TOKEN=your_whatsapp_token  # optional
```

## 🏗️ Architecture

The app follows Clean Architecture principles with clear separation of concerns:

```
lib/
├── core/           # Shared utilities, constants, themes
├── feature/         # Data sources, repositories implementation
└── main.dart
```

### Key Design Decisions
- **Offline-first**: All critical operations work without internet
- **Real-time sync**: Automatic synchronization when connection available
- **Role-based UI**: Different interfaces based on user permissions
- **Modular architecture**: Easy to extend with new features

## 📱 User Flows

### Dormitory Staff
1. Open app → See today's health dashboard
2. Tap "Add Health Record" → Search student name
3. Auto-filled room/class → Enter symptoms/condition
4. Submit → Real-time sync to all stakeholders

### Teachers/Instructors
1. Open app → Check class health status
2. See which students are sick/absent
3. Verify legitimacy of health-related absences
4. Access detailed health info if needed

### Clinic Staff
1. Receive real-time notifications of new patients
2. Access complete medical history
3. Add diagnosis and treatment notes
4. Coordinate referrals and transportation

## 🔒 Security & Privacy

- **Row Level Security**: Database-level access control
- **Role-based permissions**: Users only see relevant data
- **Data encryption**: Sensitive health data encrypted at rest
- **Audit logging**: All actions tracked for accountability
- **HIPAA considerations**: Health data handling best practices

## 🧪 Testing

```bash
# Run all tests
flutter test

# Integration tests
flutter test integration_test/

# Generate coverage
flutter test --coverage
```

Current coverage: ~85% (aiming for 90%+)

## 🤝 Contributing

This project is open for contributions! Whether you're interested in:
- **Flutter development** - UI improvements, new features
- **Backend optimization** - Database queries, performance
- **Healthcare domain** - Workflow improvements, feature suggestions
- **Testing** - Unit tests, integration tests, user testing
- **Documentation** - Code docs, user guides, translations

### How to Contribute
1. Fork the repo
2. Create a feature branch (`git checkout -b feature/awesome-feature`)
3. Make your changes (follow the existing code style)
4. Write/update tests
5. Commit your changes (`git commit -m 'Add awesome feature'`)
6. Push to the branch (`git push origin feature/awesome-feature`)
7. Open a Pull Request

### Development Guidelines
- Follow Flutter/Dart conventions
- Write meaningful commit messages
- Add tests for new functionality
- Update documentation as needed
- Consider mobile-first design

## 📋 Features Based on Priority

**✅ Must Have:**
- Core health record management
- Multi-role authentication
- Real-time dashboard
- Mobile + web support
- Basic reporting

**🚧 Should Have:**
- WhatsApp integration
- Advanced analytics
- Offline synchronization
- Performance optimization

**📝 Nice to Have:**
- Doctor examination forms
- Automated reporting
- Medical imaging support
- Mobile notifications

## 📄 License

MIT License - feel free to use this in your own projects!

## 🙏 Acknowledgments

Built for and tested with Ibnu Abbas Islamic Boarding School in Klaten, Indonesia. Special thanks to the healthcare staff and administrators who provided invaluable domain expertise.

---

**Questions?** Open an issue or start a discussion. **Want to help?** Check out the contributing guidelines above!

*This project aims to improve healthcare management in Islamic boarding schools through thoughtful technology design.*
