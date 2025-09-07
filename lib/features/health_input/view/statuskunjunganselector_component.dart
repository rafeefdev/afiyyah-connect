import 'package:afiyyah_connect/features/common/utils/extension/extensions.dart';
import 'package:afiyyah_connect/features/health_input/model/periksaklinikstatus_model.dart';
import 'package:flutter/material.dart';

// enum PeriksaKlinikStatus { sudah, belum, luar }

class KlinikStatusSelector extends StatelessWidget {
  final PeriksaKlinikStatus selectedStatus;
  final ValueChanged<PeriksaKlinikStatus> onChanged;

  const KlinikStatusSelector({
    super.key,
    required this.selectedStatus,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4,
      children: [
        _buildStatusCard(
          context,
          label: 'Sudah',
          icon: Icons.check_circle_outline,
          value: PeriksaKlinikStatus.sudah,
        ),
        _buildStatusCard(
          context,
          label: 'Belum',
          icon: Icons.help_outline,
          value: PeriksaKlinikStatus.belum,
        ),
        _buildStatusCard(
          context,
          label: 'Di Luar',
          icon: Icons.local_hospital_outlined,
          value: PeriksaKlinikStatus.luar,
        ),
      ],
    );
  }

  Widget _buildStatusCard(
    BuildContext context, {
    required String label,
    required IconData icon,
    required PeriksaKlinikStatus value,
  }) {
    final isSelected = selectedStatus == value;

    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(value),
        child: Card(
          elevation: isSelected ? 2 : 1,
          color: isSelected ? context.theme.colorScheme.primary : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: isSelected
                  ? context.theme.colorScheme.primary
                  : context.theme.colorScheme.primary.withValues(alpha: 0.3),
              width: 1.5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: isSelected
                      ? Colors.white
                      : context.theme.colorScheme.primary,
                  size: 28,
                ),
                const SizedBox(height: 6),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: context.theme.textTheme.labelLarge?.copyWith(
                    color: isSelected
                        ? Colors.white
                        : context.theme.colorScheme.primary,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
