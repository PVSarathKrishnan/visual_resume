import 'package:get/get.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/services/navigation_service.dart';

/// Splash Controller
/// Handles splash screen logic and navigation
class SplashController extends GetxController {
  // Services
  final NavigationService _navigationService = Get.find<NavigationService>();

  // Observable variables
  final RxBool _isLoading = true.obs;
  final RxString _loadingMessage = 'Loading...'.obs;

  // Getters
  bool get isLoading => _isLoading.value;
  String get loadingMessage => _loadingMessage.value;

  @override
  void onInit() {
    super.onInit();
    _initializeApp();
  }

  /// Initialize app and navigate to home
  Future<void> _initializeApp() async {
    try {
      // Simulate app initialization
      _updateLoadingMessage('Initializing app...');
      await Future.delayed(const Duration(seconds: 1));

      _updateLoadingMessage('Loading resources...');
      await Future.delayed(const Duration(seconds: 1));

      _updateLoadingMessage('Almost ready...');
      await Future.delayed(const Duration(seconds: 1));

      // Navigate to home
      _navigateToHome();
    } catch (e) {
      // Handle initialization error
      _handleInitializationError(e);
    }
  }

  /// Update loading message
  void _updateLoadingMessage(String message) {
    _loadingMessage.value = message;
  }

  /// Navigate to home screen
  void _navigateToHome() {
    _isLoading.value = false;
    _navigationService.navigateToAndClearStack(AppRoutes.home);
  }

  /// Handle initialization error
  void _handleInitializationError(dynamic error) {
    _isLoading.value = false;
    _loadingMessage.value = 'Error initializing app';
    
    // You can add error handling logic here
    // For now, just navigate to home after a delay
    Future.delayed(const Duration(seconds: 2), () {
      _navigateToHome();
    });
  }

  /// Retry initialization
  void retryInitialization() {
    _isLoading.value = true;
    _loadingMessage.value = 'Retrying...';
    _initializeApp();
  }
} 