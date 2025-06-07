import 'package:flutter/material.dart';

/// Responsive utility class for handling different screen sizes
/// Follows Material Design breakpoints with custom optimizations
class Responsive {
  static const double _mobileMaxWidth = 600;
  static const double _tabletMaxWidth = 1024;
  static const double _desktopMinWidth = 1025;

  /// Get the current device type
  static DeviceType getDeviceType(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    
    if (width < _mobileMaxWidth) {
      return DeviceType.mobile;
    } else if (width < _desktopMinWidth) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }

  /// Check if current device is mobile
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < _mobileMaxWidth;
  }

  /// Check if current device is tablet
  static bool isTablet(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width >= _mobileMaxWidth && width < _desktopMinWidth;
  }

  /// Check if current device is desktop
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= _desktopMinWidth;
  }

  /// Get responsive value based on device type
  static T valueWhen<T>({
    required BuildContext context,
    required T mobile,
    T? tablet,
    required T desktop,
  }) {
    if (isMobile(context)) {
      return mobile;
    } else if (isTablet(context)) {
      return tablet ?? desktop;
    } else {
      return desktop;
    }
  }

  /// Get responsive padding
  static EdgeInsets responsivePadding(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: valueWhen(
        context: context,
        mobile: 16.0,
        tablet: 32.0,
        desktop: 64.0,
      ),
      vertical: valueWhen(
        context: context,
        mobile: 16.0,
        tablet: 24.0,
        desktop: 32.0,
      ),
    );
  }

  /// Get responsive font size
  static double responsiveFontSize(
    BuildContext context, {
    required double mobile,
    double? tablet,
    required double desktop,
  }) {
    return valueWhen<double>(
      context: context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }

  /// Get screen width
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Get screen height
  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// Get responsive width percentage
  static double wp(BuildContext context, double percentage) {
    return screenWidth(context) * (percentage / 100);
  }

  /// Get responsive height percentage
  static double hp(BuildContext context, double percentage) {
    return screenHeight(context) * (percentage / 100);
  }

  /// Get responsive spacing
  static double spacing(BuildContext context, {double factor = 1.0}) {
    return valueWhen<double>(
      context: context,
      mobile: 8.0 * factor,
      tablet: 12.0 * factor,
      desktop: 16.0 * factor,
    );
  }

  /// Get responsive border radius
  static double borderRadius(BuildContext context) {
    return valueWhen<double>(
      context: context,
      mobile: 8.0,
      tablet: 12.0,
      desktop: 16.0,
    );
  }

  /// Get maximum content width for centered content
  static double maxContentWidth(BuildContext context) {
    return valueWhen<double>(
      context: context,
      mobile: screenWidth(context),
      tablet: 800.0,
      desktop: 1200.0,
    );
  }

  /// Get grid column count for responsive grids
  static int gridColumns(BuildContext context) {
    return valueWhen<int>(
      context: context,
      mobile: 1,
      tablet: 2,
      desktop: 3,
    );
  }
}

/// Device type enumeration
enum DeviceType {
  mobile,
  tablet,
  desktop,
}

/// Responsive widget builder
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, DeviceType deviceType) builder;

  const ResponsiveBuilder({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return builder(context, Responsive.getDeviceType(context));
  }
}

/// Responsive layout wrapper
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, deviceType) {
        switch (deviceType) {
          case DeviceType.mobile:
            return mobile;
          case DeviceType.tablet:
            return tablet ?? desktop;
          case DeviceType.desktop:
            return desktop;
        }
      },
    );
  }
} 