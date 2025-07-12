String getInitials(String inputString) {
  if (inputString.isEmpty) {
    return ''; // Mengembalikan string kosong jika inputnya kosong
  }

  List<String> words = inputString.split(
    ' ',
  ); // Memisahkan string berdasarkan spasi
  String initials = '';

  for (String word in words) {
    if (word.isNotEmpty) {
      initials += word[0]
          .toUpperCase(); // Mengambil huruf pertama dan mengubahnya menjadi huruf kapital
    }
  }

  return initials;
}
