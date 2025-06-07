import 'package:flutter/material.dart';
import '../../app/modules/home/views/home_view.dart';
import '../../app/modules/about/views/about_view.dart';
import '../../app/modules/experience/views/experience_view.dart';
import '../../app/modules/projects/views/projects_view.dart';
import '../../app/modules/skills/views/skills_view.dart';
import '../../app/modules/contact/views/contact_view.dart';
import '../../app/modules/splash/views/splash_view.dart';

/// App Routes Class - Manages all application routes
class AppRoutes {
  // Route Names
  static const String splash = '/splash';
  static const String home = '/home';
  static const String about = '/about';
  static const String experience = '/experience';
  static const String projects = '/projects';
  static const String skills = '/skills';
  static const String contact = '/contact';

  // Initial Route
  static const String initial = splash;

  // Route Generator
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
            case splash:
        return _buildRoute(
          const SplashView(),
          settings: settings,
        );
        
      case home:
        return _buildRoute(
          const HomeView(),
          settings: settings,
        );
        
      case about:
        return _buildRoute(
          const AboutView(),
          settings: settings,
        );
        
      case experience:
        return _buildRoute(
          const ExperienceView(),
          settings: settings,
        );
        
      case projects:
        return _buildRoute(
          const ProjectsView(),
          settings: settings,
        );
        
      case skills:
        return _buildRoute(
          const SkillsView(),
          settings: settings,
        );
        
      case contact:
        return _buildRoute(
          const ContactView(),
          settings: settings,
        );
        
      default:
        return _buildRoute(
          const NotFoundView(),
          settings: settings,
        );
    }
  }

  // Build Route with custom transitions
  static PageRoute<T> _buildRoute<T>(
    Widget child, {
    RouteSettings? settings,
    bool fullscreenDialog = false,
  }) {
    return PageRouteBuilder<T>(
      settings: settings,
      fullscreenDialog: fullscreenDialog,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return _slideTransition(animation, child);
      },
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 300),
    );
  }

  // Slide transition animation
  static Widget _slideTransition(Animation<double> animation, Widget child) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;

    var tween = Tween(begin: begin, end: end).chain(
      CurveTween(curve: curve),
    );

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }

  // Fade transition animation
  static Widget _fadeTransition(Animation<double> animation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  // Scale transition animation
  static Widget _scaleTransition(Animation<double> animation, Widget child) {
    return ScaleTransition(
      scale: animation,
      child: child,
    );
  }

  /// Get all available routes
  static List<String> getAllRoutes() {
    return [
      splash,
      home,
      about,
      experience,
      projects,
      skills,
      contact,
    ];
  }

  /// Check if route exists
  static bool routeExists(String routeName) {
    return getAllRoutes().contains(routeName);
  }

  /// Get route display name
  static String getRouteDisplayName(String routeName) {
    switch (routeName) {
      case splash:
        return 'Splash';
      case home:
        return 'Home';
      case about:
        return 'About';
      case experience:
        return 'Experience';
      case projects:
        return 'Projects';
      case skills:
        return 'Skills';
      case contact:
        return 'Contact';
      default:
        return 'Unknown';
    }
  }

  /// Build placeholder view for routes that don't have views yet
  static Widget _buildPlaceholderView(String title) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.construction,
              size: 100,
              color: Colors.grey,
            ),
            const SizedBox(height: 24),
            Text(
              '$title Page',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'This page is under construction',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

/// Not Found View for undefined routes
class NotFoundView extends StatelessWidget {
  const NotFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Not Found'),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 100,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 24),
            Text(
              '404',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: Theme.of(context).colorScheme.error,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Page Not Found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Text(
              'The page you are looking for does not exist.',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.home,
                  (route) => false,
                );
              },
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
} 