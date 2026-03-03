import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UserData extends StatelessWidget {
  const UserData({super.key, required this.builder});

  final Widget Function(BuildContext context, Map<String, dynamic>) builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseDatabase.instance
          .ref('members')
          .child(FirebaseAuth.instance.currentUser!.uid)
          .onValue,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final data = (Map<String, dynamic>.from(
            snapshot.data.snapshot.value ?? {},
          ));

          return builder(context, data);
        } else {
          return builder(context, {});
        }
      },
    );
  }
}
