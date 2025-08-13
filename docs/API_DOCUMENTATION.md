# API Documentation

This document provides details about the backend API, which is built on Supabase.

## Authentication Flow
The project uses Supabase for authentication with a one-time password (OTP) flow.

1.  **Check Email**: The user enters their email address. The app calls the `is_email_allowed` RPC function to verify if the email is registered in the system.
2.  **Send OTP**: If the email is allowed, the app calls the `signInWithOtp` method from the Supabase Auth client, which sends an OTP to the user's email.
3.  **Verify OTP**: The user enters the received OTP. The app then calls `verifyOTP` to validate it.
4.  **Sign In**: If the OTP is correct, the user is successfully signed in and a session is created.

## RPC Functions
The project utilizes the following RPC (Remote Procedure Call) functions in Supabase.

### `is_email_allowed`
- **Description**: Checks if a given email address is present in the `allowed_emails` table, which determines if a user is permitted to sign up or log in.
- **Parameters**:
  - `input_email` (text): The email address to check.
- **Returns**: `boolean` - `true` if the email is allowed, otherwise `false`.
- **Usage**: Called before the `sendOtp` method to prevent sending OTPs to unauthorized emails.

### `update_user_name`
- **Description**: Updates the `name` field in the user's `profiles` record. This function is called from the user's profile page.
- **Parameters**:
  - `new_name` (text): The new name to be set for the user.
- **Returns**: `void`
- **Security**: This function uses `auth.uid()` internally to ensure users can only update their own profile.

## Triggers
The project uses Supabase for the backend. The triggers are not yet documented. This section will be updated with details about database triggers, such as automatically creating a user profile upon sign-up.

## Real-time Subscriptions Setup
The project uses Supabase for real-time subscriptions. The real-time subscriptions setup is not yet documented. This section will be updated with details on how the app subscribes to database changes (e.g., for live monitoring updates).
