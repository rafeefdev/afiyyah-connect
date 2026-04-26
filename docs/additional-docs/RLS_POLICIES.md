# RLS Policies Reference

Row Level Security policies applied to each table.

---

## data_santri

| Policy | Command | Condition |
|--------|---------|-----------|
| `asatidz_read_santri` | SELECT | Role in (asatidzPiketMaskan, resepsionisKlinik, dokter) |

---

## hujroh

| Policy | Command | Condition |
|--------|---------|-----------|
| `Allow authenticated users to read hujroh data` | SELECT | authenticated |

---

## pendataan_kesehatan

| Policy | Command | Condition |
|--------|---------|-----------|
| `Enable insert for authenticated users only` | INSERT | authenticated |
| `Enable delete for users based on user_id` | DELETE | user_id = auth.uid() |
| `asatidz_insert_pendataan` | INSERT | role = asatidzPiketMaskan in profiles |
| `resepsionis_crud_pendataan` | ALL | role = resepsionisKlinik in profiles |

---

## profiles

| Policy | Command | Condition |
|--------|---------|-----------|
| `Pengguna hanya bisa melihat profil mereka sendiri` | SELECT | id = auth.uid() |
| `Users can view their own profile.` | SELECT | id = auth.uid() |
| `Pengguna hanya bisa memperbarui profil mereka sendiri` | UPDATE | id = auth.uid() |
| `Users can update their own profile.` | UPDATE | id = auth.uid() |
| `Pengguna hanya bisa membuat profil untuk diri mereka sendiri` | INSERT | id = auth.uid() |

---

## rujukan

| Policy | Command | Condition |
|--------|---------|-----------|
| `resepsionis_crud_rujukan` | ALL | role = resepsionisKlinik in profiles |

---

## riwayat_kesehatan_santri

| Policy | Command | Condition |
|--------|---------|-----------|
| `resepsionis_crud_riwayat` | ALL | role = resepsionisKlinik in profiles |

---

## asrama

| Policy | Command | Condition |
|--------|---------|-----------|
| `asrama_read_policy` | SELECT | authenticated OR anon |
| `asrama_admin_policy` | ALL | service_role |

---

## dokter

| Policy | Command | Condition |
|--------|---------|-----------|
| `dokter_read_policy` | SELECT | authenticated OR anon |
| `dokter_admin_policy` | ALL | service_role |

---

## rumah_sakit

| Policy | Command | Condition |
|--------|---------|-----------|
| `rumah_sakit_read_policy` | SELECT | authenticated OR anon |
| `rumah_sakit_admin_policy` | ALL | service_role |

---

## petugas

| Policy | Command | Condition |
|--------|---------|-----------|
| `petugas_read_policy` | SELECT | authenticated OR anon |
| `petugas_admin_policy` | ALL | service_role |

---

## histori_hujroh_siswa

| Policy | Command | Condition |
|--------|---------|-----------|
| `histori_hujroh_siswa_read_policy` | SELECT | authenticated OR anon |
| `histori_hujroh_siswa_admin_policy` | ALL | service_role |

---

## kendaraan

| Policy | Command | Condition |
|--------|---------|-----------|
| `kendaraan_read_policy` | SELECT | authenticated OR anon |
| `kendaraan_admin_policy` | ALL | service_role |

---

## kunjungan_klinik

| Policy | Command | Condition |
|--------|---------|-----------|
| `kunjungan_klinik_read_policy` | SELECT | authenticated OR anon |
| `kunjungan_klinik_admin_policy` | ALL | service_role |

---

## pemeriksaan_dokter

| Policy | Command | Condition |
|--------|---------|-----------|
| `pemeriksaan_dokter_read_policy` | SELECT | authenticated OR anon |
| `pemeriksaan_dokter_admin_policy` | ALL | service_role |

---

## resep_obat

| Policy | Command | Condition |
|--------|---------|-----------|
| `resep_obat_read_policy` | SELECT | authenticated OR anon |
| `resep_obat_admin_policy` | ALL | service_role |

---

## pengantaran_rujukan

| Policy | Command | Condition |
|--------|---------|-----------|
| `pengantaran_rujukan_read_policy` | SELECT | authenticated OR anon |
| `pengantaran_rujukan_admin_policy` | ALL | service_role |

---

## kwitansi_pengantaran

| Policy | Command | Condition |
|--------|---------|-----------|
| `kwitansi_read_policy` | SELECT | authenticated OR anon |
| `kwitansi_admin_policy` | ALL | service_role |

---

## hasil_rujukan

| Policy | Command | Condition |
|--------|---------|-----------|
| `hasil_rujukan_read_policy` | SELECT | authenticated OR anon |
| `hasil_rujukan_admin_policy` | ALL | service_role |

---

## dokumen_hasil_rujukan

| Policy | Command | Condition |
|--------|---------|-----------|
| `dokumen_hasil_rujukan_read_policy` | SELECT | authenticated OR anon |
| `dokumen_hasil_rujukan_admin_policy` | ALL | service_role |

---

## Testing RLS

```dart
// Test asatidz role access
final data = await supabase
    .from('pendataan_kesehatan')
    .select()
    .eq('user_id', userId);

// Should work: asatidz can insert
await supabase.from('pendataan_kesehatan').insert({
  'santri_id': 'uuid',
  'keluhan': ['test'],
  'mulai_sakit': '2026-04-26',
});

// Should fail: not authorized
await supabase.from('dokter').insert({...});
```

## Common Errors

| Error | Cause |
|-------|-------|
| `row-level security` | User not authenticated or role not authorized |
| `permission denied` | Policy doesn't allow operation |
| `auth.uid() is null` | User not logged in |
