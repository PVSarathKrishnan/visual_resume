import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/bindings/initial_binding.dart';
import 'core/routes/app_routes.dart';
import 'core/services/navigation_service.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_strings.dart';

void main() {
  runApp(const VisualResumeApp());
}

class VisualResumeApp extends StatelessWidget {
  const VisualResumeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // App Configuration
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      
      // Navigation
      navigatorKey: NavigationService.instance.navigatorKey,
      initialRoute: AppRoutes.initial,
      onGenerateRoute: AppRoutes.generateRoute,
      onUnknownRoute: AppRoutes.unknownRoute,
      
      // GetX Bindings
      initialBinding: InitialBinding(),
      
      // Theme Configuration
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      
      // Localization
      locale: const Locale('en', 'US'),
      
      // Web configuration for better SEO and performance
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(1.0), // Prevent text scaling issues
          ),
          child: GestureDetector(
            onTap: () {
              // Dismiss any focus to prevent mouse tracker issues
              FocusScope.of(context).unfocus();
            },
            child: child!,
          ),
        );
      },
    );
  }
}
