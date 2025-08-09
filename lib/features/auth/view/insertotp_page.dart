import 'dart:async';

import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/auth/model/authstate_model.dart';
import 'package:afiyyah_connect/features/auth/view_model/auth_provider.dart';
import 'package:afiyyah_connect/features/common/utils/extension/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends ConsumerStatefulWidget {
  final String email;
  const OtpPage({super.key, required this.email});

  @override
  ConsumerState<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends ConsumerState<OtpPage> {
  final _pinController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Timer? _timer;
  int _start = 60;
  bool _isResendButtonDisabled = true;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _pinController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _isResendButtonDisabled = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _isResendButtonDisabled = false;
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  void resendOtp() {
    if (!_isResendButtonDisabled) {
      ref.read(authProviderProvider.notifier).sendOtp(widget.email);
      setState(() {
        _start = 60;
      });
      startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authProviderProvider, (previous, next) {
      if (next.status == AuthStatus.error) {
        _showFeedbackSnackBar(context, message: next.message ?? 'Terjadi kesalahan', isError: true);
      } else if (next.status == AuthStatus.success) {
        _showFeedbackSnackBar(context, message: next.message ?? 'Sukses');
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    });

    final authState = ref.watch(authProviderProvider);
    final isLoading = authState.status == AuthStatus.loading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verifikasi OTP'),
      ),
      body: Padding(
        padding: AppSpacing.pagePadding,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Masukkan Kode Verifikasi',
                style: context.textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Kode 6 digit telah dikirimkan ke email:\n${widget.email}',
                textAlign: TextAlign.center,
                style: context.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 32),
              Pinput(
                controller: _pinController,
                length: 6,
                keyboardType: TextInputType.number,
                mainAxisAlignment: MainAxisAlignment.center,
                closeKeyboardWhenCompleted: true,
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'Masukkan 6 digit kode OTP';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            ref.read(authProviderProvider.notifier).verifyOtp(widget.email, _pinController.text);
                          }
                        },
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Text('Verifikasi & Masuk'),
                ),
              ),
              const SizedBox(height: 24),
              _buildResendSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResendSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Belum menerima kode? ',
          style: context.textTheme.bodyMedium,
        ),
        if (_isResendButtonDisabled)
          Text(
            'Kirim ulang dalam 0:${_start.toString().padLeft(2, '0')}',
            style: context.textTheme.bodyMedium!.copyWith(color: Theme.of(context).primaryColor),
          )
        else
          TextButton(
            onPressed: resendOtp,
            child: const Text('Kirim Ulang OTP'),
          ),
      ],
    );
  }

  void _showFeedbackSnackBar(
    BuildContext context,
    {
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
}