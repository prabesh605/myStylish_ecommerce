import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stylish_ecommerce/dashboard_page.dart';
// import 'package:stylish_ecommerce/dashboard_page.dart';
import 'package:stylish_ecommerce/firebase_options.dart';
import 'package:stylish_ecommerce/onboarding_screen.dart';

Future<void> main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // for navigate or not in OnboardingScreen

//for transparent StatusBar
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor:Colors.transparent,// background color
    ),
  );

  SharedPreferences seenCheck=await SharedPreferences.getInstance();
     bool seenCheckvalue = seenCheck.getBool('seenCheckvalue')??false;


  runApp(MyApp(checkSeenvalue:seenCheckvalue));
}

class MyApp extends StatelessWidget {
 final bool checkSeenvalue;

  const MyApp({super.key, this.checkSeenvalue=false});

    
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Stylish Ecommerce App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: 'Montserrat',
      ),
      home:checkSeenvalue?DashboardPage(): OnboardingScreen() ,
    );
  }
}
