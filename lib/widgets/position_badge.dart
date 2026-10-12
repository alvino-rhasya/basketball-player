import 'package:flutter/material.dart';

class PositionTheme {
  final Color background;
  final Color border;
  final Color text;
  final String shortCode;
  final IconData icon;

  const PositionTheme({
    required this.background,
    required this.border,
    required this.text,
    required this.shortCode,
    required this.icon,
  });

  static PositionTheme getForPosition(String position) {
    switch (position) {
      case 'Point Guard':
        return const PositionTheme(
          background: Color(0x1F00B4D8),
          border: Color(0x8000B4D8),
          text: Color(0xFF38BDF8),
          shortCode: 'PG',
          icon: Icons.sports_basketball_outlined,
        );
      case 'Shooting Guard':
        return const PositionTheme(
          background: Color(0x26FF6B00),
          border: Color(0x80FF6B00),
          text: Color(0xFFFF9E40),
          shortCode: 'SG',
          icon: Icons.local_fire_department_outlined,
        );
      case 'Small Forward':
        return const PositionTheme(
          background: Color(0x1F10B981),
          border: Color(0x8010B981),
          text: Color(0xFF34D399),
          shortCode: 'SF',
          icon: Icons.flash_on_outlined,
        );
      case 'Power Forward':
        return const PositionTheme(
          background: Color(0x268B5CF6),
          border: Color(0x808B5CF6),
          text: Color(0xFFA78BFA),
          shortCode: 'PF',
          icon: Icons.shield_outlined,
        );
      case 'Center':
        return const PositionTheme(
          background: Color(0x26EF4444),
          border: Color(0x80EF4444),
          text: Color(0xFFF87171),
          shortCode: 'C',
          icon: Icons.vertical_align_top_rounded,
        );
      case 'Point Guard / Shooting Guard':
        return const PositionTheme(
          background: Color(0x2206B6D4),
          border: Color(0x8006B6D4),
          text: Color(0xFF22D3EE),
          shortCode: 'G',
          icon: Icons.sports_basketball_rounded,
        );
      case 'Small Forward / Power Forward':
        return const PositionTheme(
          background: Color(0x26F59E0B),
          border: Color(0x80F59E0B),
          text: Color(0xFFFBBF24),
          shortCode: 'F',
          icon: Icons.bolt_rounded,
        );
      default:
        return const PositionTheme(
          background: Color(0x2294A3B8),
          border: Color(0x6694A3B8),
          text: Color(0xFFCBD5E1),
          shortCode: 'ATH',
          icon: Icons.sports_basketball,
        );
    }
  }
}

class PositionBadge extends StatelessWidget {
  final String position;
  final bool isExpanded;
  final double height;
  final double fontSize;
  final bool showIcon;

  const PositionBadge({
    super.key,
    required this.position,
    this.isExpanded = false,
    this.height = 32.0,
    this.fontSize = 12.5,
    this.showIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = PositionTheme.getForPosition(position);

    Widget badgeContent = Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: theme.background,
        borderRadius: BorderRadius.circular(height / 2),
        border: Border.all(
          color: theme.border,
          width: 1.2,
        ),
      ),
      child: Row(
        mainAxisSize: isExpanded ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment:
            isExpanded ? MainAxisAlignment.start : MainAxisAlignment.center,
        children: [
          if (showIcon) ...[
            Icon(
              theme.icon,
              size: fontSize + 2.5,
              color: theme.text,
            ),
            const SizedBox(width: 6.0),
          ],
          Flexible(
            child: Text(
              position,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: theme.text,
                fontSize: fontSize,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ],
      ),
    );

    if (isExpanded) {
      return SizedBox(
        width: double.infinity,
        child: badgeContent,
      );
    }

    return badgeContent;
  }
}
