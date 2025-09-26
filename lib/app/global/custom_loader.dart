import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  final double height;
  final double width;
  const CustomLoader({super.key, this.height = 50, this.width = 50});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width,
        height: height,
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
