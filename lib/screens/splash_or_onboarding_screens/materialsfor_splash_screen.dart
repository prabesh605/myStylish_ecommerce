
import 'package:flutter/material.dart';


//COLOR SECTION
final Color white = Colors.white;
final Color black = Colors.black;
final Color grey = Color(0xFFA8A8A9);
final Color darkPink =Color(0xFFF83758);
final Color darkBlue =Color(0xFF17223B);

//FONT SECTION

//extrabold 24pix
Text heading24pxExtraBold({required String heading}){
  return Text(heading,style:TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: black),);
}
//semiBold 14pix
Text paragraph14pxSemiBoldwithCenterText({required String title}){
  return Text(
    textAlign: TextAlign.center,
     title,
     style:TextStyle(
      height: 1.5,
      fontSize: 14,
      color:grey
      ),
     );
}



//Custom textButton

TextButton customTextButton({required String title,required Color textColor,VoidCallback? callback}){
  return  TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero, // removes button size
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          splashFactory: NoSplash.splashFactory, 
                        ),
                        onPressed:callback,
                        child: Text(
                          title,
                          style: TextStyle(
                            color: textColor,
                            fontFamily: 'Montserrat',
                            fontSize: 18,
                          ),
                        ),
                      );
}