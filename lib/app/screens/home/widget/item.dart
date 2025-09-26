import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:react_native_test/app/app.dart';
import 'package:react_native_test/app/screens/home/detail.dart';

class UserItem extends StatelessWidget {
  final UserDataModel userModel;
  const UserItem({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => UserDetail(userModel: userModel)),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.r)),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 4,
              spreadRadius: 0,
              color: Color(0x0D000000),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 60.h,
              width: 60.w,
              child: NetworkImageWithLoader(
                '${userModel.logo}',
                fit: BoxFit.fill,
                radius: 8,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${userModel.companyName}',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                    ),
                  ),
                  Text(
                    'Начало работы: ${userModel.timeStartByCity}',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 10.sp,
                    ),
                  ),
                  Text(
                    'Конец работы: ${userModel.timeEndByCity}',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  '${userModel.customerRating ?? 0} ',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                    color: Colors.amberAccent,
                  ),
                ),
                Icon(Icons.star, color: Colors.amberAccent, size: 15),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
