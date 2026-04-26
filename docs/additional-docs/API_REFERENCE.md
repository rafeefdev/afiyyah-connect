# API Reference — Table Access by Role

## Roles

| Role | Description |
|------|-------------|
| `asatidzPiketMaskan` | Petugas piket asrama |
| `resepsionisKlinik` | Resepsionis klinik |
| `dokter` | Dokter |

---

## asatidzPiketMaskan (Petugas Piket)

### Can Read
- `data_santri` - All students
- `hujroh` - All rooms
- `kelas` - All classes
- `pendataan_kesehatan` - Own + all (read)
- `profiles` - Own profile only
- `asrama` - All
- `histori_hujroh_siswa` - All

### Can Insert
- `pendataan_kesehatan` - Create new health record

### Can Update
- `pendataan_kesehatan` - Own records only

---

## resepsionisKlinik (Resepsionis)

### Can Read
- All tables - Full read access

### Can Insert/Update/Delete
- `pendataan_kesehatan` - Full CRUD
- `kunjungan_klinik` - Full CRUD
- `pemeriksaan_dokter` - Full CRUD
- `resep_obat` - Full CRUD
- `rujukan` - Full CRUD
- `hasil_rujukan` - Full CRUD
- `pengantaran_rujukan` - Full CRUD
- `kwitansi_pengantaran` - Full CRUD
- `dokumen_hasil_rujukan` - Full CRUD
- `dokter` - Full CRUD
- `rumah_sakit` - Full CRUD
- `petugas` - Full CRUD
- `asrama` - Full CRUD
- `histori_hujroh_siswa` - Full CRUD

---

## dokter (Dokter)

### Can Read
- `data_santri` - All students
- `pendataan_kesehatan` - All records
- `kunjungan_klinik` - All visits
- `pemeriksaan_dokter` - Own examinations
- `riwayat_kesehatan_santri` - All health records
- `resep_obat` - All prescriptions

### Can Insert
- `pemeriksaan_dokter` - Create examination

### Can Update
- `pemeriksaan_dokter` - Own examinations only
- `profiles` - Own profile

---

## Anonymous/Public

### Read Only
- No direct table access without authentication
- All operations require authentication

---

## Common API Patterns

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

### Query Examples

```dart
// Get all patients for today (resepsionis)
final today = DateTime.now().toIso8601String().split('T')[0];
final data = await supabase
    .from('pendataan_kesehatan')
    .select('*, data_santri(nama, hujroh(nama_hujroh))')
    .gte('created_at', '$today 00:00:00');

// Get examination details (dokter)
final data = await supabase
    .from('pemeriksaan_dokter')
    .select('*, kunjungan_klinik(*), dokter(nama_dokter)')
    .eq('id_dokter', dokterId);
```
