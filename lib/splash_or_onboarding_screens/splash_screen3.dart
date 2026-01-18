import 'package:flutter/material.dart';
import 'package:stylish_ecommerce/splash_or_onboarding_screens/materialsfor_splash_screen.dart';

class SplashScreen3 extends StatelessWidget {
  const SplashScreen3({super.key});

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
      
           Image.asset('assets/images/splash_screen_images/screen3.png',
           fit:BoxFit.cover,
           height: mHeight*0.4,
           width: mWidth*0.8,
           ),
        
        heading24pxExtraBold(heading:'Get Your Order'),SizedBox(height:mHeight*0.015),
        paragraph14pxSemiBoldwithCenterText(title:'Receive your order quickly at your doorstep with ease.Track and enjoy a smooth delivery experience every time.'),
  
         
        ],
      ),
    );
  }
}