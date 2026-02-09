import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_ecommerce/bloc/auth/auth_bloc.dart';
import 'package:stylish_ecommerce/bloc/auth/auth_event.dart';
import 'package:stylish_ecommerce/bloc/auth/auth_state.dart';
import 'package:stylish_ecommerce/models/user_model.dart';
import 'package:stylish_ecommerce/notification_service.dart';
import 'package:stylish_ecommerce/screens/admin_module/admin_dashboard_screen.dart';
import 'package:stylish_ecommerce/screens/signup_admin.dart';
import 'package:stylish_ecommerce/screens/signup_page.dart';
import 'package:stylish_ecommerce/screens/user_module/user_navigationbar.dart';
import 'package:stylish_ecommerce/service/firebase_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  FirebaseService service = FirebaseService();

  Future<void> checkUserStatus() async {
    final user = await service.currentUser();
    if (user != null) {
      final UserModel usermodel = await service.getUser();
      if (usermodel.role == 'user') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserNavigationbar()),
        );
      } else if (usermodel.role == 'admin') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminDashboardScreen()),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    checkUserStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                final role = state.role;
                if (role == 'admin') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminDashboardScreen(),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserNavigationbar(),
                    ),
                  );
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green,
                    content: Text("Login Success"),
                  ),
                );
              } else if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(state.error),
                  ),
                );
              }
            },
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
                        final user = UserModel(
                          role: "",
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        context.read<AuthBloc>().add(Login(user));

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => UserNavigationbar(),
                        //     // AdminDashboardScreen(),
                        //     // DashboardPage(),
                        //   ),
                        // );
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
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
                          MaterialPageRoute(
                            builder: (context) => SignupScreen(),
                          ),
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
                  SizedBox(
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupAdminScreen(),
                          ),
                        );
                      },
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: 'Become Seller. '),
                            TextSpan(
                              text: 'Signup',
                              style: TextStyle(
                                color: Colors.brown,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      NotificationService.instance.scheduleNotification(
                        id: 1232,
                        title: "Hello",
                        body: "this is local notifcation",
                        scheduleTime: DateTime.now(),
                      );
                    },
                    child: Text("Test Nofication"),
                  ),
                ],
              ),
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
