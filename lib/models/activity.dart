import 'package:capusle_rewards/models/project.dart';

class Activity {
  final DateTime joinedAt;
  int creditedCoins;
  Project? project;

  Activity({
    required this.joinedAt,
    this.creditedCoins = 0,
    this.project,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      joinedAt: DateTime.parse(json['joined_at']),
      creditedCoins: json['credited_coins'],
      project:
          json['project'] != null ? Project.fromJson(json['project']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'joined_at': joinedAt.toIso8601String(),
      'credited_coins': creditedCoins,
    };
  }
}
