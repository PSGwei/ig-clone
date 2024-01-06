import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/utilities/colors.dart';
import 'package:instagram_clone/utilities/methods/authentication.dart';
import 'package:instagram_clone/utilities/methods/utilities.dart';
import 'package:instagram_clone/widgets/input_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String username = '';
  String emailAddress = '';
  String password = '';
  Uint8List? image;
  bool isLoading = false;

  void selectImage() async {
    final Uint8List? result = await pickImage(ImageSource.camera);
    if (result != null) {
      setState(() {
        image = result;
      });
    }
  }

  void signUp() async {
    setState(() {
      isLoading = true;
    });
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      String result = await AuthMethods().signUp(
        email: emailAddress,
        password: password,
        username: username,
        imageFile: image!,
      );
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
                    Stack(
                      children: [
                        image != null
                            ? CircleAvatar(
                                radius: 64,
                                backgroundImage: MemoryImage(image!),
                              )
                            : const CircleAvatar(
                                radius: 64,
                                backgroundImage: NetworkImage(defaultAvatar),
                              ),
                        Positioned(
                          bottom: -10,
                          right: -7,
                          child: IconButton(
                            onPressed: selectImage,
                            icon: const Icon(Icons.add_a_photo),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    InputField(
                      hintText: 'Enter your username',
                      keyboardType: TextInputType.text,
                      validator: (username) {
                        if (username == null || username.isEmpty) {
                          return 'Please enter username.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        username = value!;
                      },
                    ),
                    const SizedBox(height: 32),
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
                      isPassword: true,
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
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Sign up Button
              InkWell(
                onTap: signUp,
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
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : const Text('Sign up'),
                ),
              ),
              Flexible(flex: 2, child: Container()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('Already have an account? '),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                    },
                    child: const Text(
                      'Log in',
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
