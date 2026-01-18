import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stylish_ecommerce/dashboard_page.dart';
<<<<<<< HEAD
import 'package:stylish_ecommerce/firebase_options.dart';
=======
import 'package:stylish_ecommerce/login_screen.dart';
>>>>>>> dfb4537bef46ebc4b049ef7d85ef812fc80c788a

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: LoginScreen(),
    );
  }
}
