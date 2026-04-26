# AGENTS.md

## Workflow Pengerjaan Proyek

### Langkah Kerja

1. **Baca PLAN.md** - Cek todo list yang ada di `logs/PLAN.md`
2. **Baca Dokumentasi** - Cek `docs/` dan `docs/additional-docs/` untuk teknis penyelesaian
3. **Kerjakan Tugas** - Implementasi sesuai plan
4. **Update WORKLOG.md** - Tulis ringkasan pekerjaan di `logs/WORKLOG.md`
5. **Update PLAN.md** - Centang task yang sudah selesai

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