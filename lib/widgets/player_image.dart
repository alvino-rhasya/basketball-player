import 'package:flutter/material.dart';

class PlayerImage extends StatelessWidget {
  final String imageUrl;
  final String playerName;
  final bool isCircle;
  final double? width;
  final double? height;
  final double borderRadius;
  final Color? teamColor;
  final Color? accentColor;
  final String? jerseyNumber;
  final String? heroTag;

  const PlayerImage({
    super.key,
    required this.imageUrl,
    required this.playerName,
    this.isCircle = true,
    this.width,
    this.height,
    this.borderRadius = 24.0,
    this.teamColor,
    this.accentColor,
    this.jerseyNumber,
    this.heroTag,
  });

  String _getInitials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return 'B';
    if (parts.length == 1) return parts[0].substring(0, 1).toUpperCase();
    return '${parts[0][0]}${parts[parts.length - 1][0]}'.toUpperCase();
  }

  bool _isRealUrl(String url) {
    return url.startsWith('http://') ||
        url.startsWith('https://') ||
        url.startsWith('assets/');
  }

  @override
  Widget build(BuildContext context) {
    final initials = _getInitials(playerName);
    final primaryTeam = teamColor ?? const Color(0xFF1B2030);
    final accent = accentColor ?? const Color(0xFFFF6B00);

    Widget imageContent;

    if (isCircle) {
      final size = width ?? 64.0;
      imageContent = Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              primaryTeam.withValues(alpha: 0.8),
              const Color(0xFF0D0F16),
            ],
            center: const Alignment(0, -0.2),
          ),
          border: Border.all(
            color: accent.withValues(alpha: 0.6),
            width: 2.0,
          ),
          boxShadow: [
            BoxShadow(
              color: accent.withValues(alpha: 0.25),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipOval(
          child: _isRealUrl(imageUrl)
              ? _buildRealImage(BoxFit.contain, primaryTeam, accent)
              : _buildCirclePlaceholder(size, initials, accent),
        ),
      );
    } else {
      // Large Hero / Detail Screen View
      imageContent = Container(
        width: width ?? double.infinity,
        height: height ?? 280.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          gradient: RadialGradient(
            colors: [
              primaryTeam.withValues(alpha: 0.85),
              const Color(0xFF0F121C),
              const Color(0xFF08090D),
            ],
            radius: 1.1,
            center: const Alignment(0, -0.3),
          ),
          border: Border.all(
            color: accent.withValues(alpha: 0.4),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: accent.withValues(alpha: 0.2),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.6),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Subtle background basketball court watermark
              Positioned(
                bottom: -30,
                right: -30,
                child: Icon(
                  Icons.sports_basketball,
                  size: 200,
                  color: Colors.white.withValues(alpha: 0.04),
                ),
              ),
              // Background Jersey Number Watermark
              if (jerseyNumber != null)
                Positioned(
                  top: 16,
                  left: 20,
                  child: Text(
                    '#$jerseyNumber',
                    style: TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.w900,
                      color: Colors.white.withValues(alpha: 0.05),
                      letterSpacing: -2,
                    ),
                  ),
                ),
              // Real Player Headshot or Placeholder
              _isRealUrl(imageUrl)
                  ? _buildRealImage(BoxFit.contain, primaryTeam, accent)
                  : _buildRectanglePlaceholder(initials, accent),
            ],
          ),
        ),
      );
    }

    if (heroTag != null) {
      return Hero(
        tag: heroTag!,
        child: imageContent,
      );
    }

    return imageContent;
  }

  Widget _buildRealImage(BoxFit fit, Color bg, Color accent) {
    if (imageUrl.startsWith('assets/')) {
      return Image.asset(
        imageUrl,
        fit: fit,
        errorBuilder: (context, error, stackTrace) =>
            _buildFallbackError(accent),
      );
    }

    return Image.network(
      imageUrl,
      fit: fit,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Center(
          child: SizedBox(
            width: 28,
            height: 28,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: accent,
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) =>
          _buildFallbackError(accent),
    );
  }

  Widget _buildFallbackError(Color accent) {
    if (isCircle) {
      return _buildCirclePlaceholder(width ?? 64.0, _getInitials(playerName), accent);
    }
    return Container(
      color: const Color(0xFF141722),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.sports_basketball_outlined,
              color: accent.withValues(alpha: 0.6),
              size: 36,
            ),
            const SizedBox(height: 4),
            Text(
              _getInitials(playerName),
              style: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCirclePlaceholder(double size, String initials, Color accent) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            accent.withValues(alpha: 0.4),
            const Color(0xFF141724),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Text(
          initials,
          style: TextStyle(
            fontSize: size * 0.38,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildRectanglePlaceholder(String initials, Color accent) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [accent, accent.withValues(alpha: 0.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: accent.withValues(alpha: 0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              initials,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.sports_basketball,
                  size: 16,
                  color: Color(0xFFFF9E40),
                ),
                SizedBox(width: 8),
                Text(
                  'FOTO PEMAIN BASKET',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.8,
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
