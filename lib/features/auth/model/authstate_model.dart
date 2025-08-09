enum AuthStatus { idle, loading, success, error, otpSent }

class AuthState {
  final AuthStatus status;
  final String? message;

  AuthState(this.status, [this.message]);
}
