import 'package:flutter/material.dart';

enum UserRole {
  member,
  trainer,
  admin
}

class User {
  final String id;
  final String name;
  final String email;
  final UserRole role;
  final String? profileImage;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.profileImage,
  });

  bool get isTrainer => role == UserRole.trainer;
  bool get isAdmin => role == UserRole.admin;
}

class UserService {
  // Singleton
  static final UserService _instance = UserService._internal();
  factory UserService() => _instance;
  UserService._internal();

  // Current User State
  final ValueNotifier<User?> currentUserNotifier = ValueNotifier<User?>(
    User(
      id: "1", 
      name: "Ahmet Yılmaz", 
      email: "ahmet@gmail.com", 
      role: UserRole.member // Default role
    )
  );

  User? get currentUser => currentUserNotifier.value;

  void login(String email, String password) {
    // Mock login logic
    // In a real app, this would hit an API
    if (email.contains("admin")) {
      currentUserNotifier.value = User(id: "2", name: "Admin User", email: email, role: UserRole.admin);
    } else if (email.contains("trainer")) {
      currentUserNotifier.value = User(id: "3", name: "Coach Mike", email: email, role: UserRole.trainer);
    } else {
      currentUserNotifier.value = User(id: "1", name: "Ahmet Yılmaz", email: email, role: UserRole.member);
    }
  }

  void logout() {
    currentUserNotifier.value = null;
  }

  void updateProfile({String? name, String? email}) {
    if (currentUser != null) {
      currentUserNotifier.value = User(
        id: currentUser!.id,
        name: name ?? currentUser!.name,
        email: email ?? currentUser!.email,
        role: currentUser!.role,
        profileImage: currentUser!.profileImage,
      );
    }
  }
}
