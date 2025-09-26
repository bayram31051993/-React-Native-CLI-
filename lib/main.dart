import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:react_native_test/app/screens/home/home.dart';

void main() {
  runApp(const TestApp());
}

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return ScreenUtilInit(
          useInheritedMediaQuery: true,
          designSize: Size(constraints.maxWidth, constraints.maxHeight),
          builder: (_, child) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              home: HomeScreen(),
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(
                    context,
                  ).copyWith(textScaler: TextScaler.noScaling),
                  child: child!,
                );
              },
            );
          },
        );
      },
    );
  }
}
