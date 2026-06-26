import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

Future<void> main() async {
  // SharedPreferences ko initialize karne ke liye ensureInitialized() ka use wrna error aarhay thay mjhe,isliye iskiwjahse ab error nhi aatay.
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Management App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey.shade900),
        useMaterial3: true,
      ),
      home: const SplashScreen(), 
    );
  }
}