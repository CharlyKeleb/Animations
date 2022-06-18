import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:test_project/utils/extensions.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: TextButton.icon(
              onPressed: () {},
              icon: Image.asset(
                'assets/images/pepsi.png',
                height: 2.5.h,
                width: 2.5.w,
              ),
              label: const Text(
                "PEPSI",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  fontSize: 22.0,
                ),
              ),
            ).fadeInList(1, true),
          ),
          SizedBox(width: 20.w),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Container(
              height: 5.0.h,
              width: 35.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Products'.toUpperCase()).fadeInList(2, true),
                  Text('What\'s new'.toUpperCase()).fadeInList(3, true),
                  Text('Newsletter'.toUpperCase()).fadeInList(4, true),
                  Text('Contact us'.toUpperCase()).fadeInList(5, true),
                ],
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Container(
              height: 30.0,
              child: OutlinedButton(
                onPressed: () {},
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  side: MaterialStateProperty.all(
                    const BorderSide(
                      color: Colors.white,
                      width: 1.0,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Buy Products'.toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 12.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ).fadeInList(6, true),
          ),
        ],
      ),
    );
  }
}
