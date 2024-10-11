import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String name;
  final String email;
  final int coins;
  final int redeemedCoins;
  final String? photoUrl;
  final String? provider;
  final Timestamp createdAt = Timestamp.now();

  User({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    this.provider,
    this.coins = 0,
    this.redeemedCoins = 0,
  });

  factory User.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return User(
      id: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      photoUrl: data['photo_url'],
      provider: data['provider'],
      coins: data['coins'] ?? 0,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'provider': provider,
      'coins': coins,
    };
  }

  //from json
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      photoUrl: json['photo_url'],
      provider: json['provider'],
      coins: json['coins'] ?? 0,
      redeemedCoins: json['redeemed_coins'] ?? 0,
    );
  }

  //to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'provider': provider,
      'coins': coins,
      'redeemed_coins': redeemedCoins,
    };
  }
}
