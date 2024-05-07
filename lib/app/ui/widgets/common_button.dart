import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CommonButton extends StatelessWidget {
  const CommonButton(
      {super.key,
      required this.child,
      required this.onPressed,
      this.color = Colors.black});

  final Widget child;
  final VoidCallback onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: Size(90.w, 6.h),
      ),
      child: child,
    );
  }
}
