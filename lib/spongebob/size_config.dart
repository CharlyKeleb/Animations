import 'package:flutter/material.dart';
import 'dart:math' as maths;

mixin SizesHelper {
  late Size _size;

  initSize(Size value) {
    _size = value;
  }

  double get w230 => _size.width * 0.639;

  double get w190 => _size.width * 0.528;

  double get w185 => _size.width * 0.514;

  double get w170 => _size.width * 0.4725;

  double get w160 => _size.width * 0.445;

  double get w155 => _size.width * 0.4306;

  double get w150 => _size.width * 0.4167;

  double get w148 => _size.width * 0.4113;

  double get w145 => _size.width * 0.403;

  double get w140 => _size.width * 0.389;

  double get w135 => _size.width * 0.375;

  double get w130 => _size.width * 0.362;

  double get w125 => _size.width * 0.3475;

  double get w120 => _size.width * 0.335;

  double get w115 => _size.width * 0.3195;

  double get w110 => _size.width * 0.306;

  double get w108 => _size.width * 0.3;

  double get w105 => _size.width * 0.292;

  double get w100 => _size.width * 0.278;

  double get w90 => _size.width * 0.25;

  double get w87 => _size.width * 0.2417;

  double get w85 => _size.width * 0.2363;

  double get w80 => _size.width * 0.223;

  double get w75 => _size.width * 0.209;

  double get w70 => _size.width * 0.194;

  double get w65 => _size.width * 0.1807;

  double get w62 => _size.width * 0.1724;

  double get w60 => _size.width * 0.167;

  double get w57 => _size.width * 0.1585;

  double get w55 => _size.width * 0.154;

  double get w50 => _size.width * 0.14;

  double get w46 => _size.width * 0.13;

  double get w45 => _size.width * 0.125;

  double get w42 => _size.width * 0.1167;

  double get w40 => _size.width * 0.112;

  double get w35 => _size.width * 0.0975;

  double get w30 => _size.width * 0.085;

  double get w28 => _size.width * 0.078;

  double get w27 => _size.width * 0.075;

  double get w25 => _size.width * 0.07;

  double get w24 => _size.width * 0.067;

  double get w23 => _size.width * 0.064;

  double get w20 => _size.width * 0.056;

  double get w18 => _size.width * 0.05;

  double get w15 => _size.width * 0.0418;

  double get w14 => _size.width * 0.0389;

  double get w13 => _size.width * 0.0363;

  double get w12 => _size.width * 0.035;

  double get w9 => _size.width * 0.025;

  double get w10 => _size.width * 0.03;

  double get w7 => _size.width * 0.0195;

  double get w6 => _size.width * 0.0167;

  double get w5 => _size.width * 0.014;

  double get w4 => _size.width * 0.0112;

  double get w3 => _size.width * 0.0085;

  double get w2_5 => _size.width * 0.00695;

  double get h330 => _size.height * 0.66;

  double get h297 => _size.height * 0.594;

  double get h290 => _size.height * 0.58;

  double get h270 => _size.height * 0.54;

  double get h265 => _size.height * 0.53;

  double get h260 => _size.height * 0.52;

  double get h255 => _size.height * 0.51;

  double get h245 => _size.height * 0.49;

  double get h240 => _size.height * 0.48;

  double get h235 => _size.height * 0.47;

  double get h230 => _size.height * 0.46;

  double get h225 => _size.height * 0.45;

  double get h220 => _size.height * 0.44;

  double get h210 => _size.height * 0.42;

  double get h200 => _size.height * 0.4;

  double get h195 => _size.height * 0.39;

  double get h190 => _size.height * 0.38;

  double get h185 => _size.height * 0.37;

  double get h180 => _size.height * 0.36;

  double get h174 => _size.height * 0.348;

  double get h170 => _size.height * 0.34;

  double get h165 => _size.height * 0.33;

  double get h160 => _size.height * 0.32;

  double get h155 => _size.height * 0.31;

  double get h150 => _size.height * 0.3;

  double get h140 => _size.height * 0.28;

  double get h130 => _size.height * 0.26;

  double get h125 => _size.height * 0.25;

  double get h120 => _size.height * 0.24;

  double get h115 => _size.height * 0.23;

  double get h112 => _size.height * 0.224;

  double get h110 => _size.height * 0.22;

  double get h100 => _size.height * 0.2;

  double get h98 => _size.height * 0.196;

  double get h95 => _size.height * 0.19;

  double get h90 => _size.height * 0.18;

  double get h87 => _size.height * 0.174;

  double get h80 => _size.height * 0.16;

  double get h78 => _size.height * 0.156;

  double get h77 => _size.height * 0.154;

  double get h75 => _size.height * 0.15;

  double get h74 => _size.height * 0.148;

  double get h70 => _size.height * 0.14;

  double get h65 => _size.height * 0.13;

  double get h60 => _size.height * 0.12;

  double get h58 => _size.height * 0.114;

  double get h57 => _size.height * 0.114;

  double get h55 => _size.height * 0.11;

  double get h52 => _size.height * 0.104;

  double get h50 => _size.height * 0.1;

  double get h45 => _size.height * 0.09;

  double get h40 => _size.height * 0.08;

  double get h35 => _size.height * 0.07;

  double get h32 => _size.height * 0.064;

  double get h30 => _size.height * 0.06;

  double get h25 => _size.height * 0.05;

  double get h20 => _size.height * 0.04;

  double get h15 => _size.height * 0.03;

  double get h12 => _size.height * 0.024;

  double get h10 => _size.height * 0.02;

  double get h7 => _size.height * 0.014;

  double get h6 => _size.height * 0.012;

  double get h4 => _size.height * 0.008;

  double get h2_5 => _size.height * 0.005;
}

mixin Mathshelper {

  double computeRangeMinMax(double animationValue, double min, double max) {
    return ((max - min) * animationValue) + min;
  }

  double convertToRadian(double degree) => degree * maths.pi / 180;
}