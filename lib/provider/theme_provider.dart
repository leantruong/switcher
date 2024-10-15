import 'package:flutter/material.dart';

class ThemeProvider {
  final AnimationController controller;

  ThemeProvider({required this.controller});

  final containerKey = GlobalKey();

  final container2Key = GlobalKey();

  var size = ValueNotifier(Size.zero);
  var position = const Offset(0, 0);
  var color = Colors.amber;

  void runAnimation() {
    if (controller.isForwardOrCompleted) {
      controller.reverse();
      return;
    }
    final sizeContainer = containerKey.currentContext!.size;
    final sizeContainer2 = container2Key.currentContext!.size;

    size.value = Size(
        sizeContainer!.width - sizeContainer2!.width - 5, sizeContainer.height);
    color = Colors.blueGrey;

    controller.forward();
  }
}
