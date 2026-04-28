# AGENTS.md

## Workflow Pengerjaan Proyek

### Langkah Kerja

1. **Cek Branch** - Pastikan tidak di main branch
2. **Baca PLAN.md** - Cek todo list yang ada di `logs/PLAN.md`
3. **Baca Dokumentasi** - Cek `docs/` dan `docs/additional-docs/` untuk teknis penyelesaian
4. **Kerjakan Tugas** - Implementasi sesuai plan
5. **Run flutter analyze** - Cek error sebelum commit
6. **Update WORKLOG.md** - Tulis ringkasan pekerjaan di `logs/WORKLOG.md`
7. **Update PLAN.md** - Centang task yang sudah selesai

### Format WORKLOG.md

```markdown
# Work Log - [Tanggal]

## Yang Sudah Dikerjakan

- [task] - Deskripsi

## Rencana Berikutnya

- [next task]
```

### Catatan

- Jangan kerjakan View layer dulu (non-VM优先)
- Setelah business process selesai, baru handle View layer
- Ikuti nama field sesuai schema database
- Setiap selesai pengerjaan, wajib jalankan `flutter analyze` untuk cek error
- Jika ada error, perbaiki sebelum push/commit