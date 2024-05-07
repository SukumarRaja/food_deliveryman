import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:sizer/sizer.dart';
import '../utility/colors.dart';
import '../utility/text_styles.dart';

class ToastService {
  static sendScaffoldAlert(
      {required BuildContext context,
      required String msg,
      required String toastStatus}) {
    showToastWidget(
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
          margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: greyShade3),
              color: white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                  toastStatus == "SUCCESS"
                      ? Icons.check_circle
                      : toastStatus == "ERROR"
                          ? Icons.warning_rounded
                          : Icons.warning_rounded,
                  color: toastStatus == "SUCCESS"
                      ? success
                      : toastStatus == "ERROR"
                          ? error
                          : Colors.amber),
              SizedBox(width: 3.w),
              SizedBox(
                width: 68.w,
                child: Text(
                  msg,
                  style: AppTextStyles.small10,
                  textAlign: TextAlign.left,
                ),
              ),
              const Spacer()
            ],
          ),
        ),
        context: context,
        isIgnoring: true,
        duration: Duration.zero,
        animation: StyledToastAnimation.slideFromTop,
        reverseAnimation: StyledToastAnimation.slideFromTop,
        position: StyledToastPosition.top,
        dismissOtherToast: true);
  }
}
