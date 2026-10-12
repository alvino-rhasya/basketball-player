import 'package:flutter/material.dart';
import '../data/player_data.dart';
import '../models/player.dart';
import '../widgets/court_background.dart';
import '../widgets/player_card.dart';
import 'player_detail_screen.dart';

class PlayerListScreen extends StatefulWidget {
  const PlayerListScreen({super.key});

  @override
  State<PlayerListScreen> createState() => _PlayerListScreenState();
}

class _PlayerListScreenState extends State<PlayerListScreen> {
  late final List<Player> _players;
  bool _filterFavoritesOnly = false;
  String _searchQuery = '';
  String _selectedPositionFilter = 'All';

  final List<String> _positionFilters = [
    'All',
    'Point Guard',
    'Shooting Guard',
    'Small Forward',
    'Power Forward',
    'Center',
  ];

  @override
  void initState() {
    super.initState();
    _players = getInitialPlayers();
  }

  void _toggleFavorite(Player player) {
    setState(() {
      player.isFavorite = !player.isFavorite;
    });
  }

  void _navigateToDetail(Player player) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PlayerDetailScreen(
          player: player,
          onFavoriteToggle: () {
            setState(() {});
          },
        ),
      ),
    ).then((_) {
      setState(() {});
    });
  }

  List<Player> _getFilteredPlayers() {
    return _players.where((player) {
      if (_filterFavoritesOnly && !player.isFavorite) {
        return false;
      }
      if (_selectedPositionFilter != 'All' &&
          !player.position.contains(_selectedPositionFilter)) {
        return false;
      }
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        final matchesName = player.name.toLowerCase().contains(query);
        final matchesTeam = player.team.toLowerCase().contains(query);
        final matchesNickname = player.nickname.toLowerCase().contains(query);
        final matchesJersey = player.jerseyNumber.contains(query);
        if (!matchesName && !matchesTeam && !matchesNickname && !matchesJersey) {
          return false;
        }
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final displayedPlayers = _getFilteredPlayers();
    final favoriteCount = _players.where((p) => p.isFavorite).length;

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
          onPressed: () {
            if (_filterFavoritesOnly || _selectedPositionFilter != 'All' || _searchQuery.isNotEmpty) {
              setState(() {
                _filterFavoritesOnly = false;
                _selectedPositionFilter = 'All';
                _searchQuery = '';
              });
            }
          },
          tooltip: 'Navigation',
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: const Color(0xFFFF6B00).withValues(alpha: 0.15),
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFFF6B00).withValues(alpha: 0.4),
                  width: 1.0,
                ),
              ),
              child: const Icon(
                Icons.sports_basketball,
                color: Color(0xFFFF7A1A),
                size: 20,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Basketball Players',
              style: TextStyle(
                color: Colors.white,
                fontSize: 19.5,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          // Heart icon with badge
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: Icon(
                  _filterFavoritesOnly
                      ? Icons.favorite
                      : Icons.favorite_border_rounded,
                  color: _filterFavoritesOnly
                      ? const Color(0xFFFF3366)
                      : Colors.white70,
                  size: 24,
                ),
                onPressed: () {
                  setState(() {
                    _filterFavoritesOnly = !_filterFavoritesOnly;
                  });
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: const Color(0xFF1E2333),
                      content: Text(
                        _filterFavoritesOnly
                            ? 'Menampilkan $favoriteCount pemain favorit 🏀'
                            : 'Menampilkan semua pemain',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      duration: const Duration(seconds: 1),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(
                          color: Color(0xFFFF6B00),
                          width: 1,
                        ),
                      ),
                    ),
                  );
                },
                tooltip: _filterFavoritesOnly
                    ? 'Tampilkan Semua Pemain'
                    : 'Filter Pemain Favorit',
              ),
              if (favoriteCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF3366),
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$favoriteCount',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9.5,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: CourtBackground(
        child: Column(
          children: [
            // Search Input & Filter Chips Section
            Padding(
              padding: const EdgeInsets.fromLTRB(14.0, 4.0, 14.0, 6.0),
              child: Container(
                height: 44.0,
                decoration: BoxDecoration(
                  color: const Color(0xFF141722),
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.1),
                    width: 1.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: TextField(
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                  onChanged: (val) {
                    setState(() {
                      _searchQuery = val;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Cari pemain, tim, atau nomor (#)...',
                    hintStyle: TextStyle(
                      color: Colors.white.withValues(alpha: 0.4),
                      fontSize: 13.5,
                    ),
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: Color(0xFFFF7A1A),
                      size: 20,
                    ),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(
                              Icons.close_rounded,
                              color: Colors.white54,
                              size: 18,
                            ),
                            onPressed: () {
                              setState(() {
                                _searchQuery = '';
                              });
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 11.0),
                  ),
                ),
              ),
            ),

            // Horizontal Position Filter Chips
            SizedBox(
              height: 42.0,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: _positionFilters.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8.0),
                itemBuilder: (context, index) {
                  final pos = _positionFilters[index];
                  final isSelected = _selectedPositionFilter == pos;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedPositionFilter = pos;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14.0,
                        vertical: 8.0,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFFF6B00)
                            : const Color(0xFF141722),
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFFFF8F00)
                              : Colors.white.withValues(alpha: 0.1),
                          width: 1.2,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: const Color(0xFFFF6B00)
                                      .withValues(alpha: 0.4),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : [],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        pos,
                        style: TextStyle(
                          color: isSelected ? Colors.black : Colors.white70,
                          fontSize: 12.0,
                          fontWeight:
                              isSelected ? FontWeight.w800 : FontWeight.w600,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 6.0),

            // Player List or Empty State
            Expanded(
              child: displayedPlayers.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                color: const Color(0xFF161A25),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFFFF6B00)
                                      .withValues(alpha: 0.3),
                                  width: 1.5,
                                ),
                              ),
                              child: const Icon(
                                Icons.sports_basketball_outlined,
                                size: 54,
                                color: Color(0xFFFF7A1A),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _filterFavoritesOnly
                                  ? 'Belum ada pemain favorit'
                                  : 'Pemain tidak ditemukan',
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              _filterFavoritesOnly
                                  ? 'Ketuk ikon hati pada pemain untuk menambahkannya ke favorit'
                                  : 'Coba ubah kata kunci pencarian atau filter posisi',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF94A3B8),
                              ),
                            ),
                            const SizedBox(height: 14),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFF6B00),
                                foregroundColor: Colors.black,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  _filterFavoritesOnly = false;
                                  _selectedPositionFilter = 'All';
                                  _searchQuery = '';
                                });
                              },
                              icon: const Icon(Icons.refresh_rounded, size: 18),
                              label: const Text(
                                'Lihat semua pemain',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(top: 4.0, bottom: 20.0),
                      itemCount: displayedPlayers.length,
                      itemBuilder: (context, index) {
                        final player = displayedPlayers[index];
                        return PlayerCard(
                          key: ValueKey(player.id),
                          player: player,
                          onTap: () => _navigateToDetail(player),
                          onFavoriteToggle: () => _toggleFavorite(player),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
