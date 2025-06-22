import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_colors.dart';
import '../controllers/splash_controller.dart';

/// Splash View
/// Entry point of the application with loading animation
class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.ghostWhite,
              Color(0xFFFFFDF7),
              Color(0xFFFFFBEC),
            ],
          ),
        ),
        child: ResponsiveLayout(
          mobile: _buildMobileLayout(context),
          tablet: _buildTabletLayout(context),
          desktop: _buildDesktopLayout(context),
        ),
      ),
    );
  }

  /// Mobile layout
  Widget _buildMobileLayout(BuildContext context) {
    return _buildMainContent(context, isMobile: true);
  }

  /// Tablet layout
  Widget _buildTabletLayout(BuildContext context) {
    return _buildMainContent(context, isMobile: false);
  }

  /// Desktop layout
  Widget _buildDesktopLayout(BuildContext context) {
    return _buildMainContent(context, isMobile: false);
  }

  /// Main content
  Widget _buildMainContent(BuildContext context, {required bool isMobile}) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: Responsive.maxContentWidth(context),
        ),
        padding: Responsive.responsivePadding(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo/Title
            _buildLogo(context, isMobile),
            
            SizedBox(height: Responsive.spacing(context, factor: 4)),
            
            // Loading indicator
            _buildLoadingIndicator(context),
            
            SizedBox(height: Responsive.spacing(context, factor: 2)),
            
            // Loading message
            _buildLoadingMessage(context),
            
            SizedBox(height: Responsive.spacing(context, factor: 4)),
            
            // Retry button (shown only on error)
            _buildRetryButton(context),
          ],
        ),
      ),
    );
  }

  /// Build logo/title
  Widget _buildLogo(BuildContext context, bool isMobile) {
    return TweenAnimationBuilder<double>(
      duration: AppConstants.defaultAnimationDuration,
      tween: Tween<double>(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Opacity(
            opacity: value,
            child: Column(
              children: [
                Icon(
                  Icons.person,
                  size: isMobile ? 80 : 120,
                  color: AppColors.sunshine,
                ),
                SizedBox(height: Responsive.spacing(context)),
                Text(
                  AppConstants.appName,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: AppColors.night,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: Responsive.spacing(context, factor: 0.5)),
                Text(
                  'Professional Portfolio',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.night.withOpacity(0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Build loading indicator
  Widget _buildLoadingIndicator(BuildContext context) {
    return Obx(() => controller.isLoading
        ? const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.sunshine),
          )
        : const SizedBox.shrink());
  }

  /// Build loading message
  Widget _buildLoadingMessage(BuildContext context) {
    return Obx(() => AnimatedSwitcher(
          duration: AppConstants.fastAnimationDuration,
          child: Text(
            controller.loadingMessage,
            key: ValueKey(controller.loadingMessage),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.night.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ));
  }

  /// Build retry button
  Widget _buildRetryButton(BuildContext context) {
    return Obx(() => !controller.isLoading &&
            controller.loadingMessage.contains('Error')
        ? TweenAnimationBuilder<double>(
            duration: AppConstants.defaultAnimationDuration,
            tween: Tween<double>(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Opacity(
                  opacity: value,
                  child: ElevatedButton(
                    onPressed: controller.retryInitialization,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.sunshine,
                      foregroundColor: AppColors.night,
                    ),
                    child: const Text('Retry'),
                  ),
                ),
              );
            },
          )
        : const SizedBox.shrink());
  }
} 