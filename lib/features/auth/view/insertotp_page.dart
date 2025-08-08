import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/common/utils/extension/extensions.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppSpacing.pagePadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Halaman Verifikasi',
              style: context.textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Masukkan kode OTP yang telah dikirimkan ke email Anda',
              textAlign: TextAlign.center,
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(width: context.mq.size.width, height: 24),
            const OtpPad(),
            SizedBox(width: context.mq.size.width, height: 24),
            Text(
              'Belum menerima kode ?',
              textAlign: TextAlign.center,
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(width: context.mq.size.width, height: 12),
            //TODO : insert condition when user ask to resend a new otp
            Visibility(
              child: Text(
                'Kode Anda akan dikirim ulang\ndalam 0:39',
                textAlign: TextAlign.center,
                style: context.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            SizedBox(width: context.mq.size.width, height: 12),
            TextButton(
              onPressed: () {},
              style: ButtonStyle(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Kirim ulang OTP',
                textAlign: TextAlign.center,
                style: context.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OtpPad extends StatefulWidget {
  const OtpPad({super.key});

  @override
  State<OtpPad> createState() => _OtpPadState();
}

class _OtpPadState extends State<OtpPad> {
  final _pinController = TextEditingController();

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Pinput(
      controller: _pinController,
      keyboardType: TextInputType.number,
      mainAxisAlignment: MainAxisAlignment.center,
      closeKeyboardWhenCompleted: true,
    );
  }
}
