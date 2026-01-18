import 'package:flutter/material.dart';
import 'package:stylish_ecommerce/dashboard_page.dart';
import 'package:stylish_ecommerce/signup_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                Text(
                  "Welcome\nBack!",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                inputTextFormField(
                  emailController,
                  'Username or email',
                  Icons.person,
                ),
                SizedBox(height: 30),
                inputTextFormField(
                  passwordController,
                  'Password',
                  Icons.lock,
                  suffixIcon: Icons.remove_red_eye,
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: GestureDetector(
                    child: Text(
                      "Forget password?",
                      style: TextStyle(color: Color(0xffF83758)),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffF83758),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DashboardPage(),
                        ),
                      );
                    },
                    child: Text("Login", style: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(height: 50),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "-OR Continue with-",
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SigninIconButton(
                      iconWidget: SizedBox(
                        width: 40,
                        height: 40,
                        child: Image.asset(
                          'assets/icons/google_icon.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    SigninIconButton(
                      iconWidget: Icon(Icons.apple),
                      foregroundColor: Colors.black,
                    ),
                    SizedBox(width: 10),
                    SigninIconButton(
                      iconWidget: Icon(Icons.facebook),
                      foregroundColor: Color(0xff3D4DA6),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupScreen()),
                      );
                    },
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: 'Create an account. '),
                          TextSpan(
                            text: 'Signup',
                            style: TextStyle(
                              color: Color(0xffF83758),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  TextFormField inputTextFormField(
    TextEditingController controller,
    String hintText,
    IconData prefixIcon, {
    IconData? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color.fromARGB(194, 243, 243, 243),
        hintText: hintText,
        prefixIcon: Icon(prefixIcon),
        border: inputTextFormFieldStyle(),
        enabledBorder: inputTextFormFieldStyle(),
        errorBorder: inputTextFormFieldStyle(),
        focusedBorder: inputTextFormFieldStyle(),
        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
      ),
    );
  }

  OutlineInputBorder inputTextFormFieldStyle() {
    return OutlineInputBorder(
      borderSide: BorderSide(),
      borderRadius: BorderRadius.circular(12),
    );
  }
}

class SigninIconButton extends StatelessWidget {
  final Widget iconWidget;
  final Color? foregroundColor;
  const SigninIconButton({
    super.key,
    required this.iconWidget,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: IconButton.styleFrom(
        side: BorderSide(color: Colors.red),
        padding: EdgeInsets.all(12),
        iconSize: 40,
        foregroundColor: foregroundColor,
      ),
      onPressed: () {},
      icon: iconWidget,
    );
  }
}
