import 'package:capusle_rewards/models/activity.dart';

class ActivityResponse {
  final List<Activity> activities;

  ActivityResponse({required this.activities});

  factory ActivityResponse.fromJson(Map<String, dynamic> json) {
    return ActivityResponse(
      activities: (json['activities'] as List)
          .map((i) => Activity.fromJson(i))
          .toList(),
    );
  }
}
