enum Role { asatidzPiketMaskan, resepsionisKlinik, dokter }

class User {
  final String id;
  final String name;
  final Role role;

  User({required this.id, required this.name, required this.role});
}
