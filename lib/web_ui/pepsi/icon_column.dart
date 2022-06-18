import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';
import 'package:test_project/utils/extensions.dart';

class IconColumn extends StatelessWidget {
  const IconColumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30.h),
        const Icon(Ionicons.logo_instagram).fadeInList(7, true),
        SizedBox(height: 5.h),
        const Icon(Ionicons.logo_apple).fadeInList(8, true),
        SizedBox(height: 5.h),
        const Icon(Ionicons.logo_twitter).fadeInList(9, true),
        SizedBox(height: 5.h),
        const Icon(Ionicons.logo_facebook).fadeInList(10, true),
      ],
    );
  }
}
