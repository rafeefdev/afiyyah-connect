# Flutter Integration Guide

## Setup

### Install Package

```yaml
# pubspec.yaml
dependencies:
  supabase_flutter: ^2.0.0
```

### Initialize Supabase

```dart
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://pcrwsjdaujzuucumuqqf.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBjcndzamRhdWp6dXVjdW11cXFmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTMyNjk3OTksImV4cCI6MjA2ODg0NTc5OX0.0YGTOWGJxYgexvcaX-dgQxMwf0n-MgFsH3B1_c5FJd8',
  );
  runApp(MyApp());
}

final supabase = Supabase.instance.client;
```

---

## Authentication

### Sign Up

```dart
// Register new user
final response = await supabase.auth.signUp(
  email: 'user@example.com',
  password: 'password123',
  data: {
    'full_name': 'John Doe',
    'role': 'asatidzPiketMaskan', // atau 'resepsionisKlinik', 'dokter'
  },
);
```

### Sign In

```dart
final response = await supabase.auth.signInWithPassword(
  email: 'user@example.com',
  password: 'password123',
);
```

### Sign Out

```dart
await supabase.auth.signOut();
```

### Get Current User

```dart
final user = supabase.auth.currentUser;
final userId = user?.id;
```

---

## CRUD Operations

### Create (Insert)

```dart
// Insert new record
await supabase.from('pendataan_kesehatan').insert({
  'santri_id': 'uuid-santri',
  'keluhan': ['Demam', 'Pusing'],
  'mulai_sakit': '2026-04-26',
  'status_periksa': 'belum',
});
```

### Read (Select)

```dart
// Get all records
final data = await supabase.from('data_santri').select();

// Get with filter
final data = await supabase
    .from('pendataan_kesehatan')
    .select()
    .eq('user_id', userId);

// Get with join
final data = await supabase
    .from('data_santri')
    .select('*, hujroh(nama_hujroh)')
    .eq('status_aktif', true);
```

### Update

```dart
await supabase
    .from('pendataan_kesehatan')
    .update({'status_periksa': 'sudah'})
    .eq('pendataan_id', 'uuid-pendataan');
```

### Delete

```dart
await supabase
    .from('pendataan_kesehatan')
    .delete()
    .eq('pendataan_id', 'uuid-pendataan');
```

---

## Realtime Subscriptions

```dart
// Listen to changes
supabase
    .from('pendataan_kesehatan')
    .on(SupabaseEventTypes.insert, (payload) {
      print('New record: ${payload.newRecord}');
    })
    .subscribe();
```

---

## Common Queries

### Get Santri by Hujroh

```dart
final data = await supabase
    .from('data_santri')
    .select()
    .eq('hujroh_id', 'hujroh-001');
```

### Get Health History of Santri

```dart
final data = await supabase
    .from('riwayat_kesehatan_santri')
    .select()
    .eq('id_siswa', 'uuid-santri');
```

### Get Today's Pendataan

```dart
final data = await supabase
    .from('pendataan_kesehatan')
    .select()
    .gte('created_at', DateTime.now().toIso8601String().split('T')[0]);
```
