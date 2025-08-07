// Enum untuk merepresentasikan role pengguna dalam aplikasi.
// Nama-nama ini harus cocok dengan nilai enum di database Supabase.
enum Role {
  asatidzPiketMaskan,
  resepsionisKlinik,
  dokter,
  unknown // Role default jika terjadi kesalahan parsing
}

// Model untuk merepresentasikan data pengguna yang sudah diautentikasi.
class UserModel {
  final String id;
  final String name;
  final Role role;

  UserModel({required this.id, required this.name, required this.role});

  // Factory constructor untuk membuat instance UserModel dari JSON (Map).
  // Ini digunakan untuk mengubah data yang diterima dari Supabase menjadi objek Dart.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['full_name'] as String? ?? 'Tanpa Nama', // Fallback jika nama null
      role: _parseRole(json['role'] as String?), // Memanggil fungsi parsing role
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
