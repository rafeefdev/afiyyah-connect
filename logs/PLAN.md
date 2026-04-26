# Plan Implementasi - Afiyyah Connect

## Analisa Kode vs Dokumentasi

### Layer Non-View yang Sudah Ada:

1. **Models (Entities):**
   - `lib/app/core/model/user.dart` ✓ Role enum ada
   - `lib/app/core/model/entities/santri.dart` ✓
   - `lib/app/core/model/activities/pendataan_kesehatan_model.dart` ✓
   - `lib/app/core/model/activities/rujukan.dart` - Perlu penyesuaian dengan schema
   - `lib/app/core/model/activities/diagnosa.dart` - Perlu penyesuaian
   - `lib/features/clinic_visit/model/kunjunganklnik_model.dart` - Perlu penyesuaian
   - Entity lain: `hujroh.dart`, `kelas.dart`, `penyakit.dart`, `klinik_rujukan.dart`, `sumber_biaya.dart` (perlu review)

2. **Repositories:**
   - `features/auth/repository/auth_repository.dart` ✓
   - `features/common/repository/santri_repository.dart` ✓
   - `features/health_input/repository/health_input_repository.dart` ✓
   - **BELUM ADA:** Repository untuk monitoring, medical history, dashboard stats

3. **ViewModels/Providers:**
   - `features/auth/view_model/auth_provider.dart` ✓
   - `features/auth/view_model/app_user_provider.dart` ✓
   - `features/common/view_model/santri_search_viewmodel.dart` ✓
   - `features/health_input/view_model/pendataan_kesehatan_provider.dart` - Perlu review
   - `features/health_input/view_model/health_input_view_model.dart` - Perlu review
   - `features/common/view_model/main_layout_view_model.dart` - Perlu review

4. **Services:**
   - `lib/app/core/services/supabase_service.dart` ✓
   - `lib/app/core/services/logger_service.dart` ✓

---

## Todo List Implementasi

### Fase 1: Model Entities (sesuaiikan dengan schema database)

- [x] 1.1 Review & update `user.dart` - tambahkan semua field dari tabel `profiles`
- [x] 1.2 Review & update `santri.dart` - tambahkan field dari `data_santri`
- [x] 1.3 Review & update `hujroh.dart` - sesuai schema
- [x] 1.4 Review & update `kelas.dart` - sesuai schema
- [x] 1.5 Review & update `pendataan_kesehatan_model.dart` - sesuai schema lengkap
- [x] 1.6 Buat `kunjungan_klinik_model.dart` - sesuai schema
- [x] 1.7 Buat `pemeriksaan_dokter_model.dart` - sesuai schema
- [x] 1.8 Buat `resep_obat_model.dart` - sesuai schema
- [x] 1.9 Buat `rujukan_model.dart` - sesuai schema (update dari yang ada)
- [x] 1.10 Buat `pengantaran_rujukan_model.dart` - sesuai schema
- [x] 1.11 Buat `hasil_rujukan_model.dart` - sesuai schema
- [x] 1.12 Buat `dokumen_hasil_rujukan_model.dart` - sesuai schema
- [x] 1.13 Buat `kwitansi_pengantaran_model.dart` - sesuai schema
- [x] 1.14 Buat `dokter_model.dart` - sesuai schema
- [x] 1.15 Buat `rumah_sakit_model.dart` - sesuai schema
- [x] 1.16 Buat `petugas_model.dart` - sesuai schema
- [x] 1.17 Buat `riwayat_kesehatan_santri_model.dart` - sesuai schema
- [x] 1.18 Buat `histori_hujroh_siswa_model.dart` - sesuai schema
- [x] 1.19 Buat `asrama_model.dart` - sesuai schema
- [x] 1.20 Buat `kendaraan_model.dart` - sesuai schema
- [x] 1.21 Buat enum file untuk semua enum di database

### Fase 2: Repositories (Data Layer - satu-satunya sumber kebenaran)

- [x] 2.1 Review & update `auth_repository.dart` - sesuai API docs
- [x] 2.2 Review & update `santri_repository.dart` - tambah method get by ID
- [x] 2.3 Review & update `health_input_repository.dart`
- [x] 2.4 Buat `pendataan_kesehatan_repository.dart` - CRUD lengkap
- [x] 2.5 Buat `klinik_repository.dart` - untuk kunjungan, pemeriksaan
- [x] 2.6 Buat `rujukan_repository.dart` - CRUD rujukan
- [x] 2.7 Buat `pengantaran_repository.dart` - CRUD pengantaran
- [x] 2.8 Buat `storage_repository.dart` - upload/download file
- [x] 2.9 Buat `dokter_repository.dart` - data dokter
- [x] 2.10 Buat `rumah_sakit_repository.dart` - data rumah sakit
- [x] 2.11 Buat `petugas_repository.dart` - data petugas
- [x] 2.12 Buat `asrama_repository.dart` - data asrama
- [x] 2.13 Buat `kendaraan_repository.dart` - data kendaraan
- [x] 2.14 Buat `riwayat_kesehatan_repository.dart` - riwayat kesehatan

### Fase 3: ViewModels/Providers (State Management - Riverpod)

- [ ] 3.1 Review & update `auth_provider.dart`
- [ ] 3.2 Review `app_user_provider.dart`
- [ ] 3.3 Review `santri_search_viewmodel.dart`
- [ ] 3.4 Review `pendataan_kesehatan_provider.dart`
- [ ] 3.5 Review `health_input_view_model.dart`
- [ ] 3.6 Review `main_layout_view_model.dart`
- [ ] 3.7 Buat `dashboard_view_model.dart` - untuk statistics
- [ ] 3.8 Buat `monitoring_view_model.dart` - untuk monitoring page
- [ ] 3.9 Buat `medical_history_view_model.dart` - untuk history page

### Fase 4: Business Process (Workflows)

- [x] 4.1 **Alur Pendataan Kesehatan** (asatidzPiketMaskan)
  - Input keluhan → simpan ke `pendataan_kesehatan`
  
- [ ] 4.2 **Alur Pemeriksaan** (resepsionisKlinik/dokter)
  - Lire pendataan → buat `kunjungan_klinik`
  - Pemeriksaan oleh dokter → simpan ke `pemeriksaan_dokter`
  
- [ ] 4.3 **Alur Rujukan** (resepsionisKlinik)
  - Buat rujukan → ke rumah sakit → simpan ke `rujukan`
  
- [ ] 4.4 **Alur Pengantaran** (asatidz/resepsionis)
  - Jadwalkan pengantaran → simpan ke `pengantaran_rujukan`
  - Upload kwitansi → ke storage → simpan ke `kwitansi_pengantaran`
  
- [ ] 4.5 **Alur Hasil Rujukan** (resepsionis)
  - Simpan hasil → upload dokumen → ke `hasil_rujukan`, `dokumen_hasil_rujukan`
  
- [ ] 4.6 **Dashboard Statistics**
  - Get total penyakit minggu ini
  - Get comparison dengan minggu lalu
  - Get most common cases
  - Get cases per day/level/dorm
  - Get referrals today

- [ ] 4.7 **Monitoring**
  - Get list periksa (belum)
  - Get list arahan
  - Get list rujukan RS

- [ ] 4.8 **Medical History**
  - Get riwayat kesehatanasantrian

---

## Catatan

- View layer (UI) belum termasuk dalam plan ini
- Setelah business process selesai, baru handle View layer
- Semua repository harus menggunakan Supabase service yang sudah ada
- Gunakan naming sesuai schema database untuk mapping field
- Ikuti pattern MVVM dengan Riverpod yang sudah ada