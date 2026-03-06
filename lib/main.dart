import 'package:fb_test2/router.dart';
import 'package:fb_test2/states/post_state.dart';
import 'package:fb_test2/states/user_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserState>(create: (context) => UserState()),
        ChangeNotifierProvider<PostState>(create: (context) => PostState()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: router);
  }
}
