# Architecture

## High-Level System Architecture
The project uses a feature-based architecture, which helps in separating concerns and improving scalability. It leverages Riverpod for state management and Supabase for the backend, including authentication, database, and edge functions.

## Folder Structure
- `lib/app`: Contains the core application logic, shared across features.
  - `core/model`: Defines core data models like `UserModel`.
  - `core/services`: Includes services like `SupabaseService` and `LoggerService`.
  - `themes`: Holds the application's visual theme, including colors, typography, and spacing.
- `lib/features`: Each sub-directory represents a feature of the application (e.g., `auth`, `dashboard`, `profile`). This modular structure allows developers to work on features in isolation.
  - `model`: Feature-specific data models.
  - `repository`: Handles data operations, communicating with services or APIs.
  - `view`: Contains the UI (widgets and screens).
  - `viewmodel` or `provider`: Manages the state for the views.

## Design Patterns
The project primarily follows the **MVVM (Model-View-ViewModel)** pattern, adapted for Flutter and Riverpod.
- **Model**: Represents the data structures (e.g., `UserModel`).
- **View**: The UI components (e.g., `LoginScreen`, `DashboardPage`). They are responsible for displaying data and capturing user input.
- **ViewModel**: Implemented using Riverpod `Providers`. They hold the business logic, manage state, and expose it to the View. For example, `AuthRepository` acts as part of the ViewModel layer.

## State Management Flow
The project uses **Riverpod** for dependency injection and state management.

1.  **Provider Declaration**: Providers are declared using the `@riverpod` annotation, which generates the necessary provider code (`.g.dart` files).
    - `authRepositoryProvider`: Provides a singleton instance of `AuthRepository`.
    - `authStateChangesProvider`: A stream provider that notifies the app of authentication state changes (login/logout).

2.  **Accessing State**: Widgets use `ref.watch` to listen to a provider's state. When the state changes, the widget automatically rebuilds.
    ```dart
    // Example in a widget
    final authState = ref.watch(authStateChangesProvider);
    ```

3.  **Modifying State**: User actions in the View trigger methods in the ViewModel (e.g., `AuthRepository`). These methods perform business logic (like calling Supabase) and update the state, causing the UI to refresh.

## Database Schema
The project uses a Supabase PostgreSQL database. Key tables include:

### `profiles`
Stores public user profile information. A new entry is created for each user upon registration.
- `id` (uuid, primary key): Foreign key to `auth.users.id`.
- `full_name` (text): The user's full name.
- `email` (text): The user's email address.
- `role` (enum): The user's role in the application (`asatidzPiketMaskan`, `resepsionisKlinik`, `dokter`).

### `allowed_emails`
This table is used to control which users can create an account.
- `id` (uuid, primary key): A unique identifier for the record.
- `email` (text, unique): The email address that is allowed to register.

### `data_santri`
Student data table.
- `id` (uuid, primary key): Student ID.
- `nama` (text): Student name.
- `nis` (text): Student NIS.
- `hujroh_id` (uuid, foreign key): Reference to `hujroh`.
- `status_aktif` (boolean): Active status.

### `hujroh`
Dormitory/room data.
- `id` (uuid, primary key): Room ID.
- `nama_hujroh` (text): Room name.
- `asrama_id` (uuid, foreign key): Reference to `asrama`.

### `asrama`
Dormitory building data.
- `id` (uuid, primary key): Asrama ID.
- `nama_asrama` (text): Asrama name.

### `kelas`
Class data.
- `id` (uuid, primary key): Class ID.
- `nama_kelas` (text): Class name.
- `tingkat` (int): Grade level.

### `pendataan_kesehatan`
Health data collection.
- `id` (uuid, primary key): Record ID.
- `santri_id` (uuid, foreign key): Reference to `data_santri`.
- `user_id` (uuid, foreign key): Reference to `auth.users`.
- `keluhan` (jsonb): List of symptoms.
- `mulai_sakit` (date): Illness start date.
- `status_periksa` (enum): Examination status (`sudah`, `belum`, `di luar`).
- `created_at` (timestamp): Creation timestamp.

### `kunjungan_klinik`
Clinic visit records.
- `id` (uuid, primary key): Visit ID.
- `pendataan_id` (uuid, foreign key): Reference to `pendataan_kesehatan`.
- `sumber_kunjungan` (enum): Visit source (`dari_asrama`, `mandiri`).
- `status_pengarahan` (enum): Direction status (`masuk_sekolah`, `istirahat_asrama`).

### `pemeriksaan_dokter`
Doctor examination records.
- `id` (uuid, primary key): Examination ID.
- `kunjungan_id` (uuid, foreign key): Reference to `kunjungan_klinik`.
- `id_dokter` (uuid, foreign key): Reference to `dokter`.
- `diagnosa` (text): Diagnosis.
- `resep` (text): Prescription.

### `resep_obat`
Prescription records.
- `id` (uuid, primary key): Prescription ID.
- `pemeriksaan_id` (uuid, foreign key): Reference to `pemeriksaan_dokter`.
- `nama_obat` (text): Medicine name.
- `dosis` (text): Dosage.

### `rujukan`
Referral records.
- `id` (uuid, primary key): Referral ID.
- `pemeriksaan_id` (uuid, foreign key): Reference to `pemeriksaan_dokter`.
- `rumah_sakit_id` (uuid, foreign key): Reference to `rumah_sakit`.
- `status_rujukan` (enum): Referral status (`menunggu`, `terjadwal`, `selesai`, `dibatalkan`).

### `pengantaran_rujukan`
Referral transportation.
- `id` (uuid, primary key): Transportation ID.
- `rujukan_id` (uuid, foreign key): Reference to `rujukan`.
- `id_petugas` (uuid, foreign key): Reference to `petugas`.
- `tanggal_pengantaran` (date): Transportation date.

### `hasil_rujukan`
Referral results.
- `id` (uuid, primary key): Result ID.
- `rujukan_id` (uuid, foreign key): Reference to `rujukan`.
- `tanggal_hasil` (date): Result date.
- `dokumentasi` (text): Documentation.

### `dokumen_hasil_rujukan`
Referral result documents.
- `id` (uuid, primary key): Document ID.
- `hasil_rujukan_id` (uuid, foreign key): Reference to `hasil_rujukan`.
- `nama_file` (text): File name.
- `path_file` (text): File path (URL).
- `jenis_dokumen` (enum): Document type (`Hasil Lab`, `Surat Dokter`, `Foto Rontgen`).

### `kwitansi_pengantaran`
Transportation receipts.
- `id` (uuid, primary key): Receipt ID.
- `pengantaran_id` (uuid, foreign key): Reference to `pengantaran_rujukan`.
- `nama_file` (text): File name.
- `path_file` (text): File path (URL).
- `jenis_kwitansi` (enum): Receipt type (`RS`, `Laboratorium`, `Transportasi`).

### `dokter`
Doctor data.
- `id` (uuid, primary key): Doctor ID.
- `nama_dokter` (text): Doctor name.
- `spesialis` (text): Specialization.

### `rumah_sakit`
Hospital data.
- `id` (uuid, primary key): Hospital ID.
- `nama_rs` (text): Hospital name.
- `alamat` (text): Address.

### `petugas`
Staff data.
- `id` (uuid, primary key): Staff ID.
- `nama_petugas` (text): Staff name.
- `jenis_petugas` (enum): Staff type (`piket_asrama`, `resepsionis_klinik`).

### `riwayat_kesehatan_santri`
Student health history.
- `id` (uuid, primary key): Record ID.
- `id_siswa` (uuid, foreign key): Reference to `data_santri`.
- `golongandarah` (enum): Blood type (`A`, `B`, `AB`, `O`, `A+`, `A-`, `B+`, `B-`, `AB+`, `AB-`, `O+`, `O-`).
- `alergi` (jsonb): Allergies list.
- `penyakit_bawaan` (jsonb): Pre-existing conditions.

### `histori_hujroh_siswa`
Student room history.
- `id` (uuid, primary key): History ID.
- `siswa_id` (uuid, foreign key): Reference to `data_santri`.
- `hujroh_id` (uuid, foreign key): Reference to `hujroh`.
- `tanggal_mulai` (date): Start date.
- `tanggal_selesai` (date): End date.

### `kendaraan`
Vehicle data.
- `id` (uuid, primary key): Vehicle ID.
- `nama_kendaraan` (text): Vehicle name.
- `jenis_kepemilikan` (enum): Ownership type (`pribadi`, `sekolah`).

### Storage Buckets
| Bucket | Purpose | File Limit |
|--------|---------|------------|
| `kwitansi` | Kwitansi pengantaran | 10MB |
| `dokumen-rujukan` | Dokumen hasil rujukan | 10MB |

**Allowed file types:** PDF, JPG, JPEG, PNG
