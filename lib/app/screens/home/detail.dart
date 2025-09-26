import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:react_native_test/app/app.dart';
import 'package:react_native_test/app/screens/home/widget/work_type_item.dart';
import 'package:url_launcher/url_launcher.dart';

class UserDetail extends StatelessWidget {
  final UserDataModel userModel;
  const UserDetail({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          '${userModel.companyName}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        actions: [
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 220.h,
              child: NetworkImageWithLoader(
                '${userModel.logo}',
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 15.h),
            infoRow('Открытие:', '${userModel.dateStartByCity}'),
            SizedBox(height: 5.h),
            infoRow('Начало работы:', '${userModel.timeStartByCity}'),
            SizedBox(height: 5.h),
            infoRow('Конец работы:', '${userModel.timeEndByCity}'),
            SizedBox(height: 5.h),
            infoRow('Количества рабочих:', '${userModel.currentWorkers}'),
            SizedBox(height: 5.h),
            infoRow('План работы:', '${userModel.planWorkers}'),
            SizedBox(height: 5.h),
            infoRow('Цена за работу:', '${userModel.priceWorker} Руб'),
            SizedBox(height: 5.h),
            infoRow('Бонусы за работу:', '${userModel.bonusPriceWorker} Руб'),
            SizedBox(height: 5.h),
            infoRow(
              'Продвижение:',
              userModel.isPromotionEnabled! ? 'Включен' : 'Выключен',
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Тип работы:',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.sp),
              ),
            ),
            if (userModel.workTypes != null)
              Column(
                children: List.generate(
                  userModel.workTypes!.length,
                  (index) =>
                      WorkTypeItem(workType: userModel.workTypes![index]),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 50.h,
          padding: const EdgeInsets.all(8.0),
          child: PrimaryButton(
            onPressed: onShowOnMap,
            text: 'Показать на карте',
          ),
        ),
      ),
    );
  }

  Future<void> onShowOnMap() async {
    await launchUrl(
      Uri.parse(
        'https://www.google.com/maps/@${userModel.coordinates!.latitude!},${userModel.coordinates!.longitude!},696m/data=!3m1!1e3!5m1!1e2?hl=en',
      ),
    );
  }

  Container infoRow(String title, String desc) => Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
    child: Row(
      children: [
        SizedBox(
          width: 0.4.sw,
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp),
          ),
        ),
        SizedBox(width: 20.h),
        Expanded(
          child: Text(
            desc,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
          ),
        ),
      ],
    ),
  );
}
