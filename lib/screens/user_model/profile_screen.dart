import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              CustomFormFieldWidget(
                title: "Email Address",
                controller: TextEditingController(),
              ),
              CustomFormFieldWidget(
                title: "Password",
                controller: TextEditingController(),
              ),

              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: Text("Change Password"),
              ),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 20),
              Text(
                'Business Address Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              CustomFormFieldWidget(
                title: "Pincode",
                controller: TextEditingController(),
              ),
              CustomFormFieldWidget(
                title: "Address",
                controller: TextEditingController(),
              ),
              CustomFormFieldWidget(
                title: "City",
                controller: TextEditingController(),
              ),
              CustomFormFieldWidget(
                title: "State",
                controller: TextEditingController(),
              ),
              CustomFormFieldWidget(
                title: "Country",
                controller: TextEditingController(),
              ),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 20),
              Text(
                'Bank Account Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              CustomFormFieldWidget(
                title: "Account Holder's Name",
                controller: TextEditingController(),
              ),
              CustomFormFieldWidget(
                title: "Bank Account Number",
                controller: TextEditingController(),
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
                onPressed: () {},
                child: Text("Save", style: TextStyle(color: Colors.white)),
              ),
            ],
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
          decoration: InputDecoration(border: OutlineInputBorder()),
        ),
      ],
    );
  }
}
