// Enum untuk merepresentasikan role pengguna dalam aplikasi.
// Nama-nama ini harus cocok dengan nilai enum di database Supabase.
enum Role {
  asatidzPiketMaskan,
  resepsionisKlinik,
  dokter,
  unknown;
  // Role default jika terjadi kesalahan parsing

  static String name(Role role) {
    switch (role) {
      case Role.asatidzPiketMaskan:
        return 'Asatidz Piket Maskan';
      case Role.resepsionisKlinik:
        return 'Resepsionis Klinik';
      case Role.dokter:
        return 'Dokter';
      case Role.unknown:
        return 'Unknown';
    }
  }
}

// Model untuk merepresentasikan data pengguna yang sudah diautentikasi.
class UserModel {
  final String id;
  final String fullName;
  final String email;
  final Role role;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
  });

  // Factory constructor untuk membuat instance UserModel dari data profil dan email.
  factory UserModel.fromProfile({
    required Map<String, dynamic> profileJson,
    required String email,
  }) {
    return UserModel(
      id: profileJson['id'] as String,
      fullName: profileJson['full_name'] as String? ?? 'Tanpa Nama',
      email: email,
      role: _parseRole(profileJson['role'] as String?),
    );
  }

  // Fungsi helper untuk mengubah string role dari database menjadi enum Role.
  static Role _parseRole(String? roleString) {
    if (roleString == null) return Role.unknown;
    switch (roleString) {
      case 'asatidzPiketMaskan':
        return Role.asatidzPiketMaskan;
      case 'resepsionisKlinik':
        return Role.resepsionisKlinik;
      case 'dokter':
        return Role.dokter;
      default:
        // Jika nilai dari database tidak cocok dengan enum manapun,
        // kembalikan 'unknown' untuk menghindari error.
        return Role.unknown;
    }
  }
}
