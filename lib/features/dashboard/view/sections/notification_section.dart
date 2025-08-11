import 'package:afiyyah_connect/features/dashboard/view/components/alertcardinfo_component.dart';
import 'package:flutter/material.dart';

class NotificationSection extends StatelessWidget {
  const NotificationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: false,
      child: alertCard(
        context,
        title: 'Rujukan Rumah Sakit',
        alertMessage: '2 santri butuh penanganan rumah sakit',
      ),
    );
  }
}
