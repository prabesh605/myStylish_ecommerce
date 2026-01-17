import 'package:flutter/material.dart';
import 'package:stylish_ecommerce/splash_or_onboarding_screens/materialsfor_splash_screen.dart';

class SplashScreen2 extends StatelessWidget {
  const SplashScreen2({super.key});

  @override
  Widget build(BuildContext context) {
       //height & weight from mediaquery
    final double mHeight = MediaQuery.sizeOf(context).height;
    final double mWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor:Colors.transparent,
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
      
           Image.asset('assets/images/splash_screen_images/screen2.png',
           fit:BoxFit.contain,
           height: mHeight*0.4,
           width: mWidth*9,
           ),
        
        heading24pxExtraBold(heading:'Make Payment'),SizedBox(height:mHeight*0.015),
        paragraph14pxSemiBoldwithCenterText(title:'Pay securely using multiple payment options and confirm your order.Enjoy a fast and seamless checkout experience every time.'),
  
         
        ],
      ),
    );
  }
}