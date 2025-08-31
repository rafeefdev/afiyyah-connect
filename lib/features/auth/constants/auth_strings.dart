class AuthStrings {
  AuthStrings._();

  // General
  static const String login = 'Login';
  static const String register = 'Daftar';
  static const String emailLabel = 'Email Anda';
  static const String passwordLabel = 'Kata Sandi';

  // Auth Page
  static const String otpInstruction = 'Masukkan email terdaftar untuk mendapatkan kode OTP';
  static const String unregisteredEmailNotice =
      'Email Anda belum terdaftar?\nhubungi dan daftarkan email ke Tim Kesehatan Kesantrian Putra';
  static const String sendOtpButton = 'Kirim Kode OTP';

  // Validation
  static const String emailEmptyValidationError = 'Email tidak boleh kosong';
  static const String emailInvalidFormatValidationError = 'Masukkan format email yang valid';
}