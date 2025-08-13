# Development Setup

## Detailed Environment Setup
1. Install Flutter SDK (latest stable version recommended).
2. Install Supabase CLI: `npm install -g supabase`
3. Clone the repository: `git clone <repository_url>`
4. Navigate to the project directory: `cd afiyyah-connect`
5. Install dependencies: `flutter pub get`
6. Run the code generator: `dart run build_runner build --delete-conflicting-outputs`
7. Create a `.env` file in the root directory by copying `.env.example` (if it exists) and add your Supabase credentials:
   ```
   SUPABASE_URL=YOUR_SUPABASE_URL
   SUPABASE_ANON_KEY=YOUR_SUPABASE_ANON_KEY
   ```
8. Run the app: `flutter run`

## IDE Configuration (VS Code)
It is highly recommended to install the following VS Code extensions for an optimal development experience:
- `Dart`
- `Flutter`
- `Awesome Flutter Snippets`
- `bloc`
- `Error Lens`
- `Riverpod Snippets`

You can also add the following to your `settings.json` to enable format-on-save:
```json
{
  "editor.formatOnSave": true,
  "[dart]": {
    "editor.formatOnSave": true,
    "editor.rulers": [
      80
    ],
    "editor.selectionHighlight": false,
    "editor.suggest.snippetsPreventQuickSuggestions": false,
    "editor.suggestSelection": "first",
    "editor.tabCompletion": "onlySnippets",
    "editor.wordBasedSuggestions": false
  }
}
```

## Debugging Guide

### Flutter Inspector
The Flutter Inspector is a powerful tool for visualizing the widget tree, diagnosing layout issues, and understanding state. You can access it from the DevTools.

### Logging
The app uses the `logging` package. You can view logs in the debug console. For more detailed analysis, use the `LoggerService` which is configured to output logs with different levels (info, fine, severe).

### Riverpod DevTools
To debug state management with Riverpod, you can use the `flutter_riverpod` and `riverpod_lint` packages which are already included. Ensure you are using the Riverpod DevTools extension in VS Code or your IDE to visualize providers and their states.

### Supabase Debugging
You can view API requests and database operations in the Supabase Studio dashboard under the "API" and "Database" sections. For local development with the Supabase CLI, you can view logs from the Docker container.

## Common Troubleshooting

### `build_runner` Fails
If you encounter issues with code generation:
1. **Clean the build cache**: `dart run build_runner clean`
2. **Delete conflicting outputs and rebuild**: `dart run build_runner build --delete-conflicting-outputs`
3. **Check for version conflicts**: Run `flutter pub outdated` to see if any dependencies need updating.

### Platform-Specific Errors (Android/iOS)
1. **Clean the native project**:
   - For Android: `cd android && ./gradlew clean && cd ..`
   - For iOS: `cd ios && xcodebuild clean && cd ..` or `flutter clean`
2. **Update dependencies**: `flutter pub get`
3. **Re-install pods (for iOS)**: `cd ios && pod install && cd ..`

### Supabase Connection Issues
1. **Verify `.env` variables**: Ensure `SUPABASE_URL` and `SUPABASE_ANON_KEY` are correct and have no extra spaces or characters.
2. **Check RLS Policies**: If you are getting permission errors, review the Row Level Security policies on your Supabase tables.
3. **Network Issues**: Ensure your device has a stable internet connection.