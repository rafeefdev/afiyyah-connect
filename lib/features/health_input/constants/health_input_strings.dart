/// A class containing all the strings used in the Health Input feature.
/// This class is not meant to be instantiated.
class HealthInputStrings {
  // Private constructor to prevent instantiation.
  HealthInputStrings._();

  // --- General & Navigation Buttons ---
  static const String next = 'Lanjut';
  static const String back = 'Kembali';
  static const String previous = 'Sebelumnya';
  static const String cancel = 'Batal';
  static const String adding = 'Tambahkan';
  static const String add = 'Tambah';
  static const String check = 'Cek';

  // --- Step 1: Search Santri ---
  static const String step1Title = 'Cari Santri';
  static const String searchHint = 'Ketik untuk mencari nama santri';
  static const String searchLabel = 'Nama Santri';
  static const String searchPrompt =
      'Ketik nama santri untuk memulai pencarian';
  static const String searching = 'Sedang mencari data...';
  static const String notFound = 'Santri tidak ditemukan.';
  static const String noHujrohData = 'Belum ada data hujroh';
  static const String genericError = 'Terjadi kesalahan';

  // --- Step 2: Select Santri ---
  static const String step2Title = 'Pilih Santri';
  static const String notSelected = 'Santri belum dipilih.';
  static const String backToSearch = 'Kembali ke pencarian';
  static const String classLabel = 'Kelas ';
  static const String yearLabel = 'Tahun ke-';
  static const String notAvailable = 'N/A';

  // --- Step 3: Complaints ---
  static const String step3Title = 'Apa Saja yang Dikeluhkan ?';
  static const String otherComplaintHint = 'Masukkan keluhan lain';
  static const String otherComplaintLabel = 'lainnya ...';
  static const List<String> complaintListDefault = [
    'Batuk',
    'Pusing',
    'Demam / Panas',
    'Pilek',
    'Masuk Angin',
    'Maag / Asam Lambung',
  ];
  static const emptyComplianceMessage = '* Daftar keluhan tidak boleh kosong';

  // --- Step 4: Since When ---
  static const String step4Title = 'Sejak Kapan dia Sakit ?';
  static const String dateHint = 'Pilih Tanggal';
  static const String timeHint = 'Pilih Jam';
  static const String emptyTimeInfoMessage = '* Ket. waktu tidak boleh kosong';

  // --- Step 5: Clinic Check ---
  static const String step5Title = 'Periksa Klinik ?';
  static const String clinicStatusSudah = 'Sudah';
  static const String clinicStatusBelum = 'Belum';
  static const String clinicStatusLuar = 'Di Luar';

  // --- Confirmation & Error Dialogs ---
  static const String confirmationUnfilled = 'Belum diisi';
  static const String confirmationSantriNotFoundTitle =
      'Data santri belum ditemukan';
  static const String confirmationSantriNotFoundBody =
      'Mungkin terjadi karena koneksi internet buruk. Hubungi tim pengembang untuk melaporkan bug ini';
}
