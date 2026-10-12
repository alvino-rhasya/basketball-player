import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;
  final Color accentColor;

  const StatCard({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.accentColor = const Color(0xFFFF6B00),
  });

  double _calculateProgress(String label, String valueStr) {
    final val = double.tryParse(valueStr) ?? 0.0;
    switch (label.toLowerCase()) {
      case 'points':
        return (val / 35.0).clamp(0.0, 1.0);
      case 'rebounds':
        return (val / 15.0).clamp(0.0, 1.0);
      case 'assists':
        return (val / 12.0).clamp(0.0, 1.0);
      case 'steals':
        return (val / 3.0).clamp(0.0, 1.0);
      default:
        return 0.75;
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = _calculateProgress(label, value);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: const Color(0xFF141722),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: accentColor.withValues(alpha: 0.35),
                      width: 1.0,
                    ),
                  ),
                  child: Icon(
                    icon,
                    size: 18,
                    color: accentColor,
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF94A3B8),
                    letterSpacing: 0.2,
                  ),
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          // Visual Stat Meter
          ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: Stack(
              children: [
                Container(
                  height: 6.0,
                  width: double.infinity,
                  color: Colors.white.withValues(alpha: 0.06),
                ),
                FractionallySizedBox(
                  widthFactor: progress,
                  child: Container(
                    height: 6.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          accentColor.withValues(alpha: 0.6),
                          accentColor,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(4.0),
                      boxShadow: [
                        BoxShadow(
                          color: accentColor.withValues(alpha: 0.5),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
