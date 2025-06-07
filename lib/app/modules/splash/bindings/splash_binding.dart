import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

/// Splash Binding
/// Manages dependencies for the splash module
class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
      () => SplashController(),
    );
  }
} 