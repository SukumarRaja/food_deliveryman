import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utility/colors.dart';
import '../../utility/text_styles.dart';

class CommonTextFomField extends StatelessWidget {
  const CommonTextFomField(
      {super.key,
      required this.controller,
      required this.title,
      required this.hintText,
      required this.keyboardType});

  final TextEditingController controller;
  final String title;
  final String hintText;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: AppTextStyles.body14),
          SizedBox(height: 0.8.h),
          TextFormField(
            cursorColor: black,
            style: AppTextStyles.textFieldTextStyle,
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0, horizontal: 2.w),
              hintText: hintText,
              hintStyle: AppTextStyles.textFieldHintTextStyle,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: grey)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: black)),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: grey)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: grey)),
            ),
          ),
        ],
      ),
    );
  }
}
