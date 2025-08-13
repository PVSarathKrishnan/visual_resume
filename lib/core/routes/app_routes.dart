import 'package:flutter/material.dart';
import '../../app/modules/home/views/home_view.dart';
import '../../app/modules/about/views/about_view.dart';
import '../../app/modules/experience/views/experience_view.dart';
import '../../app/modules/projects/views/projects_view.dart';
import '../../app/modules/skills/views/skills_view.dart';
import '../../app/modules/contact/views/contact_view.dart';
import '../../app/modules/projects/views/project_mpj_view.dart';
import '../../app/modules/projects/views/project_leadsden_view.dart';
import '../../app/modules/projects/views/project_fintalkr_view.dart';
import '../../app/modules/projects/views/project_piggyback_sports_view.dart';
import '../../app/modules/projects/views/project_tanq_driver_view.dart';
import '../../app/modules/projects/views/project_knack_view.dart';
import '../../app/modules/projects/views/project_budget_bee_view.dart';
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
  // Project detail routes
  static const String projectMpj = '/project/mpj';
  static const String projectLeadsden = '/project/leadsden';
  static const String projectFintalkr = '/project/fintalkr';
  static const String projectPiggybackSports = '/project/piggyback-sports';
  static const String projectTanqDriver = '/project/tanq-driver';
  static const String projectKnack = '/project/knack';
  static const String projectBudgetBee = '/project/budget-bee';

  // Initial Route
  static const String initial = splash;

  /// Standard route generation method
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _createRoute(const SplashView());
      case home:
        return _createRoute(const HomeView());
      case about:
        return _createRoute(const AboutView());
      case experience:
        return _createRoute(const ExperienceView());
      case projects:
        return _createRoute(const ProjectsView());
      case skills:
        return _createRoute(const SkillsView());
      case contact:
        return _createRoute(const ContactView());
      case projectMpj:
        return _createRoute(const ProjectMpjView());
      case projectLeadsden:
        return _createRoute(const ProjectLeadsdenView());
      case projectFintalkr:
        return _createRoute(const ProjectFintalkrView());
      case projectPiggybackSports:
        return _createRoute(const ProjectPiggybackSportsView());
      case projectTanqDriver:
        return _createRoute(const ProjectTanqDriverView());
      case projectKnack:
        return _createRoute(const ProjectKnackView());
      case projectBudgetBee:
        return _createRoute(const ProjectBudgetBeeView());
      default:
        return _createRoute(const NotFoundView());
    }
  }

  /// Custom page route with slide transition
  static Route<dynamic> _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  /// Not Found View for undefined routes
  static Route<dynamic> unknownRoute(RouteSettings settings) {
    return _createRoute(const NotFoundView());
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
      projectMpj,
      projectLeadsden,
      projectFintalkr,
      projectPiggybackSports,
      projectTanqDriver,
      projectKnack,
      projectBudgetBee,
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
      case projectMpj:
        return 'My Property Journey';
      case projectLeadsden:
        return 'Leadsden';
      case projectFintalkr:
        return 'Fintalkr';
      case projectPiggybackSports:
        return 'Piggyback Sports';
      case projectTanqDriver:
        return 'Tanq Driver';
      case projectKnack:
        return 'Knack';
      case projectBudgetBee:
        return 'Budget Bee';
      default:
        return 'Unknown';
    }
  }

  /// Map project name to its dedicated route
  static String? getProjectRouteByName(String projectName) {
    switch (projectName) {
      case 'My Property Journey':
        return projectMpj;
      case 'Leadsden':
        return projectLeadsden;
      case 'Fintalkr':
        return projectFintalkr;
      case 'Piggyback Sports':
        return projectPiggybackSports;
      case 'Tanq Driver':
        return projectTanqDriver;
      case 'Knack':
        return projectKnack;
      case 'Budget Bee':
        return projectBudgetBee;
      default:
        return null;
    }
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