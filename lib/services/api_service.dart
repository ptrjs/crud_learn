import 'package:crud_learn/models/user.dart';
import 'package:dio/dio.dart';

class ApiService {
  static const baseUrl = 'https://capekngoding.com/6285390565586/api';
  Dio dio = Dio();

  Future<List<User>> fetchUsers() async {
    try {
      final response = await dio.get('$baseUrl/users');

      final List<dynamic> jsonData = response.data['data'];
      return jsonData.map((json) => User.fromJson(json)).toList();
    } catch (e) {
      print('Error while fetching users: $e');

      throw Exception('Failed to load users');
    }
  }

  Future<User> addUser(User user) async {
    try {
      final response = await dio.post('$baseUrl/users', data: user.toJson());
      return User.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to add user');
    }
  }

  Future<User> updateUser(int userId, Map<String, dynamic> data) async {
    try {
      final response = await dio.post('$baseUrl/users/$userId', data: data);
      return User.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update user');
    }
  }

  Future<void> deleteUser(int userId) async {
    try {
      await dio.delete('$baseUrl/users/$userId');
    } catch (e) {
      throw Exception('Failed to delete user');
    }
  }
}
