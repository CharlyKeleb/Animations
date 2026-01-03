import 'package:flutter/widgets.dart';

import '../androidlogo/home.dart' as android_logo;
import '../apple_card/apple_card.dart' as apple_card;
import '../battery/home.dart' as battery;
import '../card_flip/flip_animation.dart' as card_flip;
import '../chess/home.dart' as chess;
import '../clock/home.dart' as clock;
import '../curves/curve_container.dart' as curves;
import '../discord/discord.dart' as discord;
import '../draggable_squares/home.dart' as draggable_squares;
import '../duolingo/home.dart' as duolingo;
import '../flutter_compass/home.dart' as compass;
import '../flutter_dash/home.dart' as flutter_dash;
import '../gamepad/gamepad.dart' as gamepad;
import '../github/home.dart' as github;
import '../glow/glow.dart' as glow;
import '../gradient_spinner/spinner_home.dart' as gradient_spinner;
import '../loading_circle/loading_circle.dart' as loading_circle;
import '../matrix/home.dart' as matrix;
import '../parallax_ui/parallax_scroll.dart' as parallax;
import '../parot/home.dart' as parot;
import '../rotating_container/home.dart' as rotating_container;
import '../signature/signature.dart' as signature;
import '../sphere_animation/sphere.dart' as sphere;
import '../spider/spider_home.dart' as spider;
import '../spongebob/home.dart' as spongebob;
import '../squidgame/home.dart' as squidgame;
import '../starbucks/home.dart' as starbucks;
import '../typing/animated_type.dart' as typing;

import 'model/demo.dart';

/// Single place where demos are registered.
///
/// Keep these entries small and stable so adding a new demo is straightforward:
/// 1) create demo widget
/// 2) add an entry here
/// 3) (optional) add screenshot + tags
class DemoRegistry {
  DemoRegistry._();

  static const List<Demo> demos = <Demo>[
    Demo(
      id: 'android_logo',
      title: 'Android Logo',
      builder: _androidLogo,
      tags: ['custom_paint', 'animation'],
    ),
    Demo(
      id: 'apple_card',
      title: 'Apple Card',
      builder: _appleCard,
      tags: ['ui'],
    ),
    Demo(
        id: 'battery',
        title: 'Battery',
        builder: _battery,
        tags: ['custom_paint']),
    Demo(
      id: 'card_flip',
      title: 'Flipping Card',
      builder: _cardFlip,
      tags: ['animation', 'ui'],
    ),
    Demo(id: 'chess', title: 'Chess', builder: _chess, tags: ['ui']),
    Demo(id: 'clock', title: 'Clock', builder: _clock, tags: ['custom_paint']),
    Demo(id: 'curves', title: 'Curves', builder: _curves, tags: ['ui']),
    Demo(id: 'discord', title: 'Discord', builder: _discord, tags: ['ui']),
    Demo(
        id: 'draggable_squares',
        title: 'Draggable Squares',
        builder: _draggableSquares,
        tags: ['gesture']),
    Demo(
        id: 'duolingo',
        title: 'Duolingo',
        builder: _duolingo,
        tags: ['custom_paint']),
    Demo(id: 'compass', title: 'Compass', builder: _compass, tags: ['sensor']),
    Demo(
        id: 'flutter_dash',
        title: 'Flutter Dash',
        builder: _flutterDash,
        tags: ['custom_paint']),
    Demo(id: 'gamepad', title: 'Gamepad', builder: _gamepad, tags: ['ui']),
    Demo(
        id: 'github',
        title: 'GitHub',
        builder: _github,
        tags: ['custom_paint']),
    Demo(id: 'glow', title: 'Glow', builder: _glow, tags: ['effects']),
    Demo(
        id: 'gradient_spinner',
        title: 'Gradient Spinner',
        builder: _gradientSpinner,
        tags: ['animation']),
    Demo(
        id: 'loading_circle',
        title: 'Loading Circle',
        builder: _loadingCircle,
        tags: ['animation']),
    Demo(id: 'matrix', title: 'Matrix', builder: _matrix, tags: ['effects']),
    Demo(
        id: 'parallax', title: 'Parallax UI', builder: _parallax, tags: ['ui']),
    Demo(
        id: 'parot',
        title: 'Parot',
        builder: _parot,
        tags: ['custom_paint', 'animation']),
    Demo(
        id: 'rotating_container',
        title: 'Rotating Container',
        builder: _rotatingContainer,
        tags: ['animation']),
    Demo(
        id: 'signature',
        title: 'Signature',
        builder: _signature,
        tags: ['drawing']),
    Demo(
        id: 'sphere',
        title: 'Sphere Animation',
        builder: _sphere,
        tags: ['custom_paint']),
    Demo(
        id: 'spider',
        title: 'Spider',
        builder: _spider,
        tags: ['custom_paint']),
    Demo(
        id: 'spongebob',
        title: 'SpongeBob',
        builder: _spongebob,
        tags: ['custom_paint']),
    Demo(
        id: 'squidgame',
        title: 'Squid Game',
        builder: _squidgame,
        tags: ['ui']),
    Demo(
        id: 'starbucks', title: 'Starbucks', builder: _starbucks, tags: ['ui']),
    Demo(
        id: 'typing',
        title: 'Typing Indicator',
        builder: _typing,
        tags: ['ui']),
  ];

  static Demo? byId(String id) {
    for (final demo in demos) {
      if (demo.id == id) return demo;
    }
    return null;
  }
}

Widget _androidLogo(BuildContext context) => const android_logo.AndroidHome();

Widget _appleCard(BuildContext context) => const apple_card.AppleCard();

Widget _battery(BuildContext context) => const battery.BatteryHomePage();

Widget _cardFlip(BuildContext context) => card_flip.FlipAnimation();

Widget _chess(BuildContext context) => const chess.ChessHome();

Widget _clock(BuildContext context) => const clock.ClockHome();

Widget _curves(BuildContext context) => const curves.CurveContainer();

Widget _discord(BuildContext context) => const discord.DiscordHome();

Widget _draggableSquares(BuildContext context) =>
    const draggable_squares.Home();

Widget _duolingo(BuildContext context) => const duolingo.Duolingo();

Widget _compass(BuildContext context) => const compass.CompassHome();

Widget _flutterDash(BuildContext context) => const flutter_dash.FlutterDash();

Widget _gamepad(BuildContext context) => const gamepad.GamePad();

Widget _github(BuildContext context) => const github.Github();

Widget _glow(BuildContext context) => const glow.GlowAnimationScreen();

Widget _gradientSpinner(BuildContext context) =>
    const gradient_spinner.GradientSpinner();

Widget _loadingCircle(BuildContext context) =>
    const loading_circle.LoadingFaceAnimationScreen();

Widget _matrix(BuildContext context) => const matrix.MatrixHome();

Widget _parallax(BuildContext context) => const parallax.ParallaxScroll();

Widget _parot(BuildContext context) => const parot.BirdLogoPage();

Widget _rotatingContainer(BuildContext context) =>
    const rotating_container.RotationHome();

Widget _signature(BuildContext context) => const signature.SignatureAnimation();

Widget _sphere(BuildContext context) => const sphere.SphereAnimation();

Widget _spider(BuildContext context) => const spider.SpiderHome();

Widget _spongebob(BuildContext context) => const spongebob.SpongeBobHome();

Widget _squidgame(BuildContext context) => const squidgame.SquidGameHome();

Widget _starbucks(BuildContext context) => const starbucks.StarBucks();

Widget _typing(BuildContext context) => const typing.ExampleIsTyping();
