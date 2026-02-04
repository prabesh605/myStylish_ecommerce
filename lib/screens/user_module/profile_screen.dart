import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_ecommerce/bloc/user/user_bloc.dart';
import 'package:stylish_ecommerce/bloc/user/user_event.dart';
import 'package:stylish_ecommerce/bloc/user/user_state.dart';
import 'package:stylish_ecommerce/models/user_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetUser());
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController bankHolderController = TextEditingController();
  TextEditingController bankAccountController = TextEditingController();
  TextEditingController bankNumberController = TextEditingController();
  UserModel? userModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: BlocConsumer<UserBloc, UserState>(
            listener: (BuildContext context, UserState state) {
              if (state is UserSuccess) {
                if (userModel != null) {
                  context.read<UserBloc>().add(UpdateUser(userModel!));
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green,
                      content: Text("Password Change successfully"),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text("Something went wrong"),
                    ),
                  );
                }
              }
            },
            builder: (context, state) {
              if (state is UserLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is UserError) {
                return Center(child: Text("Error"));
              } else if (state is UserLoaded) {
                final user = state.user;
                emailController.text = user.email;
                passwordController.text = user.password;
                pincodeController.text = "${user.pincode ?? 0}";
                addressController.text = user.address ?? "";
                cityController.text = user.city ?? "";
                stateController.text = user.state ?? "";
                countryController.text = user.country ?? "";
                bankHolderController.text = user.accountName ?? "";
                bankAccountController.text = user.bankName ?? "";
                bankNumberController.text = "${user.bankNumber ?? 0}";
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          Image.asset('assets/images/profile.png'),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: CircleAvatar(
                              radius: 15,
                              child: Icon(Icons.edit, size: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    Text(
                      'Person Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    CustomFormFieldWidget(
                      title: "Email Address",
                      controller: emailController,
                    ),
                    CustomFormFieldWidget(
                      title: "Password",
                      controller: passwordController,
                    ),

                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          userModel = UserModel(
                            id: user.id,
                            email: user.email,
                            password: passwordController.text,
                            pincode: user.pincode,
                            address: user.address,
                            city: user.city,
                            state: user.state,
                            country: user.country,
                            accountName: user.accountName,
                            bankName: user.bankName,
                            bankNumber: user.bankNumber,
                            role: user.role,
                          );
                          context.read<UserBloc>().add(
                            ChangePassword(
                              user.password,
                              passwordController.text,
                            ),
                          );
                        },
                        child: Text("Change Password"),
                      ),
                    ),
                    SizedBox(height: 20),
                    Divider(),
                    SizedBox(height: 20),
                    Text(
                      'Business Address Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CustomFormFieldWidget(
                      title: "Pincode",
                      controller: pincodeController,
                    ),
                    CustomFormFieldWidget(
                      title: "Address",
                      controller: addressController,
                    ),
                    CustomFormFieldWidget(
                      title: "City",
                      controller: cityController,
                    ),
                    CustomFormFieldWidget(
                      title: "State",
                      controller: stateController,
                    ),
                    CustomFormFieldWidget(
                      title: "Country",
                      controller: countryController,
                    ),
                    SizedBox(height: 20),
                    Divider(),
                    SizedBox(height: 20),
                    Text(
                      'Bank Account Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CustomFormFieldWidget(
                      title: "Bank Name",
                      controller: bankAccountController,
                    ),
                    CustomFormFieldWidget(
                      title: "Account Holder's Name",
                      controller: bankHolderController,
                    ),
                    CustomFormFieldWidget(
                      title: "Bank Account Number",
                      controller: bankNumberController,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Color(0xffF83758),
                      ),
                      onPressed: () {
                        final updateUser = UserModel(
                          id: user.id,
                          role: user.role,
                          email: emailController.text,
                          password: passwordController.text,
                          pincode: int.tryParse(pincodeController.text),
                          address: addressController.text,
                          city: cityController.text,
                          state: stateController.text,
                          country: countryController.text,
                          accountName: bankHolderController.text,
                          bankName: bankAccountController.text,
                          bankNumber: int.tryParse(bankNumberController.text),
                        );
                        context.read<UserBloc>().add(UpdateUser(updateUser));
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                );
              }
              return SizedBox();
            },
          ),
        ),
      ),
    );
  }
}

class CustomFormFieldWidget extends StatelessWidget {
  const CustomFormFieldWidget({
    super.key,
    required this.title,
    required this.controller,
  });
  final String title;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(title),
        SizedBox(height: 20),
        TextFormField(
          controller: controller,
          // keyboardType: keyboardType,
          decoration: InputDecoration(border: OutlineInputBorder()),
        ),
      ],
    );
  }
}
