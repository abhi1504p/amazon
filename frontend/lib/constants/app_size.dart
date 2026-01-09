import 'package:get/get.dart';



class AppSize {
    // Android base design size
    static const double _designHeight = 800;
    static const double _designWidth = 360;

    static double h(double px) {
        return (px / _designHeight) * Get.height;
    }

    static double w(double px) {
        return (px / _designWidth) * Get.width;
    }
}

