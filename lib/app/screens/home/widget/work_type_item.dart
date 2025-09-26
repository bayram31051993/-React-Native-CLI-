import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:react_native_test/app/app.dart';

class WorkTypeItem extends StatelessWidget {
  final WorkTypes workType;
  const WorkTypeItem({super.key, required this.workType});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(12),
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
      child: Text(
        '${workType.name}',
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.sp),
        textAlign: TextAlign.left,
      ),
    );
  }
}
