import 'package:flutter/material.dart';
import 'navigation_service.dart';

/// Custom Snackbar Service for showing notifications and messages
/// This service provides a clean interface for snackbars without GetX
class SnackbarService {
  static final SnackbarService _instance = SnackbarService._internal();
  factory SnackbarService() => _instance;
  SnackbarService._internal();

  static SnackbarService get instance => _instance;

  /// Show a success snackbar
  void showSuccess({
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    _showSnackbar(
      message: message,
      title: title,
      backgroundColor: Colors.green,
      icon: Icons.check_circle,
      duration: duration,
      action: action,
    );
  }

  /// Show an error snackbar
  void showError({
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 4),
    SnackBarAction? action,
  }) {
    _showSnackbar(
      message: message,
      title: title,
      backgroundColor: Colors.red,
      icon: Icons.error,
      duration: duration,
      action: action,
    );
  }

  /// Show a warning snackbar
  void showWarning({
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    _showSnackbar(
      message: message,
      title: title,
      backgroundColor: Colors.orange,
      icon: Icons.warning,
      duration: duration,
      action: action,
    );
  }

  /// Show an info snackbar
  void showInfo({
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    _showSnackbar(
      message: message,
      title: title,
      backgroundColor: Colors.blue,
      icon: Icons.info,
      duration: duration,
      action: action,
    );
  }

  /// Show a custom snackbar
  void showCustom({
    required String message,
    String? title,
    Color? backgroundColor,
    Color? textColor,
    IconData? icon,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
    EdgeInsets? margin,
    ShapeBorder? shape,
  }) {
    _showSnackbar(
      message: message,
      title: title,
      backgroundColor: backgroundColor,
      textColor: textColor,
      icon: icon,
      duration: duration,
      action: action,
      margin: margin,
      shape: shape,
    );
  }

  /// Private method to show snackbar
  void _showSnackbar({
    required String message,
    String? title,
    Color? backgroundColor,
    Color? textColor,
    IconData? icon,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
    EdgeInsets? margin,
    ShapeBorder? shape,
  }) {
    final context = NavigationService.instance.currentContext;
    if (context == null) return;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: _buildSnackbarContent(
          message: message,
          title: title,
          icon: icon,
          textColor: textColor ?? Colors.white,
        ),
        backgroundColor: backgroundColor ?? colorScheme.surface,
        duration: duration,
        action: action,
        margin: margin,
        shape: shape ?? RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Build snackbar content widget
  Widget _buildSnackbarContent({
    required String message,
    String? title,
    IconData? icon,
    Color textColor = Colors.white,
  }) {
    return Row(
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            color: textColor,
            size: 24,
          ),
          const SizedBox(width: 12),
        ],
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null) ...[
                Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
              ],
              Text(
                message,
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Hide current snackbar
  void hideSnackbar() {
    final context = NavigationService.instance.currentContext;
    if (context != null) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    }
  }

  /// Clear all snackbars
  void clearSnackbars() {
    final context = NavigationService.instance.currentContext;
    if (context != null) {
      ScaffoldMessenger.of(context).clearSnackBars();
    }
  }
}

/// Snackbar helper extensions
extension SnackbarExtensions on BuildContext {
  /// Quick access to snackbar service
  SnackbarService get snackbar => SnackbarService.instance;
} 