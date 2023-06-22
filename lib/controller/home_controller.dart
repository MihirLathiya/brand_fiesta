import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

class HomeController extends GetxController {
  CarouselController carouselController = CarouselController();
  PageController pageController = PageController();

  int selectCarouselPage = 0;

  /// UPDATE CarouselPage INDEX
  updateCarouselPage(int value) {
    selectCarouselPage = value;
    update();
  }
}
