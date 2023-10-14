import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:test_project/clock/home.dart';
import 'package:test_project/discord/discord.dart';
import 'package:test_project/draggable_squares/home.dart';
import 'package:test_project/flutter_compass/home.dart';
import 'package:test_project/gamepad/gamepad.dart';
import 'package:test_project/github/home.dart';
import 'package:test_project/gradient_spinner/spinner_home.dart';
import 'package:test_project/loading_circle/loading_circle.dart';
import 'package:test_project/parallax_ui/parallax_scroll.dart';
import 'package:test_project/rotating_container/home.dart';
import 'package:test_project/spongebob/painter.dart';
import 'package:test_project/starbucks/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Animation',
          debugShowCheckedModeBanner: false,
          theme: themeData(
            ThemeData(
              appBarTheme: const AppBarTheme(
                elevation: 0.0,
                backgroundColor: Colors.transparent,
              ),
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.blue,
                brightness: Brightness.light,
              ).copyWith(
                background: Colors.white,
              ),
            ),
          ),
          home: const ParallaxScroll(),
        );
      },
    );
  }
}

// Apply font to our app's theme
ThemeData themeData(ThemeData theme) {
  return theme.copyWith(
    textTheme: GoogleFonts.corbenTextTheme(
      theme.textTheme,
    ),
  );
}

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: GoogleLogo(),
//     );
//   }
// }

// class GoogleLogo extends StatefulWidget {
//   final double size;

//   const GoogleLogo({Key key, this.size = 300}) : super(key: key);

//   @override
//   _GoogleLogoState createState() => _GoogleLogoState();
// }

// class _GoogleLogoState extends State<GoogleLogo> with TickerProviderStateMixin {
//   AnimationController controller;
//   CurvedAnimation curvedAnimation;

//   @override
//   void initState() {
//     animate();
//     super.initState();
//   }

//   int index = 4;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.center,
//       color: Colors.white,
//       child: AnimatedBuilder(
//         animation: controller,
//         builder: (context, _) {
//           return CustomPaint(
//             painter: GoogleLogoPainter(
//               animation: curvedAnimation,
//               index: index,
//             ),
//             size: Size.square(widget.size),
//           );
//         },
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   void animate() {
//     controller = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 1000),
//     );
//     curvedAnimation = CurvedAnimation(
//       parent: controller,
//       curve: Curves.fastOutSlowIn,
//     );
//     controller.forward();
//     controller.addStatusListener(
//           (status) {
//         if (status == AnimationStatus.completed) {
//           controller.reset();
//           setState(() {
//             index--;
//           });
//           controller.forward();
//         }
//       },
//     );
//   }
// }

// class GoogleLogoPainter extends CustomPainter {
//   GoogleLogoPainter({this.index, this.animation});

//   @override
//   bool shouldRepaint(_) => true;

//   final int index;
//   final Animation animation;

//   @override
//   void paint(Canvas canvas, Size size) {
//     final length = size.width;
//     final verticalOffset = (size.height / 2) - (length / 2);
//     final bounds = Offset(0, verticalOffset) & Size.square(length);
//     final center = bounds.center;
//     final arcThickness = size.width / 4.5;
//     final paint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = arcThickness;

//     void drawArc(double startAngle, double sweepAngle, Color color, int index) {
//       final _paint = paint..color = color;
//       var animatedSweepAngle = (this.index == index
//           ? animation.value
//           : this.index > index
//           ? 0.0
//           : 1.0) *
//           sweepAngle;
//       canvas.drawArc(
//         bounds,
//         startAngle,
//         animatedSweepAngle,
//         false,
//         _paint,
//       );
//     }

//     drawArc(3.5, 1.9, Colors.red, 0);
//     drawArc(2.5, 1.0, Colors.amber, 1);
//     drawArc(0.9, 1.6, Colors.green.shade600, 2);
//     drawArc(-0.18, 1.1, Colors.blue.shade600, 3);

//     var r = bounds.centerRight.dx + (arcThickness / 2) - 4;
//     canvas.drawRect(
//       Rect.fromLTRB(
//         center.dx,
//         center.dy - (arcThickness / 2),
//         index == 4
//             ? getAnimValue(start: size.width / 2, end: r, animation: animation)
//             : r,
//         bounds.centerRight.dy + (arcThickness / 2),
//       ),
//       paint
//         ..color = Colors.blue.shade600
//         ..style = PaintingStyle.fill
//         ..strokeWidth = 0,
//     );
//   }

//   double getAnimValue({double start, double end, Animation animation}) {
//     return ((end - start) * animation.value) + start;
//   }
// }
