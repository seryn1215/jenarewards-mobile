import 'package:capusle_rewards/models/project.dart';

class ProjectsResponse {
  final List<Project> projects;

  ProjectsResponse({required this.projects});

  factory ProjectsResponse.fromJson(Map<String, dynamic> json) {
    return ProjectsResponse(
      projects:
          (json['projects'] as List).map((i) => Project.fromJson(i)).toList(),
    );
  }
}
