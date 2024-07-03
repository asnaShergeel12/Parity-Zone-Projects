import 'dart:ui';
import 'package:canva_design/home/view/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:canva_design/home/view/screens/signup_screen/signup_screen.dart';
import 'package:canva_design/home/view/widgets/custom_text.dart';
import 'package:canva_design/home/view/widgets/custom_textformfield.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/custom_passwordtextformfield.dart';
import '../../widgets/custom_textbtn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return "Please enter username";
    }
    if (username.length < 3) {
      return "Username should be greater than 3 letters";
    }
    RegExp nameRegex = RegExp(r'^[a-zA-Z0-9_]+$');
    final isUsernameValid = nameRegex.hasMatch(username);
    if (!isUsernameValid) {
      return "Username can only contain letters, underscores, and numbers";
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return "Please enter password";
    }
    if (password.length < 8) {
      return "Password shall be minimum 8 characters";
    }
    RegExp passRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
    final isPasswordValid = passRegex.hasMatch(password);
    if (!isPasswordValid) {
      return "Add at least 1 letter and 1 number";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _loginKey,
        child: Stack(
          children: [
            Image.asset(
              "assets/images/bg_img.png",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
            Center(
              child: CustomContainer(
                padding: const EdgeInsets.all(8.0),
                width: 325.0,
                height: 440.0,
                color: Colors.white,
                borderRadius: BorderRadius.circular(17.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Column(
                      children: [
                        CustomContainer(
                          padding: EdgeInsets.only(top: 8.0),
                          width: 150,
                          alignment: Alignment.center,
                          child: CustomText(
                            text: 'Login',
                            fontSize: 28.9,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomText(
                          text: 'Sign in to continue',
                          fontSize: 9.7,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CustomTextFormField(
                          keyboardType: TextInputType.name,
                          controller: _nameController,
                          hintText: 'username',
                          contentPadding: const EdgeInsets.only(
                            left: 23.0,
                          ),
                          hintTxtColor: Colors.grey,
                          txtColor: Colors.grey,
                          cursorColor: Colors.grey,
                          fillColor: const Color(0xff1E1E1A),
                          validator: validateUsername,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomPasswordTextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: _passwordController,
                          contentPadding: const EdgeInsets.only(
                            left: 23.0,
                          ),
                          txtColor: Colors.grey,
                          cursorColor: Colors.grey,
                          validator: validatePassword,
                          fillColor: const Color(0xff1E1E1A),
                          hintText: 'password',
                          hintTxtColor: Colors.grey,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CustomTextButton(
                          text: 'Login',
                          onPressed: () {
                            if (_loginKey.currentState!.validate()) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DashboardScreen()),
                              );
                            }
                          },
                          bordercolor: const Color(0xff1E1E1A),
                          txtcolor: const Color(0xff1E1E1A),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const CustomText(
                          text: 'do you have an account?',
                          fontSize: 9.7,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupScreen()),
                              );
                            },
                            child: const CustomText(
                              text: "create a new account",
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 730.0, left: 160.0),
              child: Row(
                children: [
                  CustomText(
                    text: "Studio",
                    color: Colors.white,
                    fontSize: 11.5,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  CustomText(
                    text: "Shodwe",
                    fontSize: 11.5,
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
