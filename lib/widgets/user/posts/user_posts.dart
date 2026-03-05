import 'package:flutter/material.dart';

class UserPosts extends StatelessWidget {
  const UserPosts({super.key, required this.builder});

  final Widget Function(BuildContext context, List<Map<String, String>>) builder;

  @override
  Widget build(BuildContext context) {
    return builder(context, []);
  }
}
