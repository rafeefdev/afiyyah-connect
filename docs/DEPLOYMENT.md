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