import 'package:afiyyah_connect/app/core/constants/app_strings.dart';
import 'package:afiyyah_connect/features/auth/constants/auth_strings.dart';
import 'package:afiyyah_connect/features/auth/model/authstate_model.dart';
import 'package:afiyyah_connect/features/auth/view/insertotp_page.dart';
import 'package:afiyyah_connect/features/auth/view_model/auth_provider.dart';
import 'package:afiyyah_connect/features/common/utils/extension/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key});

  @override
  ConsumerState<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> {
  // Kunci global untuk mengidentifikasi dan mengelola state Form.
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authProviderProvider, (previous, next) {
      if (next.status == AuthStatus.error) {
        _showFeedbackSnackBar(context, message: next.message ?? AppStrings.errorOccurred, isError: true);
      } else if (next.status == AuthStatus.otpSent) {
        _showFeedbackSnackBar(context, message: next.message ?? AppStrings.success);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpPage(email: _emailController.text.trim()),
          ),
        );
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(context),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Center(child: _buildLoginCard(context)),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(context),
          const SizedBox(height: 24),
          _buildBody(context),
          const SizedBox(height: 24),
          Text(
            AuthStrings.unregisteredEmailNotice,
            textAlign: TextAlign.center,
            style: context.textTheme.labelMedium!.copyWith(
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Row(
          spacing: 12,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(child: Icon(Icons.login_rounded)),
            Text(
              AuthStrings.login,
              style: context.textTheme.displaySmall!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          AuthStrings.otpInstruction,
          textAlign: TextAlign.center,
          style: context.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    final authState = ref.watch(authProviderProvider);
    final isLoading = authState.status == AuthStatus.loading;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      // Membungkus kolom dengan widget Form.
      child: Form(
        key: _formKey, // Menetapkan kunci ke Form.
        child: Column(
          children: [
            // Mengubah TextField menjadi TextFormField.
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email_rounded, color: Colors.black45),
                hintText: AuthStrings.emailLabel,
              ),
              enabled: !isLoading,
              // Memberikan validasi otomatis saat pengguna berinteraksi.
              autovalidateMode: AutovalidateMode.onUserInteraction,
              // Logika validator.
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return AuthStrings.emailEmptyValidationError;
                }
                // Regex sederhana untuk validasi format email.
                final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                if (!emailRegex.hasMatch(value)) {
                  return AuthStrings.emailInvalidFormatValidationError;
                }
                return null; // Kembalikan null jika valid.
              },
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                _horizontalLineDivider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: FilledButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            // Memvalidasi form sebelum melanjutkan.
                            if (_formKey.currentState!.validate()) {
                              // Jika form valid, panggil method login.
                              ref.read(authProviderProvider.notifier).sendOtp(_emailController.text.trim());
                            }
                          },
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.send_rounded),
                              SizedBox(width: 12),
                              Text(AuthStrings.sendOtpButton),
                            ],
                          ),
                  ),
                ),
                _horizontalLineDivider(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showFeedbackSnackBar(
    BuildContext context, {
    required String message,
    bool isError = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Theme.of(context).colorScheme.error : Colors.green,
      ),
    );
  }

  Widget _horizontalLineDivider() {
    return Expanded(
      child: Divider(
        color: Colors.black38,
        thickness: 0.25,
      ),
    );
  }

  Widget _buildBackground(BuildContext context) {
    const String defaultImageLink =
        'https://images.unsplash.com/photo-1631507623121-eaaba8d4e7dc?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjR8fGhvc3BpdGFsfGVufDB8MXwwfHx8MA%3D%3D';
    double backgroundHeight = context.mq.size.height;
    var imageBackground = Stack(
      children: [
        Image.network(
          defaultImageLink,
          height: backgroundHeight,
          width: double.infinity,
          fit: BoxFit.cover,
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
              colors: [Colors.black, Colors.transparent],
            ),
          ),
        ),
      ],
    );
    return imageBackground;
  }
}
