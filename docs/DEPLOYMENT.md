# Deployment

This document outlines the process for building and deploying the application for production environments.

## Build Process for Production

Before building, ensure your `.env` file is correctly configured with production Supabase keys.

### Android (APK)

1.  **Clean the project:**
    ```bash
    flutter clean
    ```
2.  **Get dependencies:**
    ```bash
    flutter pub get
    ```
3.  **Build the APK:**
    ```bash
    flutter build apk --release
    ```
    The output file will be located at `build/app/outputs/flutter-apk/app-release.apk`.

### Android (App Bundle)

1.  **Clean the project:**
    ```bash
    flutter clean
    ```
2.  **Get dependencies:**
    ```bash
    flutter pub get
    ```
3.  **Build the App Bundle:**
    ```bash
    flutter build appbundle --release
    ```
    The output file will be located at `build/app/outputs/bundle/release/app-release.aab`. This is the recommended format for publishing to the Google Play Store.

### iOS

1.  **Clean the project:**
    ```bash
    flutter clean
    ```
2.  **Get dependencies:**
    ```bash
    flutter pub get
    ```
3.  **Build the iOS archive:**
    ```bash
    flutter build ipa --release
    ```
4.  Open the project in Xcode to manage signing and distribution to the App Store:
    ```bash
    open ios/Runner.xcworkspace
    ```

## Supabase Deployment Steps

Deploying backend changes involves using the Supabase CLI. Ensure you are logged in (`supabase login`) and have linked the project (`supabase link --project-ref <your-project-ref>`).

### Database Migrations

1.  **Create a new migration file** for any schema changes you've made locally:
    ```bash
    supabase migration new <migration_name>
    ```
    This will create a new file in `supabase/migrations`. Edit this file to define your SQL changes (e.g., `CREATE TABLE`, `ALTER TABLE`).

2.  **Deploy database changes** to the linked Supabase project:
    ```bash
    supabase db push
    ```

### Edge Functions

1.  **Deploy all Edge Functions** in your `supabase/functions` directory:
    ```bash
    supabase functions deploy --project-ref <your-project-ref>
    ```
    To deploy a specific function, use its name:
    ```bash
    supabase functions deploy <function_name> --project-ref <your-project-ref>
    ```

## CI/CD Pipeline

The project does not have a CI/CD pipeline yet. This section will be updated once a pipeline is configured (e.g., using GitHub Actions).

## Environment Variables Management

The project uses a `.env` file to manage environment variables for local development. For production builds, these variables should be passed securely during the CI/CD process.

**Local `.env` file:**
```
SUPABASE_URL=YOUR_SUPABASE_URL
SUPABASE_ANON_KEY=YOUR_SUPABASE_ANON_KEY
```
**DO NOT** commit the `.env` file to version control.