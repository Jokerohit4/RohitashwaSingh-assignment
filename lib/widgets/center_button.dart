import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CenterButton extends StatelessWidget {
  const CenterButton({Key? key, required this.txt, required this.color, required this.ky, required this.onPress}) : super(key: key);
  final String txt;
  final Color color;
  final Key ky;
  final  onPress;
  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(vertical: 16.h),
    child: Container(
      height: 50.h,
      width: 300.w,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: ElevatedButton(
        key: ky,
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          //primary: lightBlue,
        //  onPrimary: lightGreen,
          shadowColor: Colors.blue,
        ),

        //ButtonStyle(
        //  padding: MaterialStateProperty.all(
//                  const EdgeInsets.only(right: 0.0, left: 5.0)),
        //  backgroundColor: MaterialStateProperty.resolveWith(
        //    getButton2Color,
        //  ),
        //  ),

        child: Text(
          txt,
          textAlign: TextAlign.center,
          //  overflow: TextOverflow.ellipsis,
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
