import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:submission_may11/pages/login_page.dart';
import 'package:submission_may11/pages/registration_page.dart';
import 'package:submission_may11/widgets/side_button.dart';


class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: <Color>[
                  Color.fromRGBO(52, 80, 161, 0.8),
                  Colors.indigo,
                ],
              ),
            ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            SideButton(
              txt: 'LOGIN',
              ky: const Key('Login Button'),
              color: Colors.black,
              onPress:()=>Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  LoginPage()),
              ) ,
            ),
            SideButton(
              txt: 'SIGN UP',
              ky: const Key('SIGN UP Button'),
              color: Colors.black,
              onPress:()=>Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  RegistrationPage()),
              ) ,
            ),
            SizedBox(
              height: 30.h,
            )
          ],
        ),
          ),
    );
  }
}
