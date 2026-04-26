# Storage Guide

## Buckets

| Bucket | Purpose | File Limit |
|--------|---------|------------|
| `kwitansi` | Kwitansi pengantaran | 10MB |
| `dokumen-rujukan` | Dokumen hasil rujukan | 10MB |

**Allowed file types:** PDF, JPG, JPEG, PNG

---

## Upload File

### Upload Kwitansi

```dart
import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:file_picker/file_picker.dart';

Future<String?> uploadKwitansi(File file, int pengantaranId) async {
  final fileName = '${pengantaranId}_${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';
  
  final response = await Supabase.instance.client
      .storage
      .from('kwitansi')
      .upload(fileName, file);
  
  // Get public URL
  final url = Supabase.instance.client
      .storage
      .from('kwitansi')
      .getPublicUrl(fileName);
  
  return url;
}
```

### Upload Dokumen Rujukan

```dart
Future<String?> uploadDokumenRujukan(File file, int hasilRujukanId) async {
  final fileName = 'hasil_${hasilRujukanId}_${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';
  
  final response = await Supabase.instance.client
      .storage
      .from('dokumen-rujukan')
      .upload(fileName, file);
  
  final url = Supabase.instance.client
      .storage
      .from('dokumen-rujukan')
      .getPublicUrl(fileName);
  
  return url;
}
```

---

## Download File

```dart
// Get file URL (for display in UI)
final url = Supabase.instance.client
    .storage
    .from('kwitansi')
    .getPublicUrl('filename.pdf');

// Download file to device
final response = await Supabase.instance.client
    .storage
    .from('kwitansi')
    .download('filename.pdf');

final bytes = response.content;
```

---

## Delete File

```dart
await Supabase.instance.client
    .storage
    .from('kwitansi')
    .remove(['filename.pdf']);
```

---

## Save to Database

After uploading, save metadata to table:

```dart
// Save kwitansi metadata
await supabase.from('kwitansi_pengantaran').insert({
  'id_pengantaran': pengantaranId,
  'nama_file': fileName,
  'path_file': url,
  'jenis_kwitansi': 'RS', // RS, Laboratorium, Transportasi
});

// Save dokumen rujukan metadata
await supabase.from('dokumen_hasil_rujukan').insert({
  'id_hasil_rujukan': hasilRujukanId,
  'nama_file': fileName,
  'path_file': url,
  'jenis_dokumen': 'Hasil Lab', // Hasil Lab, Surat Dokter, Foto Rontgen
});
```

---

## Flutter File Picker

```yaml
# pubspec.yaml
dependencies:
  file_picker: ^8.0.0
```

```dart
import 'package:file_picker/file_picker.dart';

Future<File?> pickFile() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    allowMultiple: false,
  );
  
  if (result != null && result.files.isNotEmpty) {
    return File(result.files.first.path!);
  }
  return null;
}
```

---

## Error Handling

```dart
try {
  final response = await Supabase.instance.client
      .storage
      .from('kwitansi')
      .upload(fileName, file);
      
  if (response.error != null) {
    throw Exception(response.error!.message);
  }
} on StorageException catch (e) {
  print('Upload failed: ${e.message}');
}
```

---

## Image/PDF Display in Flutter

```dart
import 'package:flutter/material.dart';

// Display image from URL
Image.network(
  url,
  errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image),
)

// Display PDF (using url_launcher or pdf_render)
import 'package:url_launcher/url_launcher.dart';

Future<void> openPdf(String url) async {
  await launchUrl(Uri.parse(url));
}
```
