import 'package:get/get.dart';
import '../services/navigation_service.dart';
import '../services/snackbar_service.dart';

/// Initial binding for core services
/// This binding will be loaded when the app starts
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Register core services as singletons
    _registerServices();
  }

  /// Register all core services
  void _registerServices() {
    // Navigation Service
    Get.put<NavigationService>(
      NavigationService.instance,
      permanent: true,
    );

    // Snackbar Service
    Get.put<SnackbarService>(
      SnackbarService.instance,
      permanent: true,
    );
  }
} 