import 'package:flutter/material.dart';

/// Custom Navigation Service for managing app navigation
/// This service provides a clean interface for navigation without GetX
class NavigationService {
  static final NavigationService _instance = NavigationService._internal();
  factory NavigationService() => _instance;
  NavigationService._internal();

  static NavigationService get instance => _instance;

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  /// Get the current context
  BuildContext? get currentContext => _navigatorKey.currentContext;

  /// Navigate to a new page
  Future<T?> navigateTo<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return _navigatorKey.currentState!.pushNamed<T>(
      routeName,
      arguments: arguments,
    );
  }

  /// Navigate to a new page and remove all previous routes
  Future<T?> navigateToAndClearStack<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return _navigatorKey.currentState!.pushNamedAndRemoveUntil<T>(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  /// Navigate to a new page and replace the current one
  Future<T?> navigateToAndReplace<T extends Object?, TO extends Object?>(
    String routeName, {
    Object? arguments,
    TO? result,
  }) {
    return _navigatorKey.currentState!.pushReplacementNamed<T, TO>(
      routeName,
      arguments: arguments,
      result: result,
    );
  }

  /// Navigate using a custom route
  Future<T?> navigateToPage<T extends Object?>(
    Widget page, {
    bool fullscreenDialog = false,
    RouteSettings? settings,
  }) {
    return _navigatorKey.currentState!.push<T>(
      MaterialPageRoute<T>(
        builder: (context) => page,
        fullscreenDialog: fullscreenDialog,
        settings: settings,
      ),
    );
  }

  /// Navigate using a custom route and replace current
  Future<T?> navigateToPageAndReplace<T extends Object?, TO extends Object?>(
    Widget page, {
    bool fullscreenDialog = false,
    RouteSettings? settings,
    TO? result,
  }) {
    return _navigatorKey.currentState!.pushReplacement<T, TO>(
      MaterialPageRoute<T>(
        builder: (context) => page,
        fullscreenDialog: fullscreenDialog,
        settings: settings,
      ),
      result: result,
    );
  }

  /// Go back to the previous page
  void goBack<T extends Object?>([T? result]) {
    if (canGoBack()) {
      _navigatorKey.currentState!.pop<T>(result);
    }
  }

  /// Check if we can go back
  bool canGoBack() {
    return _navigatorKey.currentState?.canPop() ?? false;
  }

  /// Go back until a specific route
  void goBackUntil(String routeName) {
    _navigatorKey.currentState!.popUntil(
      ModalRoute.withName(routeName),
    );
  }

  /// Go back until a specific predicate is met
  void goBackUntilPredicate(bool Function(Route<dynamic>) predicate) {
    _navigatorKey.currentState!.popUntil(predicate);
  }

  /// Clear all routes and navigate to a new one
  void clearStackAndNavigateTo(String routeName, {Object? arguments}) {
    _navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  /// Show a modal bottom sheet
  Future<T?> showBottomSheet<T>({
    required Widget child,
    bool isScrollControlled = false,
    bool isDismissible = true,
    bool enableDrag = true,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    Color? barrierColor,
    bool useRootNavigator = false,
    RouteSettings? routeSettings,
  }) {
    return showModalBottomSheet<T>(
      context: currentContext!,
      builder: (context) => child,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      clipBehavior: clipBehavior,
      barrierColor: barrierColor,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
    );
  }

  /// Show a dialog
  Future<T?> showCustomDialog<T>({
    required Widget child,
    bool barrierDismissible = true,
    Color? barrierColor,
    String? barrierLabel,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
  }) {
    return showDialog<T>(
      context: currentContext!,
      builder: (context) => child,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      barrierLabel: barrierLabel,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
    );
  }
}

/// Navigation helper extensions
extension NavigationExtensions on BuildContext {
  /// Quick access to navigation service
  NavigationService get nav => NavigationService.instance;
} 