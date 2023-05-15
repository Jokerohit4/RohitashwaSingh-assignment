import 'package:flutter/material.dart';

class SideButton extends StatelessWidget {
  const SideButton({Key? key, required this.txt, required this.ky, required this.color, required this.onPress}) : super(key: key);
  final String txt;
  final Key ky;
  final Color color;
  final Function() onPress;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 16.0),
    child: Material(
      elevation: 5.0,
      color: color,
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
      child: MaterialButton(
        key: ky,
        onPressed: onPress,
        minWidth: MediaQuery.of(context).size.width/1.3,
        height: 42.0,
        child: Text(
          txt,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
    ),
  );
}
