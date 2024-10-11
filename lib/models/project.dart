class Project {
  final int id;
  final String name;
  final int maxParticipants;
  final String qrCode;
  final String slug;
  final DateTime startDate;
  final DateTime endDate;
  final int coins;
  final int activityCount;
  bool get inProgress => DateTime.now().isBefore(endDate);

  Project({
    required this.id,
    required this.name,
    required this.maxParticipants,
    required this.qrCode,
    required this.slug,
    required this.startDate,
    required this.endDate,
    required this.activityCount,
    this.coins = 0,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      name: json['name'],
      maxParticipants: json['max_participants'],
      qrCode: json['qr_code'],
      slug: json['slug'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      coins: json['coins'] ?? 0,
      activityCount: json['activity_count'] ?? 0,
    );
  }
}
