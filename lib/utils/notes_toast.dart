import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';

class NotesToast {
  NotesToast._internal(); // Private constructor

  static final NotesToast _instance = NotesToast._internal();

  static NotesToast get instance => _instance;

  void successToast({Color? color, String? toast}) {
    final Widget widget = SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        constraints: BoxConstraints(minHeight: 60.h),
        color: const Color(0xFFE8FFE1),
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 10),
                const SizedBox(
                  height: 28,
                  width: 24,
                  child: Icon(Icons.check_circle),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    toast ?? " ",
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 13),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Container(
              height: 3.h,
              width: double.maxFinite,
              color: const Color(0xFF55B938),
            ),
          ],
        ),
      ),
    );

    showToastWidget(
      widget,
      duration: const Duration(seconds: 1),
      position: ToastPosition.bottom,
      onDismiss: () {
        debugPrint('Toast has been dismissed.');
      },
    );
  }

  void errorToast({Color? color, String? toast}) {
    final Widget widget = SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        constraints: BoxConstraints(minHeight: 60.h),
        color: const Color(0xFFFFE2DE),
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 10),
                const SizedBox(
                  height: 28,
                  width: 24,
                  child: Icon(Icons.error),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    toast ?? " ",
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 13),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Container(
              height: 3.h,
              width: double.maxFinite,
              color: const Color(0xFFD65745),
            ),
          ],
        ),
      ),
    );

    showToastWidget(
      widget,
      duration: const Duration(seconds: 2, milliseconds: 20),
      position: ToastPosition.bottom,
      onDismiss: () {
        debugPrint('Toast has been dismissed.');
      },
    );
  }

  void warningToast({Color? color, String? toast}) {
    final Widget widget = SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        constraints: BoxConstraints(minHeight: 60.h),
        color: const Color(0xFFFFF6D4),
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 10),
                const SizedBox(
                  height: 28,
                  width: 24,
                  child: Icon(Icons.warning),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    toast ?? " ",
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 13),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Container(
              height: 3.h,
              width: double.maxFinite,
              color: const Color(0xFFEAC645),
            ),
          ],
        ),
      ),
    );

    showToastWidget(
      widget,
      duration: const Duration(seconds: 2),
      position: ToastPosition.bottom,
      onDismiss: () {
        debugPrint('Toast has been dismissed.');
      },
    );
  }

  void infoToast({Color? color, String? toast}) {
    final Widget widget = SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        constraints: BoxConstraints(minHeight: 60.h),
        color: const Color(0xFFDDEFFF),
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 10),
                const SizedBox(
                  height: 28,
                  width: 24,
                  child: Icon(Icons.info),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    toast ?? " ",
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 13),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Container(
              height: 3.h,
              width: double.maxFinite,
              color: const Color(0xFF5296D5),
            ),
          ],
        ),
      ),
    );

    showToastWidget(
      widget,
      position: ToastPosition.bottom,
    );
  }
}
