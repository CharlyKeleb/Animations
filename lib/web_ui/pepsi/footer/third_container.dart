import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:test_project/utils/extensions.dart';

class ThirdContainer extends StatelessWidget {
  const ThirdContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1.5.h),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40.0,
            ),
            child: Text(
              'Pepsi history'.toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 18.0,
              ),
            ).fadeInList(19, true),
          ),
          SizedBox(height: 0.5.h),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40.0,
            ),
            child: const Text(
              'Pepsi was first introduced as\n "Brad\'s Drink" in New Bern,US, in\n 1893 by Caleb Bradham,who made\n and sold it at his drugstore',
              style: TextStyle(
                color: Colors.white,
              ),
            ).fadeInList(20, true),
          ),
          Image.asset(
            'assets/images/ice.png',
            fit: BoxFit.cover,
            height: 7.0.h,
            width: MediaQuery.of(context).size.width,
          ).fadeInList(21, true)
        ],
      ),
    );
  }
}
