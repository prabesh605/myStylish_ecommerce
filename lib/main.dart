import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stylish_ecommerce/bloc/auth/auth_bloc.dart';
import 'package:stylish_ecommerce/bloc/cart/cart_bloc.dart';
import 'package:stylish_ecommerce/bloc/category/category_bloc.dart';
import 'package:stylish_ecommerce/bloc/orders/order_bloc.dart';
import 'package:stylish_ecommerce/bloc/product/product_bloc.dart';
import 'package:stylish_ecommerce/bloc/uploadImage/upload_bloc.dart';
import 'package:stylish_ecommerce/bloc/user/user_bloc.dart';
import 'package:stylish_ecommerce/bloc/wishlist/wishlist_bloc.dart';
// import 'package:stylish_ecommerce/screens/user_model/dashboard_page.dart';
// import 'package:stylish_ecommerce/dashboard_page.dart';
import 'package:stylish_ecommerce/firebase_options.dart';
import 'package:stylish_ecommerce/notification_service.dart';
import 'package:stylish_ecommerce/screens/login_screen.dart';
import 'package:stylish_ecommerce/screens/onboarding_screen.dart';
import 'package:stylish_ecommerce/service/firebase_service.dart';
import 'package:stylish_ecommerce/service/image_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // for navigate or not in OnboardingScreen
  NotificationService.instance.init();
  //for transparent StatusBar
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // background color
    ),
  );

  SharedPreferences seenCheck = await SharedPreferences.getInstance();
  bool seenCheckvalue = seenCheck.getBool('seenCheckvalue') ?? false;

  runApp(MyApp(checkSeenvalue: seenCheckvalue));
}

class MyApp extends StatelessWidget {
  final bool checkSeenvalue;

  const MyApp({super.key, this.checkSeenvalue = false});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CategoryBloc(FirebaseService())),
        BlocProvider(create: (_) => UploadBloc(ImageService())),
        BlocProvider(create: (_) => ProductBloc(FirebaseService())),
        BlocProvider(create: (_) => CartBloc(FirebaseService())),
        BlocProvider(create: (_) => OrderBloc(FirebaseService())),
        BlocProvider(create: (_) => AuthBloc(FirebaseService())),
        BlocProvider(create: (_) => WishlistBloc(FirebaseService())),
        BlocProvider(create: (_) => UserBloc(FirebaseService())),
      ],
      child: MaterialApp(
        title: 'Stylish Ecommerce App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          fontFamily: 'Montserrat',
        ),
        home: checkSeenvalue ? LoginScreen() : OnboardingScreen(),
      ),
    );
  }
}
