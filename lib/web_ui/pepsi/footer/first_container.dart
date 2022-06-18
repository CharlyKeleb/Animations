import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:test_project/utils/extensions.dart';

class FirstContainer extends StatelessWidget {
  const FirstContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              Container(
                height: 4.2.h,
                width: 3.0.w,
                color: const Color(0xff2762ae),
                child: const Center(
                  child: Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                height: 4.2.h,
                width: 3.0.w,
                color: const Color(0xff193e85),
                child: const Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Container(
            width: 50.w,
            color: Colors.white,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 3.0.h),
                      Text(
                        'Never Go out style'.toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          fontSize: 20.0,
                        ),
                      ).fadeInList(14, true),
                      SizedBox(height: 2.0.h),
                      const Text(
                        'Enjoy the tast of Pepsi\'s world with an exclusive look into music,\nsports, ans entertainment.(link: http://Pepsi.com\nFollow us on Instagram',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                        ),
                      ).fadeInList(15, true),
                      SizedBox(height: 3.0.h),
                    ],
                  ),
                ),
                Spacer(),
                Image.asset(
                  'assets/images/pepsi_bottle.png',
                  height: 18.h,
                  width: 10.w,
                  fit: BoxFit.fill,
                ).fadeInList(16, true),
                SizedBox(width: 1.0.w),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
