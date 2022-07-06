import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';
import 'package:test_project/utils/extensions.dart';
import 'package:test_project/web_ui/pepsi/body_text.dart';
import 'package:test_project/web_ui/pepsi/footer/first_container.dart';
import 'package:test_project/web_ui/pepsi/footer/second_container.dart';
import 'package:test_project/web_ui/pepsi/footer/third_container.dart';
import 'package:test_project/web_ui/pepsi/icon_column.dart';
import 'package:test_project/web_ui/pepsi/top_bar.dart';

class PepsiUi extends StatefulWidget {
  const PepsiUi({Key? key}) : super(key: key);

  @override
  State<PepsiUi> createState() => _PepsiUiState();
}

class _PepsiUiState extends State<PepsiUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xff2762ae),
              Color(0xff193e85),
            ],
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            //the big pepsi image
            Positioned(
              top: 12.0.h,
              left: -30.0.w,
              child: Image.asset(
                'assets/images/pepsi_can.png',
                height: 1000.0,
                width: 2500.0,
                fit: BoxFit.fitWidth,
              ).fadeInList(0, false),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //top bar
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: TopBar(),
                  ),
                  //The body of our ui
                  Container(
                    height: 63.h,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 45.0),
                            //social icons column
                            child: IconColumn(),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 5.0.h,
                            ),
                            //body text widgets
                            child: const BodyText(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //footer
                  Expanded(
                    child: Row(
                      children: [
                        const FirstContainer(),
                        Container(
                          width: 25.0.w,
                          color: Colors.black.withOpacity(0.8),
                          child: const SecondContainer(),
                        ),
                        Expanded(
                          child: Container(
                            color: const Color(0xff79bcff),
                            child: const ThirdContainer(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
