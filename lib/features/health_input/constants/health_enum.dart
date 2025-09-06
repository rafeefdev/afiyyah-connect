enum PeriksaKlinikStatus {
  belumDiperiksa('Belum Diperiksa'),
  sedangDiperiksa('Sedang Diperiksa'),
  sudahDiperiksa('Sudah Diperiksa'),
  selesai('Selesai');

  const PeriksaKlinikStatus(this.value);
  final String value;
}
