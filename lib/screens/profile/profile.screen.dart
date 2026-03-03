import 'package:fb_test2/screens/home/home.screen.dart';
import 'package:fb_test2/services/user/user.service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const String routeName = '/profile';
  static Function(BuildContext context) push = (context) =>
      context.push(routeName);
  static Function(BuildContext context) go = (context) => context.go(routeName);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final nicknameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: "name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "name is required";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: nicknameController,
                decoration: InputDecoration(labelText: "nickname"),
                validator: (value) {
                  if (value != null && value.isNotEmpty && value.length < 3) {
                    return "Nickname must at least 3 characters";
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    try {
                      await UserService.instance.updateUser(
                        name: nameController.text,
                        nickname: nicknameController.text,
                      );
                      if (context.mounted) {
                        HomeScreen.go(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Profile Updated")),
                        );
                      }
                    } catch (error) {
                      debugPrint(error.toString());
                    }
                  }
                },
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
