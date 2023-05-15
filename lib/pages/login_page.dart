import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:submission_may11/pages/home_page.dart';
import 'package:submission_may11/services/firebaseauth_services.dart';
import 'package:submission_may11/widgets/background.dart';
import 'package:submission_may11/widgets/center_button.dart';




class LoginPage extends StatefulWidget {
   const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //used to handel operations on the textfield of email
 final TextEditingController emailController = TextEditingController();

 final TextEditingController passwordController = TextEditingController();
   final FirebaseAuthServices firebaseAuth = FirebaseAuthServices();
 final _loginFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) => Scaffold(
    resizeToAvoidBottomInset: true,
    backgroundColor: Colors.white,
    body: Background(
      child:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
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
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Enter your password',
                  labelText: 'Password',
                ),
                validator:validatePassword,
              ),
              CenterButton(
                txt: 'LOGIN',
                ky: const Key('Login Button'),
                color: Colors.cyan,
                onPress: () => onPressLogin(emailController.text, passwordController.text, context),
              ),
            ],
          ),
        ),
      ),
        ),
  );

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

 onPressLogin(String email, String password,context){
   if (_loginFormKey.currentState!.validate()) {
     // Form is valid, proceed with login logic
     firebaseAuth.signInUser(email, password,context);
   }
  }
}
