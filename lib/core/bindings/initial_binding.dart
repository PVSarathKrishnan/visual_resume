import 'package:get/get.dart';
import '../services/navigation_service.dart';
import '../services/snackbar_service.dart';
import '../../app/modules/splash/controllers/splash_controller.dart';

/// Core services initialization
class CoreServices {
  /// Initialize core services
  static void init() {
    // Navigation Service
    NavigationService.instance;

    // Snackbar Service
    SnackbarService.instance;

    // Provide SplashController for SplashView
    Get.lazyPut<SplashController>(() => SplashController(), fenix: true);
  }
} 