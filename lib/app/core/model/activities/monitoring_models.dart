class PendataanWithSantri {
  final String pendataanId;
  final DateTime? createdAt;
  final List<String> keluhan;
  final DateTime? mulaiSakit;
  final String statusPeriksa;
  final String? waktuMulaiSakit;
  final String santuarioId;
  final String? namaSantri;
  final String? namaHujroh;
  final int? nomorHujroh;
  final int? jenjang;

  PendataanWithSantri({
    required this.pendataanId,
    this.createdAt,
    required this.keluhan,
    this.mulaiSakit,
    required this.statusPeriksa,
    this.waktuMulaiSakit,
    required this.santuarioId,
    this.namaSantri,
    this.namaHujroh,
    this.nomorHujroh,
    this.jenjang,
  });

  factory PendataanWithSantri.fromJson(Map<String, dynamic> json) {
    return PendataanWithSantri(
      pendataanId: json['pendataan_id'] as String? ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      keluhan:
          (json['keluhan'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      mulaiSakit: json['mulai_sakit'] != null
          ? DateTime.parse(json['mulai_sakit'] as String)
          : null,
      statusPeriksa: json['status_periksa'] as String? ?? 'belum',
      waktuMulaiSakit: json['waktu_mulai_sakit'] as String?,
      santuarioId: json['santri_id'] as String? ?? '',
      namaSantri: json['nama_santri'] as String?,
      namaHujroh: json['nama_hujroh'] as String?,
      nomorHujroh: json['nomor_hujroh'] as int?,
      jenjang: json['jenjang'] as int?,
    );
  }
}

class RujukanBelumDitindaklanjuti {
  final int id;
  final String? santuarioId;
  final String? namaSantri;
  final String? namaHujroh;
  final int? jenjang;
  final DateTime? tanggal;
  final String? rumahSakit;
  final String? catatan;
  final bool belumDiantar;

  RujukanBelumDitindaklanjuti({
    required this.id,
    this.santuarioId,
    this.namaSantri,
    this.namaHujroh,
    this.jenjang,
    this.tanggal,
    this.rumahSakit,
    this.catatan,
    required this.belumDiantar,
  });

  factory RujukanBelumDitindaklanjuti.fromJson(Map<String, dynamic> json) {
    return RujukanBelumDitindaklanjuti(
      id: json['id'] as int? ?? 0,
      santuarioId: json['santri_id'] as String?,
      namaSantri: json['nama_santri'] as String?,
      namaHujroh: json['nama_hujroh'] as String?,
      jenjang: json['jenjang'] as int?,
      tanggal: json['tanggal'] != null
          ? DateTime.parse(json['tanggal'] as String)
          : null,
      rumahSakit: json['rumah_sakit'] as String?,
      catatan: json['catatan'] as String?,
      belumDiantar: json['belum_diantar'] as bool? ?? true,
    );
  }
}

class KunjunganWithSantri {
  final int idKunjungan;
  final String? santuarioId;
  final String? namaSantri;
  final String? namaHujroh;
  final int? jenjang;
  final DateTime? waktuMasuk;
  final String? sumberKunjungan;
  final String? statusPengarahan;
  final DateTime? tanggalMulaiIstirahat;
  final DateTime? tanggalSelesaiIstirahat;
  final String? catatanKlinik;
  final List<String>? keluhan;
  final String? statusPeriksa;
  final bool belumDiperiksa;

  KunjunganWithSantri({
    required this.idKunjungan,
    this.santuarioId,
    this.namaSantri,
    this.namaHujroh,
    this.jenjang,
    this.waktuMasuk,
    this.sumberKunjungan,
    this.statusPengarahan,
    this.tanggalMulaiIstirahat,
    this.tanggalSelesaiIstirahat,
    this.catatanKlinik,
    this.keluhan,
    this.statusPeriksa,
    required this.belumDiperiksa,
  });

  factory KunjunganWithSantri.fromJson(Map<String, dynamic> json) {
    return KunjunganWithSantri(
      idKunjungan: json['id_kunjungan'] as int? ?? 0,
      santuarioId: json['id_siswa'] as String?,
      namaSantri: json['nama_santri'] as String?,
      namaHujroh: json['nama_hujroh'] as String?,
      jenjang: json['jenjang'] as int?,
      waktuMasuk: json['waktu_masuk'] != null
          ? DateTime.parse(json['waktu_masuk'] as String)
          : null,
      sumberKunjungan: json['sumber_kunjungan'] as String?,
      statusPengarahan: json['status_pengarahan'] as String?,
      tanggalMulaiIstirahat: json['tanggal_mulai_istirahat'] != null
          ? DateTime.parse(json['tanggal_mulai_istirahat'] as String)
          : null,
      tanggalSelesaiIstirahat: json['tanggal_selesai_istirahat'] != null
          ? DateTime.parse(json['tanggal_selesai_istirahat'] as String)
          : null,
      catatanKlinik: json['catatan_klinik'] as String?,
      keluhan: (json['keluhan'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      statusPeriksa: json['status_periksa'] as String?,
      belumDiperiksa: json['belum_adapun_periksa'] as bool? ?? true,
    );
  }
}
