import 'package:flutter/material.dart';
import '../models/player.dart';
import 'player_image.dart';
import 'position_badge.dart';

class PlayerCard extends StatelessWidget {
  final Player player;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;

  const PlayerCard({
    super.key,
    required this.player,
    required this.onTap,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: const Color(0xFF141722),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: player.accentColor.withValues(alpha: 0.22),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: player.accentColor.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20.0),
          splashColor: player.accentColor.withValues(alpha: 0.12),
          highlightColor: Colors.white.withValues(alpha: 0.04),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left: Player Avatar with Team Glow Ring and Hero transition
                PlayerImage(
                  imageUrl: player.imageUrl,
                  playerName: player.name,
                  isCircle: true,
                  width: 68.0,
                  height: 68.0,
                  teamColor: player.teamColor,
                  accentColor: player.accentColor,
                  jerseyNumber: player.jerseyNumber,
                  heroTag: 'player_avatar_${player.id}',
                ),
                const SizedBox(width: 14.0),

                // Middle: Player Info & Basketball Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Top Row: Jersey Number + Nickname
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6.0,
                              vertical: 2.0,
                            ),
                            decoration: BoxDecoration(
                              color: player.accentColor.withValues(alpha: 0.18),
                              borderRadius: BorderRadius.circular(6.0),
                              border: Border.all(
                                color: player.accentColor.withValues(alpha: 0.4),
                                width: 1.0,
                              ),
                            ),
                            child: Text(
                              '#${player.jerseyNumber}',
                              style: TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w800,
                                color: player.accentColor,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          if (player.nickname.isNotEmpty) ...[
                            const SizedBox(width: 6.0),
                            Flexible(
                              child: Text(
                                '"${player.nickname}"',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xFF94A3B8),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4.0),

                      // Player Name
                      Text(
                        player.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(height: 3.0),

                      // Team Name
                      Text(
                        player.team,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF94A3B8).withValues(alpha: 0.9),
                        ),
                      ),
                      const SizedBox(height: 8.0),

                      // Position Badge & Mini Stats Row
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children: [
                          PositionBadge(
                            position: player.position,
                            isExpanded: false,
                            height: 26.0,
                            fontSize: 11.0,
                          ),
                          Text(
                            '${player.stats.points.toStringAsFixed(1)} PTS • ${player.stats.assists.toStringAsFixed(1)} AST',
                            style: const TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFCBD5E1),
                              letterSpacing: 0.2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10.0),

                // Right: OVR Power Badge + Favorite Heart Button
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // OVR Rating Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFFFFB300),
                            const Color(0xFFFF8F00),
                          ],
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
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${player.basePower}',
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF161105),
                              height: 1.1,
                            ),
                          ),
                          const Text(
                            'OVR',
                            style: TextStyle(
                              fontSize: 9.0,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF161105),
                              letterSpacing: 0.5,
                              height: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12.0),

                    // Favorite Button
                    IconButton(
                      icon: Icon(
                        player.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border_rounded,
                        color: player.isFavorite
                            ? const Color(0xFFFF3366)
                            : const Color(0xFF64748B),
                        size: 24.0,
                      ),
                      onPressed: onFavoriteToggle,
                      splashRadius: 22.0,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      tooltip: player.isFavorite
                          ? 'Remove from Favorites'
                          : 'Add to Favorites',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
