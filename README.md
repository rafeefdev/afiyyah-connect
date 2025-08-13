# Afiyyah Connect

Afiyyah Connect is an integrated information system between the student affairs and the clinic at Ibnu Abbas Klaten to streamline data collection, storage, and real-time access to historical data, replacing the manual process.

## Quick Start Guide

### Prerequisites
- Flutter SDK
- Supabase CLI

### Setup Instructions
1. Clone the repository.
2. Install dependencies: `flutter pub get`
3. Create a `.env` file in the root directory and add the following:
   ```
   SUPABASE_URL=YOUR_SUPABASE_URL
   SUPABASE_ANON_KEY=YOUR_SUPABASE_ANON_KEY
   ```
4. Run the app: `flutter run`

## Features
- **Authentication:** Users can log in with their email and a one-time password (OTP).
- **Dashboard:** The dashboard displays an overview of the students' health, including statistics and charts.
- **Health Input:** Users can input health data for students.
- **Monitoring:** Users can monitor the health of students.
- **Medical History:** Users can view the medical history of students.
- **Profile:** Users can view and edit their profile.

## Architecture Overview

- **High-level system architecture:** The project uses a feature-based architecture with Riverpod for state management and Supabase for the backend.
- **Folder structure:**
  - `lib/app`: Contains the core application logic, such as themes, models, and services.
  - `lib/features`: Contains the different features of the application, such as `auth`, `dashboard`, `profile`, etc.
- **Design patterns:** The project uses the MVVM (Model-View-ViewModel) pattern.
- **Data flow:** Data flows from the UI to the ViewModel, which then interacts with the services to fetch data from Supabase.

## Development Guide

- **Code style:** The project follows the default Flutter linting rules.
- **Naming conventions:** The project follows the standard Dart naming conventions.
- **Git workflow:** The project uses the standard Gitflow workflow.
- **Testing strategy:** The project uses widget testing to test the UI components.
