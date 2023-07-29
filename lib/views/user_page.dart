// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:crud_learn/controllers/user_controller.dart';
import 'package:crud_learn/views/add_user_page.dart';
import 'package:crud_learn/views/detail_user_page.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';
import 'edit_user_page.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final UserController userController = UserController();
  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    await userController.fetchUsers();
    setState(() {});
  }

  void navigateToDetailUser(BuildContext context, int? id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailUserPage(id: id ?? 0),
      ),
    );
  }

  void navigateToAddUser(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddUserPage(),
      ),
    );
  }

  void navigateToEditUser(BuildContext context, int? id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditUserPage(id: id ?? 0),
      ),
    );
  }

  Future<void> confirmDeleteUser(BuildContext context, int? id) async {
    bool shouldDelete = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete User"),
        content: Text("Are you sure you want to delete this user?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              deleteUser(id);
            },
            child: Text("Delete"),
          ),
        ],
      ),
    );

    if (shouldDelete) {
      await userController.deleteUser(id ?? 0);
    }
  }

  Future<void> deleteUser(int? id) async {
    try {
      await userController.deleteUser(id ?? 0);
      setState(() {
        fetchUsers();
      });
    } catch (e) {
      print("Failed delete user: {$e}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User List"),
        actions: const [],
      ),
      body: ListView.builder(
        itemCount: userController.users.length,
        physics: const ScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          final user = userController.users[index];
          return InkWell(
            onTap: () => navigateToDetailUser(context, user.id),
            child: ListTile(
              title: Text("Name: ${user.name}"),
              subtitle: Text(
                "Age: ${user.age}",
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    color: Colors.yellow,
                    child: IconButton(
                      onPressed: () => navigateToEditUser(context, user.id),
                      icon: Icon(
                        Icons.edit,
                        size: 36,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 60,
                    height: 60,
                    color: Colors.red,
                    child: IconButton(
                      onPressed: () => confirmDeleteUser(context, user.id),
                      icon: Icon(
                        Icons.delete,
                        size: 36,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToAddUser(context);
        },
        child: const Icon(
          Icons.add,
          size: 24.0,
        ),
      ),
    );
  }
}
