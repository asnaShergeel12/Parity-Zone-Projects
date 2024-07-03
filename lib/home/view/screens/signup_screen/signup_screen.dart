import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../login_screen/login_screen.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/custom_passwordtextformfield.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_textbtn.dart';
import '../../widgets/custom_textformfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _signupKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _birthController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? dropdownValue;
  final List<String> genderList = ["male", "female"];
  bool isBirthValid = true;
  bool isGenderValid = true;

  String? validateName(String? username) {
    if (username == null || username.isEmpty) {
      return "Please enter name";
    }
    if (username.length < 3) {
      return "Name should be greater than 3 letters";
    }
    RegExp nameRegex = RegExp(r'^[a-zA-Z]+$');
    final isUsernameValid = nameRegex.hasMatch(username ?? '');
    if (!isUsernameValid) {
      return "Use letters for name";
    }
    return null;
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return "Please enter email";
    }
    RegExp emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    final isEmailValid = emailRegex.hasMatch(email ?? '');
    if (!isEmailValid) {
      return 'Please enter a valid email';
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
    if (_passwordController.text != _confirmPasswordController.text) {
      return 'Passwords did not match';
    }
    return null;
  }

  String? validateBirthDate(String? birthDate) {
    if (birthDate == null || birthDate.isEmpty) {
      setState(() {
        isBirthValid = false;
      });
      return "Please select birth date";
    }
    setState(() {
      isBirthValid = true;
    });
    return null;
  }

  String? validateGender() {
    if (dropdownValue == null) {
      return "Please select gender";
    }
    return null;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _birthController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/bg_img.png",
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Center(
            child: SingleChildScrollView(
              child: CustomContainer(
                padding: const EdgeInsets.all(16.0),
                width: 325.0,
                color: Colors.white,
                borderRadius: BorderRadius.circular(17.0),
                child: Form(
                  key: _signupKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomContainer(
                        padding: EdgeInsets.only(top: 10.0),
                        width: 201,
                        alignment: Alignment.center,
                        child: CustomText(
                          text: 'Create a new',
                          fontSize: 22.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const CustomContainer(
                        alignment: Alignment.center,
                        child: CustomText(
                          text: 'account',
                          fontSize: 22.5,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const CustomText(
                        text: 'Already registered?',
                        fontSize: 9.5,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                        child: const CustomText(
                          text: 'login here',
                          fontSize: 9,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextFormField(
                        keyboardType: TextInputType.name,
                        controller: _firstNameController,
                        txtColor: const Color(0xff1e1e1a),
                        hintText: 'firstname',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 23.0, vertical: 8.0),
                        hintTxtColor: const Color(0xff1e1e1a),
                        fillColor: Colors.transparent,
                        validator: validateName,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        keyboardType: TextInputType.name,
                        controller: _lastNameController,
                        txtColor: const Color(0xff1e1e1a),
                        hintText: 'lastname',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 23.0, vertical: 8.0),
                        hintTxtColor: const Color(0xff1e1e1a),
                        fillColor: Colors.transparent,
                        validator: validateName,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        contentPadding: const EdgeInsets.only(left: 25.0),
                        keyboardType: TextInputType.none,
                        controller: _birthController,
                        showCursor: false,
                        txtColor: const Color(0xff1e1e1a),
                        hintTxtColor: const Color(0xff1E1E1A),
                        onTap: () async {
                          DateTime? pickeddate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1930),
                              lastDate: DateTime(2030));
                          if (pickeddate != null) {
                            setState(() {
                              _birthController.text =
                                  DateFormat.yMd().format(pickeddate);
                            });
                          }
                        },
                        hintText: 'birth',
                        fillColor: Colors.transparent,
                        suffixIcon: const Icon(
                          Icons.date_range,
                          color: Color(0xff1E1E1A),
                        ),
                        validator: validateBirthDate,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 233,
                        padding: const EdgeInsets.only(left: 23.5, right: 10.5),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: isGenderValid
                                ? const Color(0xff1e1e1a)
                                : Colors.redAccent.shade700,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(40.0)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            icon: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Color(0xff1E1E1A),
                            ),
                            isExpanded: true,
                            hint: const Text(
                              "gender",
                              style: TextStyle(
                                  fontSize: 9.3, color: Color(0xff1E1E1A)),
                            ),
                            value: dropdownValue,
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue;
                                isGenderValid = validateGender() == null;
                              });
                            },
                            items: genderList.map<DropdownMenuItem<String>>(
                              (String valueItem) {
                                return DropdownMenuItem<String>(
                                  value: valueItem,
                                  child: Text(
                                    valueItem,
                                    style: const TextStyle(fontSize: 9.3),
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ),
                      if (!isGenderValid)
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 75.0,
                            top: 5.0,
                          ),
                          child: Text(
                            validateGender()!,
                            style: TextStyle(
                                color: Colors.redAccent.shade700,
                                fontSize: 9.3),
                          ),
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        fillColor: Colors.transparent,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 23.0, vertical: 8.0),
                        txtColor: const Color(0xff1e1e1a),
                        hintText: 'email',
                        hintTxtColor: const Color(0xff1e1e1a),
                        validator: validateEmail,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomPasswordTextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passwordController,
                        txtColor: const Color(0xff1e1e1a),
                        fillColor: Colors.transparent,
                        hintText: 'password',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 23.0, vertical: 8.0),
                        hintTxtColor: const Color(0xff1e1e1a),
                        validator: validatePassword,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomPasswordTextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        fillColor: Colors.transparent,
                        controller: _confirmPasswordController,
                        txtColor: const Color(0xff1e1e1a),
                        hintText: 'confirm password',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 23.0, vertical: 8.0),
                        hintTxtColor: const Color(0xff1e1e1a),
                        validator: validatePassword,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextButton(
                        text: 'REGISTER',
                        onPressed: () {
                          setState(() {
                            isGenderValid = validateGender() == null;
                          });
                          if (_signupKey.currentState!.validate() &&
                              isGenderValid) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                            );
                          }
                        },
                        bordercolor: const Color(0xff1E1E1A),
                        bgcolor: const Color(0xff1E1E1A),
                        txtcolor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
