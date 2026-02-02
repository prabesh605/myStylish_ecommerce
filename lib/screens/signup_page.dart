import 'package:flutter/material.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_ecommerce/bloc/auth/auth_bloc.dart';
import 'package:stylish_ecommerce/bloc/auth/auth_event.dart';
import 'package:stylish_ecommerce/bloc/auth/auth_state.dart';
import 'package:stylish_ecommerce/models/user_model.dart';
import 'package:stylish_ecommerce/screens/login_screen.dart';
import 'package:stylish_ecommerce/screens/user_module/user_navigationbar.dart';
import 'package:stylish_ecommerce/service/firebase_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  FirebaseService service = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserNavigationbar()),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  content: Text("login Success"),
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Create an \nAccount',
                      style: TextStyle(
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Username or Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),

                SizedBox(height: 30),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    prefixIcon: Icon(Icons.lock),
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixIcon: Icon(Icons.remove_red_eye_outlined),
                  ),
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    prefixIcon: Icon(Icons.lock),
                    hintText: 'Confirm Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixIcon: Icon(Icons.remove_red_eye_outlined),
                  ),
                ),

                SizedBox(height: 30),
                Text.rich(
                  TextSpan(
                    text: 'By clicking the ',
                    children: [
                      TextSpan(
                        text: 'Register',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(
                        text: ' button, you agree to the public offer',
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 40),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.redAccent,
                    minimumSize: Size(double.infinity, 60),
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    if (_passwordController.text ==
                        _confirmPasswordController.text) {
                      final user = UserModel(
                        email: _emailController.text,
                        password: _confirmPasswordController.text,
                      );
                      context.read<AuthBloc>().add(SignUp(user));
                    
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("Password doesnot match!!"),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Create Account',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),

                SizedBox(height: 40),
                Text('- Or Continue with -', style: TextStyle(fontSize: 16)),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _socialButton('assets/icons/google.png', () {}),
                    const SizedBox(width: 16),
                    _socialButton('assets/icons/apple.png', () {}),
                    const SizedBox(width: 16),
                    _socialButton('assets/icons/facebook.png', () {}),
                  ],
                ),

                SizedBox(height: 30),
                Text.rich(
                  TextSpan(
                    text: 'I already have an account. ',
                    style: const TextStyle(fontSize: 16),
                    children: [
                      TextSpan(
                        text: 'Login',
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.redAccent,
                          decorationThickness: 2,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _socialButton(String assetPath, VoidCallback onTap) {
  return InkWell(
    borderRadius: BorderRadius.circular(50),
    onTap: onTap,
    child: Container(
      width: 48, // Standard mobile touch target
      height: 48,
      decoration: BoxDecoration(
        color: Colors.red[50],
        shape: BoxShape.circle,
        border: Border.all(color: Colors.redAccent, width: 1.5),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3,
            offset: Offset(1.5, 1.5),
          ),
        ],
      ),
      child: Center(
        child: Image.asset(
          assetPath,
          width: 22, // Standard icon size
          height: 22,
          fit: BoxFit.contain,
        ),
      ),
    ),
  );
}
