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

  // New white-background square logos
  static const String budgetWhiteLogo = 'assets/logo/budget_white.png';
  static const String finWhiteLogo = 'assets/logo/fin_white.png';
  static const String knackWhiteLogo = 'assets/logo/knack_white.png';
  static const String leadsWhiteLogo = 'assets/logo/leads_white.png';
  static const String mpjWhiteLogo = 'assets/logo/mpj_white.png';
  static const String piggyWhiteLogo = 'assets/logo/piggy_white.png';
  static const String tanqWhiteLogo = 'assets/logo/tanq_white.png';

  // Icons
  static const String appIcon = 'assets/icons/app_icon.png';
  static const String launcherIcon = 'assets/icons/launcher_icon.png';

  // Images
  static const String profilePlaceholder = 'assets/images/profile_placeholder.png';
  static const String profileAvatar = 'assets/images/sarath_pfp.png';

  // Documents
  static const String resumePdf = 'assets/documents/Sarath_krishnan_pv.pdf';

  // Project logo mapping
  static const Map<String, String> projectLogos = {
    'Piggyback Sports': piggyWhiteLogo,
    'Leadsden': leadsWhiteLogo,
    'My Property Journey': mpjWhiteLogo,
    'Budget Bee': budgetWhiteLogo,
    'Knack': knackWhiteLogo,
    'Tanq Driver': tanqWhiteLogo,
    'Tanq Rider': tanqWhiteLogo,
    'Fintalkr': finWhiteLogo,
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