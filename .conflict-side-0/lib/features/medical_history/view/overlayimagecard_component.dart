import 'package:flutter/material.dart';
import 'package:afiyyah_connect/features/common/utils/extension/extensions.dart';

class OverlayImageCard extends StatelessWidget {
  final String imageLink;
  final String title;
  final VoidCallback? onTap;

  const OverlayImageCard({
    super.key,
    required this.imageLink,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Gambar dengan caching + loading + error handling
            Image.network(
              imageLink,
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
              // loadingBuilder: tampilkan spinner saat loading
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  height: 140,
                  width: double.infinity,
                  color: Colors.grey.shade300,
                  child: const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              },
              // errorBuilder: tampilkan fallback saat gagal load
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 140,
                  width: double.infinity,
                  color: Colors.grey.shade300,
                  child: const Center(
                    child: Icon(
                      Icons.broken_image,
                      size: 48,
                      color: Colors.grey,
                    ),
                  ),
                );
              },
            ),

            // Overlay gradient
            Container(
              height: 140,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.black87, Colors.transparent],
                ),
              ),
            ),

            // Judul
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                title,
                style: context.textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
