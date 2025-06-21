import 'package:flutter/material.dart';
import 'core/bindings/initial_binding.dart';
import 'core/routes/app_routes.dart';
import 'core/services/navigation_service.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_strings.dart';

void main() {
  // Initialize core services
  CoreServices.init();

  runApp(const VisualResumeApp());
}

class VisualResumeApp extends StatelessWidget {
  const VisualResumeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // App Configuration
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      
      // Navigation
      navigatorKey: NavigationService.instance.navigatorKey,
      initialRoute: AppRoutes.initial,
      onGenerateRoute: AppRoutes.generateRoute,
      onUnknownRoute: AppRoutes.unknownRoute,
      
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
          child: child!,
        );
      },
    );
  }
}
