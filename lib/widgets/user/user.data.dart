import 'package:fb_test2/models/user/user.model.dart';
import 'package:flutter/material.dart';

class UserData extends StatelessWidget {
  const UserData({super.key, required this.builder});

  final Widget Function(BuildContext context, UserModel?) builder;

  @override
  Widget build(BuildContext context) {
    return builder(context, null);
  }
}
