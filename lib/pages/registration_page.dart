import 'dart:io';

import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:submission_may11/services/firebaseauth_services.dart';
import 'package:submission_may11/widgets/background.dart';
import 'package:submission_may11/widgets/center_button.dart';


class RegistrationPage extends StatefulWidget {


  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController emailController = TextEditingController();
 //email controller
  final TextEditingController passWordController = TextEditingController();

  final TextEditingController confirmPassWordController = TextEditingController();
 //password controller
  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController phoneNoController = TextEditingController();

  final FirebaseAuthServices firebaseAuth = FirebaseAuthServices();
  final _registerFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: true,
        body: Background(
          child:    Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SingleChildScrollView(
              reverse: true,
              child: Form(
                key: _registerFormKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      key: const Key('First Name Sign Up Field'),
                      controller: firstNameController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        labelText: 'First Name',
                        hintText: 'Enter your First Name',
                      ),
                      obscureText: false,
                      validator: validateName,
                    ),
                    TextFormField(
                      key: const Key('Last Name Sign Up Field'),
                      controller: lastNameController,
                      //   check: _controller.checkEmail,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        labelText: 'Last Name',
                        hintText: 'Enter your Last Name',
                      ),
                      obscureText: false,
                      validator: validateName,
                    ),
                    TextFormField(
                      key: const Key('Phone Number Sign Up Field'),
                      controller: phoneNoController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        hintText: 'Enter your Phone Number',
                      ),
                      obscureText: false,
                      validator: validatePhoneNumber,
                    ),
                    TextFormField(
                      key: const Key('Email Sign Up Field'),
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email',
                      ),
                      validator: validateEmail,
                    ),
                    TextFormField(
                      key: const Key('Password Sign Up Field'),
                      controller: passWordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Enter your password',
                        labelText: 'Password',
                      ),
                      validator: validatePassword,
                    ),
                    TextFormField(
                      key: const Key(
                          'Confirm Password Sign Up Field'),
                      controller: confirmPassWordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Confirm your password',
                        labelText: 'Confirm Password',
                      ),
                      validator: validateConfirmPassword,
                    ),
                    //    checkMarks(),
                    CenterButton(
                      txt: 'SIGN UP',
                      ky: const Key('Sign UP Button'),
                      onPress: () => onPressSignUp(emailController.text, passWordController.text, firstNameController.text, lastNameController.text, phoneNoController.text,  Platform.localeName,  context),
                      color: Colors.indigo,
                      //  color:lightBlue,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Widget checkMarks() => Row(
        key: const Key('Icon Row'),
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: const [
                Icon(
                    Icons.check_circle_rounded,
                    //color: _controller.checkColor.value,
                  ),
                Text('More than\n 6 characters'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: const [
                Icon(
                    Icons.check_circle_rounded,
                    //color: _controller.checkColor.value,
                  ),
                Text('One special\n character'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: const [
               Icon(
                    Icons.check_circle_rounded,
                 //   color: _controller.checkColor.value,
                  ),
                Text('one\ndigit'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: const [
               Icon(
                    Icons.check_circle_rounded,
               //     color: _controller.checkColor.value,
                  ),
                Text('one upper \n case'),
              ],
            ),
          ),
        ],
      );

  String? validatePhoneNumber(String? value) {
    if (value!.isEmpty) {
      return 'Phone Number is required.';
    }
    if (value.length < 10) {
      return 'Phone number should be of 10 digits';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value!.isEmpty) {
      return 'Confirm Password is required.';
    }
    if (value != passWordController.text) {
      return 'Not same as password';
    }
    return null;
  }

  String? validateName(String? value) {
    if (value!.isEmpty) {
      return 'Name is required.';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Email is required.';
    }
    // Use a regular expression to validate the email format
    // You can customize the regular expression according to your requirements
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address.';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Password is required.';
    }
    // Validate any additional password requirements
    // For example, the password must be at least 6 characters long
    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }
    return null;
  }

  onPressSignUp(String email, String password, String firstName, String lastName, String phNo,String languagePref,context) {
    if (_registerFormKey.currentState!.validate()) {
      firebaseAuth.registerUser(
          email,
          password,
          firstName,
          lastName,
          phNo,
          languagePref,
          context);
      debugPrint("Sign Up Key Pressed");
    }
  }
}

















