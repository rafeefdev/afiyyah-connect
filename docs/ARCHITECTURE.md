# Architecture

## High-Level System Architecture
The project uses a feature-based architecture, which helps in separating concerns and improving scalability. It leverages Riverpod for state management and Supabase for the backend, including authentication, database, and edge functions.

## Folder Structure
- `lib/app`: Contains the core application logic, shared across features.
  - `core/model`: Defines core data models like `UserModel`.
  - `core/services`: Includes services like `SupabaseService` and `LoggerService`.
  - `themes`: Holds the application's visual theme, including colors, typography, and spacing.
- `lib/features`: Each sub-directory represents a feature of the application (e.g., `auth`, `dashboard`, `profile`). This modular structure allows developers to work on features in isolation.
  - `model`: Feature-specific data models.
  - `repository`: Handles data operations, communicating with services or APIs.
  - `view`: Contains the UI (widgets and screens).
  - `viewmodel` or `provider`: Manages the state for the views.

## Design Patterns
The project primarily follows the **MVVM (Model-View-ViewModel)** pattern, adapted for Flutter and Riverpod.
- **Model**: Represents the data structures (e.g., `UserModel`).
- **View**: The UI components (e.g., `LoginScreen`, `DashboardPage`). They are responsible for displaying data and capturing user input.
- **ViewModel**: Implemented using Riverpod `Providers`. They hold the business logic, manage state, and expose it to the View. For example, `AuthRepository` acts as part of the ViewModel layer.

## State Management Flow
The project uses **Riverpod** for dependency injection and state management.

1.  **Provider Declaration**: Providers are declared using the `@riverpod` annotation, which generates the necessary provider code (`.g.dart` files).
    - `authRepositoryProvider`: Provides a singleton instance of `AuthRepository`.
    - `authStateChangesProvider`: A stream provider that notifies the app of authentication state changes (login/logout).

2.  **Accessing State**: Widgets use `ref.watch` to listen to a provider's state. When the state changes, the widget automatically rebuilds.
    ```dart
    // Example in a widget
    final authState = ref.watch(authStateChangesProvider);
    ```

3.  **Modifying State**: User actions in the View trigger methods in the ViewModel (e.g., `AuthRepository`). These methods perform business logic (like calling Supabase) and update the state, causing the UI to refresh.

## Database Schema
The project uses a Supabase PostgreSQL database. Key tables include:

### `profiles`
Stores public user profile information. A new entry is created for each user upon registration.
- `id` (uuid, primary key): Foreign key to `auth.users.id`.
- `full_name` (text): The user's full name.
- `email` (text): The user's email address.
- `role` (enum): The user's role in the application (e.g., `asatidzPiketMaskan`, `resepsionisKlinik`).

### `allowed_emails`
This table is used to control which users can create an account.
- `id` (uuid, primary key): A unique identifier for the record.
- `email` (text, unique): The email address that is allowed to register.

*Other tables for features like `health_input`, `monitoring`, etc., will be documented as they are stabilized.*
