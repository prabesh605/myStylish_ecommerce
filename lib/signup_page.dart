import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                    style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
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
                  suffixIcon: Icon(Icons.remove_red_eye_outlined)
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
                  suffixIcon: Icon(Icons.remove_red_eye_outlined)
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
                onPressed: () {},
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
                  Container(
                    padding: EdgeInsets.all(12), 
                    decoration: BoxDecoration(
                      color: Colors.red[50], 
                      borderRadius: BorderRadius.circular(100), 
                      border: Border.all(
                        color: Colors.redAccent, 
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Image.asset(
                        'assets/icons/google.png',
                        width: 24,
                        height: 24,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: 30),
                  Container(
                    padding: EdgeInsets.all(12), 
                    decoration: BoxDecoration(
                      color: Colors.red[50], 
                      borderRadius: BorderRadius.circular(100), 
                      border: Border.all(
                        color: Colors.redAccent,
                        width: 2, // border width
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Image.asset(
                        'assets/icons/apple.png',
                        width: 24,
                        height: 24,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: 30),
                  Container(
                    padding: EdgeInsets.all(12), 
                    decoration: BoxDecoration(
                      color: Colors.red[50], 
                      borderRadius: BorderRadius.circular(100), 
                      border: Border.all(
                        color: Colors.redAccent, 
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Image.asset(
                        'assets/icons/facebook.png',
                        width: 24,
                        height: 24,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 30),
              Text.rich(
                TextSpan(
                  text: 'I already have an account. ',
                  children: [
                    TextSpan(
                      text: 'Login',
                      style: TextStyle(
                        decorationColor: Colors.redAccent,
                        decorationThickness: 2,
                        decoration: TextDecoration.underline,
                        fontSize: 16,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
