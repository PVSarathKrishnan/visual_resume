class AppImages {
  AppImages._();

  // Project Logos
  static const String beeLogo = 'assets/logo/bee.png';
  static const String finLogo = 'assets/logo/fin.png';
  static const String knackLogo = 'assets/logo/KNACK.png';
  static const String leadsLogo = 'assets/logo/leads.png';
  static const String mpjLogo = 'assets/logo/mpj.png';
  static const String piggyLogo = 'assets/logo/piggy.png';
  static const String tanqLogo = 'assets/logo/tanq_png.png';

  // Icons
  static const String appIcon = 'assets/icons/app_icon.png';
  static const String launcherIcon = 'assets/icons/launcher_icon.png';

  // Images
  static const String profilePlaceholder = 'assets/images/profile_placeholder.png';
  static const String profileAvatar = 'assets/images/profile_avatar.png';

  // Documents
  static const String resumePdf = 'assets/documents/Sarath_krishnan_pv.pdf';

  // Project logo mapping
  static const Map<String, String> projectLogos = {
    'Piggyback Sports': piggyLogo,
    'Leadsden': leadsLogo,
    'My Property Journey': mpjLogo,
    'Budget Bee': beeLogo,
    'Knack': knackLogo,
    'Tanq Driver': tanqLogo,
    'Tanq Rider': tanqLogo,
    'Fintalkr': finLogo,
  };

  // Get project logo by name
  static String getProjectLogo(String projectName) {
    return projectLogos[projectName] ?? beeLogo;
  }

  // Check if project has logo
  static bool hasProjectLogo(String projectName) {
    return projectLogos.containsKey(projectName);
  }
} 