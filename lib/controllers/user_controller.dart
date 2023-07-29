import 'package:crud_learn/models/user.dart';

import '../services/api_service.dart';

class UserController {
  List<User> users = [];
  final ApiService apiService = ApiService();

  Future<void> fetchUsers() async {
    try {
      users = await apiService.fetchUsers();
    } catch (e) {
      print('Error while fetching users: $e');
      users = [];
    }
  }

  Future<bool> addUsers(User user) async {
    try {
      final newUsers = await apiService.addUser(user);
      users.add(newUsers);
      print('Success add users');
      return true;
    } catch (e) {
      print('Error while add users: $e');
      return false;
    }
  }

  Future<bool> updateUser(User user) async {
    try {
      await apiService.updateUser(user.id!, user.toJson());
      fetchUsers(); // Refresh user list after update
      return true;
    } catch (e) {
      print('Error while updating user: $e');
      return false;
    }
  }

  Future<void> deleteUser(int userId) async {
    try {
      await apiService.deleteUser(userId);
      users.removeWhere((user) => user.id == userId);
      print('Success delete user');
    } catch (e) {
      print('Error while deleting user: $e');
      throw Exception('Failed to delete user');
    }
  }
}
