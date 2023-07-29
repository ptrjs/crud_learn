// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:collection/collection.dart';
import 'package:crud_learn/controllers/user_controller.dart';
import 'package:crud_learn/models/user.dart';
import 'package:flutter/material.dart';

class DetailUserPage extends StatefulWidget {
  final int id;
  DetailUserPage({required this.id});

  @override
  State<DetailUserPage> createState() => _DetailUserPageState();
}

class _DetailUserPageState extends State<DetailUserPage> {
  final UserController userController = UserController();
  bool isLoading = true;
  User? user;
  @override
  void initState() {
    super.initState();
    fetchUserById();
  }

  Future<void> fetchUserById() async {
    setState(() {
      isLoading = true;
    });
    await userController.fetchUsers(); // Pastikan data users sudah diambil

    setState(() {
      user =
          userController.users.firstWhereOrNull((user) => user.id == widget.id);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("User Detail"),
          actions: const [],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                if (isLoading) CircularProgressIndicator(),
                if (!isLoading)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name: ${user?.name}"),
                      Text("Age: ${user?.age}"),
                      Text("Address: ${user?.address}"),
                    ],
                  ),
              ],
            ),
          ),
        ));
  }
}
