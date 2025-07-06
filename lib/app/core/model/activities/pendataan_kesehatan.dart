class PendataanKesehatan {
  final String id;
  final DateTime timeStamp;
  final String santriId;
  final List<String> keluhan;
  final DateTime sickStartTime;

  PendataanKesehatan({
    required this.id,
    required this.santriId,
    required this.keluhan,
    required this.sickStartTime,
  }) : timeStamp = DateTime.timestamp();
}
