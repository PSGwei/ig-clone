import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/screens/signup_screen.dart';
import 'package:instagram_clone/utilities/colors.dart';
import 'package:instagram_clone/utilities/methods/authentication.dart';
import 'package:instagram_clone/utilities/methods/utilities.dart';
import 'package:instagram_clone/widgets/input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String emailAddress = '';
  String password = '';

  void login() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      formKey.currentState!.save();
      final String result =
          await AuthMethods().loginUser(emailAddress, password);
      if (result != 'success') {
        if (!context.mounted) return;
        showSnackBar(result, context);
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
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
                    InputField(
                      hintText: 'Enter your email',
                      keyboardType: TextInputType.emailAddress,
                      validator: (email) {
                        // username default is '', no need to determine
                        if (email == null || email.isEmpty) {
                          return 'Please enter email address.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        emailAddress = value!;
                      },
                    ),
                    const SizedBox(height: 32),
                    InputField(
                      hintText: 'Enter your password',
                      keyboardType: TextInputType.text,
                      validator: (password) {
                        // username default is '', no need to determine
                        if (password == null || password.isEmpty) {
                          return 'Please enter password.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        password = value!;
                      },
                      isPassword: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Log in Button
              InkWell(
                onTap: login,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    color: blueColor,
                  ),
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : const Text('Login'),
                ),
              ),
              Flexible(flex: 2, child: Container()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('Don\'t have an account? '),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const SignupScreen()));
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
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
