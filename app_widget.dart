import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:color_blocks/view/game.dart';


class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Game(),
    );
  }
}
