import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:react_native_test/app/app.dart';
import 'package:react_native_test/app/screens/home/widget/item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<HomeController>(
      init: HomeController(),
      builder: (hc) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              'Hello World!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
          ),
          body: hc.state.isLoading.value
              ? const Center(child: CustomLoader())
              : hc.state.isHasError.value
              ? RetryButton(callBack: hc.get)
              : ListView.builder(
                  itemCount: hc.state.userModel.value!.data!.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.all(8),
                  itemBuilder: (context, index) {
                    UserDataModel usr = hc.state.userModel.value!.data![index];
                    return UserItem(userModel: usr);
                  },
                ),
        );
      },
    );
  }
}
