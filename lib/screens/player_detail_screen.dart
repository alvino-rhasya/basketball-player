import 'package:flutter/material.dart';
import '../models/player.dart';
import '../widgets/court_background.dart';
import '../widgets/player_image.dart';
import '../widgets/position_badge.dart';
import '../widgets/skill_card.dart';
import '../widgets/stat_card.dart';

class PlayerDetailScreen extends StatefulWidget {
  final Player player;
  final VoidCallback onFavoriteToggle;

  const PlayerDetailScreen({
    super.key,
    required this.player,
    required this.onFavoriteToggle,
  });

  @override
  State<PlayerDetailScreen> createState() => _PlayerDetailScreenState();
}

class _PlayerDetailScreenState extends State<PlayerDetailScreen> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.player.isFavorite;
  }

  void _handleFavoriteToggle() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    widget.onFavoriteToggle();

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF1E2333),
        content: Text(
          _isFavorite
              ? '${widget.player.name} ditambahkan ke favorit! 🏀'
              : '${widget.player.name} dihapus dari favorit',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: widget.player.accentColor,
            width: 1,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final player = widget.player;

    return Scaffold(
      backgroundColor: const Color(0xFF0C0E14),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C0E14),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Back',
        ),
        title: Text(
          player.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 19.0,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.2,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border_rounded,
              color: _isFavorite
                  ? const Color(0xFFFF3366)
                  : Colors.white70,
              size: 26,
            ),
            onPressed: _handleFavoriteToggle,
            tooltip: _isFavorite ? 'Favorited' : 'Favorite',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: CourtBackground(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 6),

              // Super Showcase Headshot / Card Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Stack(
                  children: [
                    PlayerImage(
                      imageUrl: player.imageUrl,
                      playerName: player.name,
                      isCircle: false,
                      height: 300.0,
                      borderRadius: 26.0,
                      teamColor: player.teamColor,
                      accentColor: player.accentColor,
                      jerseyNumber: player.jerseyNumber,
                      heroTag: 'player_avatar_${player.id}',
                    ),
                    // Floating Jersey Number & Nickname Top Left
                    Positioned(
                      top: 14,
                      left: 14,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 5.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.75),
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(
                            color: player.accentColor.withValues(alpha: 0.6),
                            width: 1.2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.4),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '#${player.jerseyNumber}',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w900,
                                color: player.accentColor,
                                letterSpacing: 0.5,
                              ),
                            ),
                            if (player.nickname.isNotEmpty) ...[
                              const SizedBox(width: 8.0),
                              Text(
                                player.nickname,
                                style: const TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    // Floating OVR Rating Top Right
                    Positioned(
                      top: 14,
                      right: 14,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 6.0,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFFB300), Color(0xFFFF8F00)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFF8F00).withValues(alpha: 0.4),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.bolt_rounded,
                              size: 16,
                              color: Color(0xFF14110A),
                            ),
                            const SizedBox(width: 2),
                            Text(
                              '${player.basePower}',
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF14110A),
                              ),
                            ),
                            const SizedBox(width: 3),
                            const Text(
                              'OVR',
                              style: TextStyle(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF14110A),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // Main Details Card Container
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 14.0),
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF141722),
                  borderRadius: BorderRadius.circular(26.0),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.08),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.45),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Player Name Header
                    Text(
                      player.name,
                      style: const TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Position Badge & Team Row
                    Row(
                      children: [
                        PositionBadge(
                          position: player.position,
                          isExpanded: false,
                          height: 32.0,
                          fontSize: 13.0,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            player.team,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF94A3B8),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Base Power Row with Visual Power Bar
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0D0F16),
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(
                          color: const Color(0xFFFFB300).withValues(alpha: 0.3),
                          width: 1.2,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Base Power : ${player.basePower}',
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFFFFC107),
                                  letterSpacing: 0.3,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 3.0,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFB300).withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text(
                                  player.basePower >= 95 ? 'ALL-STAR MVP' : 'SUPERSTAR',
                                  style: const TextStyle(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFFFFB300),
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4.0),
                            child: Stack(
                              children: [
                                Container(
                                  height: 8.0,
                                  color: Colors.white.withValues(alpha: 0.08),
                                ),
                                FractionallySizedBox(
                                  widthFactor: (player.basePower / 100.0).clamp(0.0, 1.0),
                                  child: Container(
                                    height: 8.0,
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [Color(0xFFFFB300), Color(0xFFFF6B00)],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Quick Specs Bar (Height, Experience, Jersey)
                    Row(
                      children: [
                        _buildSpecItem('HEIGHT', player.height),
                        const SizedBox(width: 8),
                        _buildSpecItem('EXP', player.experience),
                        const SizedBox(width: 8),
                        _buildSpecItem('JERSEY', '#${player.jerseyNumber}'),
                      ],
                    ),

                    const SizedBox(height: 22),

                    // Profile Section
                    const Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 19.5,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      player.description,
                      style: const TextStyle(
                        fontSize: 14.5,
                        height: 1.55,
                        color: Color(0xFFCBD5E1),
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Stats Section
                    const Row(
                      children: [
                        Icon(
                          Icons.insights_rounded,
                          color: Color(0xFFFF7A1A),
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Stats',
                          style: TextStyle(
                            fontSize: 19.5,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    StatCard(
                      label: 'Points',
                      value: player.stats.points.toStringAsFixed(1),
                      icon: Icons.sports_basketball_outlined,
                      accentColor: const Color(0xFFFF6B00),
                    ),
                    const SizedBox(height: 8),
                    StatCard(
                      label: 'Rebounds',
                      value: player.stats.rebounds.toStringAsFixed(1),
                      icon: Icons.vertical_align_top_rounded,
                      accentColor: const Color(0xFF38BDF8),
                    ),
                    const SizedBox(height: 8),
                    StatCard(
                      label: 'Assists',
                      value: player.stats.assists.toStringAsFixed(1),
                      icon: Icons.handshake_outlined,
                      accentColor: const Color(0xFF34D399),
                    ),
                    const SizedBox(height: 8),
                    StatCard(
                      label: 'Steals',
                      value: player.stats.steals.toStringAsFixed(1),
                      icon: Icons.flash_on_outlined,
                      accentColor: const Color(0xFFA78BFA),
                    ),

                    const SizedBox(height: 24),

                    // Skills Section
                    const Row(
                      children: [
                        Icon(
                          Icons.military_tech_rounded,
                          color: Color(0xFFFFC107),
                          size: 22,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Skills',
                          style: TextStyle(
                            fontSize: 19.5,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Skill Cards List
                    ...player.skills.map((skill) => SkillCard(skillName: skill)),
                  ],
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpecItem(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: const Color(0xFF0D0F16),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.06),
            width: 1.0,
          ),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF64748B),
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 3.0),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
