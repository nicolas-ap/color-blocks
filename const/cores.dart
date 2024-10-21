import 'package:flutter/material.dart';
import 'package:get/get.dart';

RxList<HSLColor> cores = [
    const HSLColor.fromAHSL(1, 5, 1, 0.2),
    const HSLColor.fromAHSL(1, 40, 1, 0.2),
    const HSLColor.fromAHSL(1, 60, 1, 0.2),
    const HSLColor.fromAHSL(1, 115, 1, 0.2),
    const HSLColor.fromAHSL(1, 180, 1, 0.2),
    const HSLColor.fromAHSL(1, 215, 1, 0.2),
    const HSLColor.fromAHSL(1, 250, 1, 0.2),
    const HSLColor.fromAHSL(1, 285, 1, 0.2),
    const HSLColor.fromAHSL(1, 320, 1, 0.2),
  ].obs;