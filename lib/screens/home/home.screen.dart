import 'package:fb_test2/screens/sign_in/sign_in.screen.dart';
import 'package:fb_test2/screens/sign_up/sign_up.screen.dart';
import 'package:fb_test2/services/user/user.service.dart';
import 'package:fb_test2/widgets/user/user_data.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String routeName = '/';
  static Function(BuildContext context) push = (context) =>
      context.push(routeName);
  static Function(BuildContext context) go = (context) => context.go(routeName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: UserData(
          no: () => Column(
            mainAxisSize: .min,
            children: [
              // No user :<
              ElevatedButton(
                onPressed: () {
                  SignInScreen.push(context);
                },
                child: Text("Sign In"),
              ),
              ElevatedButton(
                onPressed: () {
                  SignUpScreen.push(context);
                },
                child: Text("Sign Up"),
              ),
            ],
          ),
          yes: () => Column(
            mainAxisSize: .min,
            children: [
              // Yes user :>
              ElevatedButton(
                onPressed: () {
                  UserService.instance.signOut();
                },
                child: Text("Sign Out"),
              ),
              ElevatedButton(onPressed: () {}, child: Text("Profile")),
            ],
          ),
        ),
      ),
    );
  }
}
