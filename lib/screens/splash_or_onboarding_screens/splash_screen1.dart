import 'package:flutter/material.dart';
import 'package:stylish_ecommerce/screens/splash_or_onboarding_screens/materialsfor_splash_screen.dart';

class SplashScreen1 extends StatelessWidget {
  const SplashScreen1({super.key});

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
      
           Image.asset('assets/images/splash_screen_images/screen1.png',
           fit:BoxFit.cover,
           height: mHeight*0.4,
           width: mWidth*0.8,
           ),
        
        heading24pxExtraBold(heading:'Choose Products'),SizedBox(height:mHeight*0.015),
        paragraph14pxSemiBoldwithCenterText(title:'Browse through a wide range of products with ease.Select the items you love and add them to your cart effortlessly.'),
  
         
        ],
      ),
    );
  }
}