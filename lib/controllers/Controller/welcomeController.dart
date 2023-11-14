import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController{
  final PageController controller = PageController();
  final PageController controller2 = PageController();
  int? newPageIndex;

  void nextPage() {
    newPageIndex = (controller.page!.toInt() + 1) % 3;
    newPageIndex = (controller2.page!.toInt() + 1) % 3;
    // controller.jumpToPage(newPageIndex);
    controller.animateToPage(
      newPageIndex!,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    controller2.animateToPage(
      newPageIndex!,
      duration: Duration(milliseconds: 900),
      curve: Curves.easeInOut,
    );
  }
}