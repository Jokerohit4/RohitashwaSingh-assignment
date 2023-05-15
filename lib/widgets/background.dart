import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({super.key, required this.child});
final Widget child;
  @override
  Widget build(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: <Color>[
              //  Color.fromRGBO(252, 153, 0, 0.8),
              //   Color.fromRGBO(237, 89, 43, 0.8),
         //     Color.fromRGBO(23, 40, 148, 1),
            //  Color.fromRGBO(23, 40, 148, 1),
            Colors.white,
            Colors.white54,
            ],
          ),
        ),
    child: child,
      );
}
