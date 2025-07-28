import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/common/utils/extension/extensions.dart';
import 'package:afiyyah_connect/features/dashboard/view/alertcardinfo_component.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO : implement real notification
    bool isError = true;

    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(context),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Visibility(
                visible: isError,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: alertCard(
                    context,
                    // TODO : give more suitable message based on user problem
                    title: 'Akun belum terdaftar',
                    alertMessage:
                        'Mohon hubungi bagian kesehatan Kesantrian Putra untuk mendaftarkan akun Anda',
                  ),
                ),
              ),
              const SizedBox(height: 320),
              _buildBottomLogin(context),
            ],
          ),
        ],
      ),
    );
  }

  Container _buildBottomLogin(BuildContext context) {
    Radius notchRadius = Radius.circular(30);
    return Container(
      padding: AppSpacing.pagePadding,
      height: context.mq.size.height * 0.3,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: notchRadius,
          topRight: notchRadius,
        ),
      ),
      child: Column(
        children: [
          Text(
            'Sign-in',
            style: context.textTheme.displaySmall!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Masukkan email / akun Google yang terdaftar untuk mulai menggunakan aplikasi',
            textAlign: TextAlign.center,
            style: context.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 48),
          FilledButton(
            onPressed: () {},
            child: const Text('Login dengan akun Google'),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground(BuildContext context) {
    String defaultImageLink =
        'https://images.unsplash.com/photo-1631507623121-eaaba8d4e7dc?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjR8fGhvc3BpdGFsfGVufDB8MXwwfHx8MA%3D%3D';
    double backgroundHeight = context.mq.size.height * 0.8;
    var imageBackground = Stack(
      children: [
        Image.network(
          defaultImageLink,
          height: backgroundHeight,
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
              height: backgroundHeight,
              width: double.infinity,
              color: Colors.grey.shade300,
              child: const Center(
                child: Icon(Icons.broken_image, size: 48, color: Colors.grey),
              ),
            );
          },
        ),
        Container(
          height: backgroundHeight,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black87, Colors.transparent],
            ),
          ),
        ),
      ],
    );
    return defaultImageLink.isNotEmpty
        ? imageBackground
        : Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.blue, Colors.white],
              ),
            ),
          );
  }
}
