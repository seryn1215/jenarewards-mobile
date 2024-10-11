import '../user.dart';

class FirebaseLoginResponse {
  User user;
  String token;

  FirebaseLoginResponse({
    required this.user,
    required this.token,
  });

  factory FirebaseLoginResponse.fromJson(Map<String, dynamic> json) {
    return FirebaseLoginResponse(
      user: User.fromJson(json['user']),
      token: json['token'],
    );
  }

  @override
  String toString() {
    return 'User: ${user.toString()}, Token: $token';
  }
}
