import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RetryButton extends StatelessWidget {
  final VoidCallback callBack;
  const RetryButton({super.key, required this.callBack});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 150.h,
        width: 0.8.sw,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'general_try_again_later'.tr,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.sp),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),
            IconButton(
              onPressed: callBack,
              icon: const Icon(Icons.refresh, color: Colors.blue, size: 35),
            ),
          ],
        ),
      ),
    );
  }
}
