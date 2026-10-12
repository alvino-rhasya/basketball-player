import 'package:flutter/material.dart';

class PlayerStats {
  final double points;
  final double rebounds;
  final double assists;
  final double steals;

  const PlayerStats({
    required this.points,
    required this.rebounds,
    required this.assists,
    required this.steals,
  });
}

class Player {
  final String id;
  final String name;
  final String position;
  final String imageUrl; // Placeholder "ISI FOTO PEMAIN - ..." atau URL gambar
  final int basePower;
  final String description;
  final PlayerStats stats;
  final List<String> skills;
  bool isFavorite;

  // Atribut Tambahan Tema Basket
  final String jerseyNumber;
  final String team;
  final String nickname;
  final String height;
  final String experience;
  final Color teamColor;
  final Color accentColor;

  Player({
    required this.id,
    required this.name,
    required this.position,
    required this.imageUrl,
    required this.basePower,
    required this.description,
    required this.stats,
    required this.skills,
    this.isFavorite = false,
    this.jerseyNumber = '00',
    this.team = 'NBA',
    this.nickname = '',
    this.height = "6'6\"",
    this.experience = 'Pro',
    this.teamColor = const Color(0xFF1E2230),
    this.accentColor = const Color(0xFFFF6B00),
  });
}
