import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/medical_history/view/overlayimagecard_component.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data & Riwayat')),
      body: Padding(
        padding: AppSpacing.pagePadding,
        child: ListView(
          children: [
            OverlayImageCard(
              title: 'Pendataan & Pemeriksaan',
              imageLink:
                  'https://images.pexels.com/photos/8770725/pexels-photo-8770725.jpeg',
            ),
            const SizedBox(height: 12),
            OverlayImageCard(
              imageLink:
                  'https://images.unsplash.com/photo-1630431174869-d7d9d398fc55?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzB8fGFtYnVsYW5jZSUyMHBhdGllbnR8ZW58MHwwfDB8fHww',
              title: 'Rujukan & Pengantaran',
            ),
            const SizedBox(height: 12),
            OverlayImageCard(
              imageLink:
                  'https://images.unsplash.com/photo-1526256262350-7da7584cf5eb?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bWVkaWNhbCUyMGNsaXBib2FyZHxlbnwwfHwwfHx8MA%3D%3D',
              title: 'Identitas & Rekam Medis',
            ),
          ],
        ),
      ),
    );
  }
}
