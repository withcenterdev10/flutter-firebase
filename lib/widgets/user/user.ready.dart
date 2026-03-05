import 'package:flutter/material.dart';

class UserReady extends StatelessWidget {
  const UserReady({super.key, required this.yes, this.no});

  final Widget Function() yes;
  final Widget Function()? no;

  @override
  Widget build(BuildContext context) {
    return yes();
  }
}
