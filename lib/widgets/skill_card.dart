import 'package:flutter/material.dart';

class SkillCard extends StatelessWidget {
  final String skillName;

  const SkillCard({
    super.key,
    required this.skillName,
  });

  IconData _getSkillIcon(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('shoot') || lower.contains('three') || lower.contains('release') || lower.contains('range')) {
      return Icons.crisis_alert_rounded;
    }
    if (lower.contains('pass') || lower.contains('vision') || lower.contains('floor') || lower.contains('maestro')) {
      return Icons.visibility_rounded;
    }
    if (lower.contains('dunk') || lower.contains('athletic') || lower.contains('freak') || lower.contains('fastbreak')) {
      return Icons.bolt_rounded;
    }
    if (lower.contains('defense') || lower.contains('block') || lower.contains('anchor') || lower.contains('rebound')) {
      return Icons.shield_rounded;
    }
    if (lower.contains('handle') || lower.contains('finishing') || lower.contains('layup')) {
      return Icons.fingerprint_rounded;
    }
    if (lower.contains('scoring') || lower.contains('gravity') || lower.contains('lethality')) {
      return Icons.local_fire_department_rounded;
    }
    return Icons.sports_basketball_rounded;
  }

  @override
  Widget build(BuildContext context) {
    final iconData = _getSkillIcon(skillName);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 11.0),
      decoration: BoxDecoration(
        color: const Color(0xFF141722),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: const Color(0xFFFFB300).withValues(alpha: 0.25),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Badge Icon Container
          Container(
            padding: const EdgeInsets.all(7.0),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFB300), Color(0xFFFF8F00)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF8F00).withValues(alpha: 0.35),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Icon(
              iconData,
              size: 18.0,
              color: const Color(0xFF14110A),
            ),
          ),
          const SizedBox(width: 12.0),
          // Skill Title
          Expanded(
            child: Text(
              skillName,
              style: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 0.2,
              ),
            ),
          ),
          // Preserved Star Icon + "SIGNATURE" Tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.5),
            decoration: BoxDecoration(
              color: const Color(0xFFFFB300).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: const Color(0xFFFFB300).withValues(alpha: 0.35),
                width: 1.0,
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star,
                  size: 13.0,
                  color: Color(0xFFFFC107),
                ),
                SizedBox(width: 4.0),
                Text(
                  'SIGNATURE',
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFFFC107),
                    letterSpacing: 0.6,
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
