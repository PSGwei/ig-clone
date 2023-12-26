import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/utilities/colors.dart';
import 'package:instagram_clone/widgets/input_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final Key formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity, // need to used with crossAxixAlignment.center
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(flex: 2, child: Container()),
              SvgPicture.asset(
                'assets/images/ic_instagram.svg',
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(height: 64),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              "https://images.unsplash.com/photo-1703136686959-d6e53e9fab46?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                        ),
                        Positioned(
                          bottom: -10,
                          right: -7,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.add_a_photo),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    InputField(
                        hintText: 'Enter your username',
                        keyboardType: TextInputType.text),
                    SizedBox(height: 32),
                    InputField(
                        hintText: 'Enter your email',
                        keyboardType: TextInputType.emailAddress),
                    SizedBox(height: 32),
                    InputField(
                      hintText: 'Enter your password',
                      keyboardType: TextInputType.text,
                      isPassword: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Log in Button
              InkWell(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    color: blueColor,
                  ),
                  child: const Text('Sign up'),
                ),
              ),
              Flexible(flex: 2, child: Container()),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('Already have an account? '),
                  ),
                  Text(
                    'Log in',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
