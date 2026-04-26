# API Documentation

This document provides details about the backend API, which is built on Supabase.

## Authentication Flow
The project uses Supabase for authentication with a one-time password (OTP) flow.

1.  **Check Email**: The user enters their email address. The app calls the `is_email_allowed` RPC function to verify if the email is registered in the system.
2.  **Send OTP**: If the email is allowed, the app calls the `signInWithOtp` method from the Supabase Auth client, which sends an OTP to the user's email.
3.  **Verify OTP**: The user enters the received OTP. The app then calls `verifyOTP` to validate it.
4.  **Sign In**: If the OTP is correct, the user is successfully signed in and a session is created.

## User Roles & Permissions

| Role | Description |
|------|-------------|
| `asatidzPiketMaskan` | Petugas piket asrama |
| `resepsionisKlinik` | Resepsionis klinik |
| `dokter` | Dokter |

### asatidzPiketMaskan (Petugas Piket)
- **Can Read**: `data_santri`, `hujroh`, `kelas`, `pendataan_kesehatan` (all), `profiles` (own), `asrama`, `histori_hujroh_siswa`
- **Can Insert**: `pendataan_kesehatan`
- **Can Update**: `pendataan_kesehatan` (own records only)

### resepsionisKlinik (Resepsionis)
- **Can Read**: All tables - Full read access
- **Can CRUD**: `pendataan_kesehatan`, `kunjungan_klinik`, `pemeriksaan_dokter`, `resep_obat`, `rujukan`, `hasil_rujukan`, `pengantaran_rujukan`, `kwitansi_pengantaran`, `dokumen_hasil_rujukan`, `dokter`, `rumah_sakit`, `petugas`, `asrama`, `histori_hujroh_siswa`

### dokter (Dokter)
- **Can Read**: `data_santri`, `pendataan_kesehatan`, `kunjungan_klinik`, `pemeriksaan_dokter` (own), `riwayat_kesehatan_santri`, `resep_obat`
- **Can Insert**: `pemeriksaan_dokter`
- **Can Update**: `pemeriksaan_dokter` (own), `profiles` (own)

## RPC Functions

### `is_email_allowed`
- **Description**: Checks if a given email address is present in the `allowed_emails` table.
- **Parameters**: `input_email` (text)
- **Returns**: `boolean`

### `update_user_name`
- **Description**: Updates the `name` field in the user's `profiles` record.
- **Parameters**: `new_name` (text)
- **Returns**: `void`
- **Security**: Uses `auth.uid()` internally.

## Row Level Security (RLS) Policies

| Table | Policy | Command | Condition |
|-------|--------|---------|-----------|
| `data_santri` | `asatidz_read_santri` | SELECT | Role in (asatidzPiketMaskan, resepsionisKlinik, dokter) |
| `hujroh` | | SELECT | authenticated |
| `pendataan_kesehatan` | `asatidz_insert_pendataan` | INSERT | role = asatidzPiketMaskan |
| `pendataan_kesehatan` | `resepsionis_crud_pendataan` | ALL | role = resepsionisKlinik |
| `profiles` | | SELECT | id = auth.uid() |
| `profiles` | | UPDATE | id = auth.uid() |
| `rujukan` | `resepsionis_crud_rujukan` | ALL | role = resepsionisKlinik |
| `asrama` | | SELECT | authenticated OR anon |
| `dokter` | | SELECT | authenticated OR anon |
| `rumah_sakit` | | SELECT | authenticated OR anon |
| `petugas` | | SELECT | authenticated OR anon |
| `kendaraan` | | SELECT | authenticated OR anon |
| `kunjungan_klinik` | | SELECT | authenticated OR anon |
| `pemeriksaan_dokter` | | SELECT | authenticated OR anon |
| `resep_obat` | | SELECT | authenticated OR anon |
| `pengantaran_rujukan` | | SELECT | authenticated OR anon |
| `kwitansi_pengantaran` | | SELECT | authenticated OR anon |
| `hasil_rujukan` | | SELECT | authenticated OR anon |
| `dokumen_hasil_rujukan` | | SELECT | authenticated OR anon |

## Storage

### Buckets

| Bucket | Purpose | File Limit | Allowed Types |
|--------|---------|------------|--------------|
| `kwitansi` | Kwitansi pengantaran | 10MB | PDF, JPG, JPEG, PNG |
| `dokumen-rujukan` | Dokumen hasil rujukan | 10MB | PDF, JPG, JPEG, PNG |

### Upload Example

```dart
final response = await Supabase.instance.client
    .storage
    .from('kwitansi')
    .upload(fileName, file);

final url = Supabase.instance.client
    .storage
    .from('kwitansi')
    .getPublicUrl(fileName);
```

## Real-time Subscriptions

```dart
supabase
    .from('pendataan_kesehatan')
    .on(SupabaseEventTypes.insert, (payload) {
      print('New record: ${payload.newRecord}');
    })
    .subscribe();
```

## Enums

### role (User Roles)
| Value | Description |
|-------|-------------|
| `asatidzPiketMaskan` | Petugas piket asrama |
| `resepsionisKlinik` | Klinik resepsionis |
| `dokter` | Dokter |

### status_periksa (Examination Status)
| Value | Description |
|-------|-------------|
| `sudah` | Sudah diperiksa |
| `belum` | Belum diperiksa |
| `di luar` | Di luar |

### status_rujukan (Referral Status)
| Value | Description |
|-------|-------------|
| `menunggu` | Menunggu |
| `terjadwal` | Terjadwal |
| `selesai` | Selesai |
| `dibatalkan` | Dibatalkan |

### jenis_petugas (Staff Type)
| Value | Description |
|-------|-------------|
| `piket_asrama` | Petugas piket asrama |
| `resepsionis_klinik` | Resepsionis klinik |

### golongandarah (Blood Type)
| Value |
|-------|
| `A`, `B`, `AB`, `O`, `A+`, `A-`, `B+`, `B-`, `AB+`, `AB-`, `O+`, `O-` |

## Common Query Examples

### Get Today's Health Data
```dart
final today = DateTime.now().toIso8601String().split('T')[0];
final data = await supabase
    .from('pendataan_kesehatan')
    .select('*, data_santri(nama, hujroh(nama_hujroh))')
    .gte('created_at', '$today 00:00:00');
```

### Get Examination Details (Doctor)
```dart
final data = await supabase
    .from('pemeriksaan_dokter')
    .select('*, kunjungan_klinik(*), dokter(nama_dokter)')
    .eq('id_dokter', dokterId);
```

### Health Data Flow
```
1. asatidzPiketMaskan → pendataan_kesehatan (insert)
2. resepsionisKlinik → pendataan_kesehatan (read)
3. resepsionisKlinik → kunjungan_klinik (insert)
4. dokter → pemeriksaan_dokter (insert)
5. resepsionisKlinik → rujukan (insert)
6. asatidzPiketMaskan/resepsionisKlinik → pengantaran_rujukan (insert)
7. resepsionisKlinik → hasil_rujukan (insert)
```