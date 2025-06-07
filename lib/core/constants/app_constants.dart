/// App-wide constants for consistent values
class AppConstants {
  // App Information
  static const String appName = 'Visual Resume';
  static const String appVersion = '1.0.0';
  static const String developerName = 'Your Name';
  static const String developerEmail = 'your.email@example.com';

  // API Constants
  static const String baseUrl = 'https://api.yourresume.com';
  static const int requestTimeout = 30000; // 30 seconds

  // Storage Keys
  static const String themeKey = 'theme_mode';
  static const String languageKey = 'language_code';
  static const String onboardingKey = 'onboarding_completed';

  // Animation Durations
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration fastAnimationDuration = Duration(milliseconds: 150);
  static const Duration slowAnimationDuration = Duration(milliseconds: 500);

  // Responsive Breakpoints
  static const double mobileMaxWidth = 600;
  static const double tabletMaxWidth = 1024;
  static const double desktopMinWidth = 1025;

  // Spacing
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;

  // Border Radius
  static const double radiusS = 4.0;
  static const double radiusM = 8.0;
  static const double radiusL = 12.0;
  static const double radiusXL = 16.0;
  static const double radiusXXL = 24.0;

  // Elevation
  static const double elevationS = 2.0;
  static const double elevationM = 4.0;
  static const double elevationL = 8.0;
  static const double elevationXL = 12.0;

  // Font Sizes
  static const double fontSizeXS = 10.0;
  static const double fontSizeS = 12.0;
  static const double fontSizeM = 14.0;
  static const double fontSizeL = 16.0;
  static const double fontSizeXL = 18.0;
  static const double fontSizeXXL = 20.0;
  static const double fontSizeHeading1 = 32.0;
  static const double fontSizeHeading2 = 28.0;
  static const double fontSizeHeading3 = 24.0;
  static const double fontSizeHeading4 = 20.0;
  static const double fontSizeHeading5 = 18.0;
  static const double fontSizeHeading6 = 16.0;

  // Icon Sizes
  static const double iconSizeS = 16.0;
  static const double iconSizeM = 24.0;
  static const double iconSizeL = 32.0;
  static const double iconSizeXL = 48.0;

  // Max Content Width
  static const double maxContentWidth = 1200.0;
  static const double maxMobileContentWidth = 400.0;
  static const double maxTabletContentWidth = 800.0;

  // Contact Information (Update with your details)
  static const String linkedInUrl = 'https://linkedin.com/in/yourprofile';
  static const String githubUrl = 'https://github.com/yourusername';
  static const String portfolioUrl = 'https://yourportfolio.com';
  static const String phoneNumber = '+1234567890';
  static const String location = 'Your City, Country';

  // Social Media
  static const String twitterUrl = 'https://twitter.com/yourusername';
  static const String instagramUrl = 'https://instagram.com/yourusername';
  static const String behanceUrl = 'https://behance.net/yourusername';
  static const String dribbbleUrl = 'https://dribbble.com/yourusername';

  // Skills Categories (You can customize these)
  static const List<String> technicalSkills = [
    'Flutter',
    'Dart',
    'React',
    'Node.js',
    'Python',
    'JavaScript',
    'TypeScript',
    'MongoDB',
    'PostgreSQL',
    'Firebase',
    'AWS',
    'Docker',
  ];

  static const List<String> softSkills = [
    'Leadership',
    'Communication',
    'Problem Solving',
    'Team Collaboration',
    'Time Management',
    'Critical Thinking',
    'Adaptability',
    'Creativity',
  ];

  // File Types
  static const List<String> allowedImageTypes = [
    'jpg',
    'jpeg',
    'png',
    'webp',
  ];

  static const List<String> allowedDocumentTypes = [
    'pdf',
    'doc',
    'docx',
  ];

  // Error Messages
  static const String genericErrorMessage = 'Something went wrong. Please try again.';
  static const String networkErrorMessage = 'Please check your internet connection.';
  static const String timeoutErrorMessage = 'Request timed out. Please try again.';
  static const String fileNotFoundErrorMessage = 'File not found.';
  static const String permissionErrorMessage = 'Permission denied.';

  // Success Messages
  static const String profileUpdatedMessage = 'Profile updated successfully!';
  static const String messageSentMessage = 'Message sent successfully!';
  static const String fileDownloadedMessage = 'File downloaded successfully!';

  // Loading Messages
  static const String loadingMessage = 'Loading...';
  static const String processingMessage = 'Processing...';
  static const String uploadingMessage = 'Uploading...';
  static const String downloadingMessage = 'Downloading...';

  /// Prevent instantiation
  AppConstants._();
} 