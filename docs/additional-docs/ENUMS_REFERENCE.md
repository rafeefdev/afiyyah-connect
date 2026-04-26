# Enums Reference

All enum values used in the database.

---

## role (User Roles)

| Value | Description |
|-------|-------------|
| `asatidzPiketMaskan` | Petugas piket asrama (dormitory duty officer) |
| `resepsionisKlinik` | Klinik resepsionis (clinic receptionist) |
| `dokter` | Dokter (doctor) |

**Table:** `profiles.role`

---

## Periksa Klinik (Examination Status)

| Value | Description |
|-------|-------------|
| `sudah` | Sudah diperiksa (already examined) |
| `belum` | Belum diperiksa (not yet examined) |
| `di luar` | Di luar (examined elsewhere/external) |

**Table:** `pendataan_kesehatan.status_periksa`

---

## Jenis Petugas (Staff Type)

| Value | Description |
|-------|-------------|
| `piket_asrama` | Petugas piket asrama |
| `resepsionis_klinik` | Resepsionis klinik |

**Table:** `petugas.jenis_petugas`

---

## Jenis Kepemilikan Kendaraan

| Value | Description |
|-------|-------------|
| `pribadi` | Kendaraan pribadi |
| `sekolah` | Kendaraan sekolah |

**Table:** `kendaraan.jenis_kepemilikan`

---

## Sumber Pengantaran

| Value | Description |
|-------|-------------|
| `sekolah` | Biaya dari sekolah |
| `pengantar` | Biaya dari pengantar (wali kamar/petugas) |
| `hybrid` | Kombinasi school + pengantar |

**Table:** `pengantaran_srujukan.sumber_dana`

---

## Sumber Kunjungan Klinik

| Value | Description |
|-------|-------------|
| `dari_asrama` | Dari asrama (melalui pendataan) |
| `mandiri` | Datang sendiri (mandiri) |

**Table:** `kunjungan_klinik.sumber_kunjungan`

---

## Status Pengarahan

| Value | Description |
|-------|-------------|
| `masuk_sekolah` | Masuk sekolah |
| `istirahat_asrama` | Istirahat di asrama |

**Table:** `kunjungan_klinik.status_pengarahan`

---

## Status Rujukan

| Value | Description |
|-------|-------------|
| `menunggu` | Menunggu |
| `terjadwal` | Terjadwal |
| `selesai` | Selesai |
| `dibatalkan` | Dibatalkan |

**Table:** `rujukan.status_rujukan`

---

## Golongan Darah

| Value |
|-------|
| `A` |
| `B` |
| `AB` |
| `O` |
| `A+` |
| `A-` |
| `B+` |
| `B-` |
| `AB+` |
| `AB-` |
| `O+` |
| `O-` |

**Table:** `riwayat_kesehatan_santri.golongandarah`

---

## Flutter Enum Usage

```dart
// Example: Using enums in Flutter
enum UserRole { asatidzPiketMaskan, resepsionisKlinik, dokter }

enum PeriksaKlinik { sudah, belum, diLuar }

// Convert to/from string
final roleString = UserRole.asatidzPiketMaskan.name;
final role = UserRole.values.byName('asatidzPiketMaskan');
```
