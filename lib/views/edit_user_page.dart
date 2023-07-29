// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:collection/collection.dart';
import 'package:crud_learn/views/user_page.dart';
import 'package:flutter/material.dart';

import '../controllers/user_controller.dart';
import '../models/user.dart';

class EditUserPage extends StatefulWidget {
  final int id;
  EditUserPage({required this.id});

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  bool isLoading = true;
  final UserController userController = UserController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set initial values for text fields based on user data
    fetchUserById();
  }

  Future<void> fetchUserById() async {
    setState(() {
      isLoading = true;
    });
    await userController.fetchUsers(); // Pastikan data users sudah diambil

    setState(() {
      User? user =
          userController.users.firstWhere((user) => user.id == widget.id);
      nameController.text = user.name;
      ageController.text = user.age;
      addressController.text = user.address;
      isLoading = false;
    });
  }

  void updateUser() async {
    String name = nameController.text;
    String age = ageController.text;
    String address = addressController.text;

    User updatedUser = User(
      id: widget.id,
      name: name,
      age: age,
      address: address,
    );

    bool success = await userController.updateUser(updatedUser);

    if (success) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Error"),
          content: Text("Failed to update user data."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Success"),
          content: Text("User data updated successfully."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserPage(),
                  ),
                );

                userController.fetchUsers();
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit User"),
        actions: const [],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            if (isLoading) CircularProgressIndicator(),
            if (!isLoading)
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(),
                child: TextFormField(
                  controller: nameController,
                  maxLength: 20,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(
                      color: Colors.blueGrey,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                      ),
                    ),
                    helperText: "What's your name?",
                  ),
                  onChanged: (value) {},
                ),
              ),
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(),
              child: TextFormField(
                controller: ageController,
                maxLength: 20,
                decoration: const InputDecoration(
                  labelText: 'Age',
                  labelStyle: TextStyle(
                    color: Colors.blueGrey,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                    ),
                  ),
                  helperText: "What's your age?",
                ),
                onChanged: (value) {},
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(),
              child: TextFormField(
                controller: addressController,
                maxLength: 20,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  labelStyle: TextStyle(
                    color: Colors.blueGrey,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                    ),
                  ),
                  helperText: "What's your Address?",
                ),
                onChanged: (value) {},
              ),
            ),
            ElevatedButton(
              onPressed: updateUser,
              child: Text("Edit User"),
            ),
          ],
        ),
      ),
    );
  }
}
