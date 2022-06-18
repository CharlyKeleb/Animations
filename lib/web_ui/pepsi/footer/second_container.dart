import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:test_project/utils/extensions.dart';

class SecondContainer extends StatelessWidget {
  const SecondContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 3.h),
          Text(
            'Diet Pepsi'.toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 18.0,
            ),
          ).fadeInList(17, true),
          SizedBox(height: 2.h),
          const Text(
            'A non-alcoholic carbonated cola soft\ndrink produced by PepsiCo\nintroduced in 1964 as a variant of\nPepsi with no sugar',
            style: TextStyle(
              color: Colors.white,
            ),
          ).fadeInList(18, true),
          SizedBox(height: 5.0.h),
        ],
      ),
    );
  }
}
