import 'package:flutter/material.dart';
import '../styles/app_colors.dart';

class AlertCard extends StatelessWidget {
  final String count;
  final String label;
  final bool isDanger;

  const AlertCard({
    super.key,
    required this.count,
    required this.label,
    this.isDanger = false,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isDanger ? AppColors.danger : AppColors.success;
    final icon = isDanger ? Icons.warning_amber_rounded : Icons.check_circle;
    final iconColor = isDanger ? AppColors.textDanger : AppColors.textSuccess;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 32),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                count,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: iconColor,
                ),
              ),
              Text(
                label,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
