import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:test_project/utils/extensions.dart';

class BodyText extends StatelessWidget {
  const BodyText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Get More\nWith Pepsi',
          style: TextStyle(
            letterSpacing: 2,
            fontSize: 50.0,
            fontWeight: FontWeight.w900,
          ),
        ).fadeInList(11, true),
        SizedBox(height: 1.5.h),
        const Text(
          'All Your Favorite Flavors. The gang\'s all here. Compare\nflavors, get nutritional facts and check out ingredients\nfor all our products',
        ).fadeInList(12, true),
        SizedBox(height: 8.0.h),
        Container(
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
                'View Products'.toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 12.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ).fadeInList(13, true),
      ],
    );
  }
}
