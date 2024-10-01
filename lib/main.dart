import 'package:flutter/material.dart';
import 'package:github_task_ankit/view/splash_screen.dart';
import 'package:provider/provider.dart';

import 'controller/reposetry_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RepoProvider>(create: (context) => RepoProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Github_task',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
