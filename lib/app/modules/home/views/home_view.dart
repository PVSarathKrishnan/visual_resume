import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/resume_data.dart';

/// Home View - Professional Visual Resume Landing Page
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late AnimationController _heroController;
  late AnimationController _navController;
  late AnimationController _statsController;
  
  late Animation<double> _heroFadeIn;
  late Animation<Offset> _heroSlideIn;
  late Animation<double> _navFadeIn;
  late Animation<double> _statsAnimation;
  
  bool _showFloatingNav = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _scrollController.addListener(_onScroll);
  }

  void _initAnimations() {
    _heroController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _navController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _statsController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _heroFadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _heroController, curve: const Interval(0.0, 0.6, curve: Curves.easeOut)),
    );
    
    _heroSlideIn = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(parent: _heroController, curve: const Interval(0.2, 0.8, curve: Curves.elasticOut)),
    );
    
    _navFadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _navController, curve: Curves.easeInOut),
    );
    
    _statsAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _statsController, curve: Curves.elasticOut),
    );

    // Start animations
    _heroController.forward();
    Future.delayed(const Duration(milliseconds: 400), () => _navController.forward());
  }

  void _onScroll() {
    if (_scrollController.offset > 100 && !_showFloatingNav) {
      setState(() => _showFloatingNav = true);
    } else if (_scrollController.offset <= 100 && _showFloatingNav) {
      setState(() => _showFloatingNav = false);
    }
    
    // Trigger stats animation when scrolled into view
    if (_scrollController.offset > 300 && _statsController.status == AnimationStatus.dismissed) {
      _statsController.forward();
    }
  }

  @override
  void dispose() {
    _heroController.dispose();
    _navController.dispose();
    _statsController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ghostWhite,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.ghostWhite,
                  AppColors.ghostWhite.withOpacity(0.8),
                  AppColors.sunshine.withOpacity(0.05),
                ],
              ),
            ),
          ),
          
          // Main content
          CustomScrollView(
            controller: _scrollController,
            slivers: [
          // Hero Section
              SliverToBoxAdapter(child: _buildHeroSection(context)),
              
              // Stats Section
              SliverToBoxAdapter(child: _buildStatsSection(context)),
              
              // About Preview Section
              SliverToBoxAdapter(child: _buildAboutPreview(context)),
              
              // CTA Section
              SliverToBoxAdapter(child: _buildCTASection(context)),
              
              // Footer
              SliverToBoxAdapter(child: _buildFooter(context)),
            ],
          ),
          
          // Floating Navigation
          _buildFloatingNavigation(context),
        ],
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 64,
        vertical: 40,
      ),
      child: AnimatedBuilder(
        animation: _heroController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _heroFadeIn,
            child: SlideTransition(
              position: _heroSlideIn,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  // Profile Image with Glassmorphism
                  _buildProfileSection(context, isMobile),
                  
                  SizedBox(height: isMobile ? 40 : 60),
                  
                  // Name and Title
                  _buildNameSection(context, isMobile),
                  
                  SizedBox(height: isMobile ? 24 : 32),
                  
                  // Summary
                  _buildSummarySection(context, isMobile),
                  
                  SizedBox(height: isMobile ? 40 : 60),
                  
                  // Action Buttons
                  _buildActionButtons(context, isMobile),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context, bool isMobile) {
    return Container(
      width: isMobile ? 140 : 180,
      height: isMobile ? 140 : 180,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            AppColors.sunshine.withOpacity(0.3),
            AppColors.night.withOpacity(0.1),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.night.withOpacity(0.1),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
        child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.night,
          border: Border.all(
            color: AppColors.sunshine.withOpacity(0.3),
            width: 2,
          ),
        ),
                child: Icon(
                  Icons.person,
                  size: isMobile ? 60 : 80,
          color: AppColors.ghostWhite,
        ),
      ),
    );
  }

  Widget _buildNameSection(BuildContext context, bool isMobile) {
    return Column(
      children: [
              Text(
          ResumeData.fullName,
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            fontSize: isMobile ? 32 : 48,
            fontWeight: FontWeight.w800,
            color: AppColors.night,
            letterSpacing: -1,
                ),
                textAlign: TextAlign.center,
              ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.sunshine.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.sunshine.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Text(
            ResumeData.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: isMobile ? 16 : 20,
              fontWeight: FontWeight.w600,
              color: AppColors.night,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummarySection(BuildContext context, bool isMobile) {
    return Container(
      constraints: BoxConstraints(maxWidth: isMobile ? 320 : 600),
      child: Text(
        ResumeData.summary,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontSize: isMobile ? 16 : 18,
          height: 1.6,
          color: AppColors.night.withOpacity(0.8),
                ),
                textAlign: TextAlign.center,
              ),
    );
  }

  Widget _buildActionButtons(BuildContext context, bool isMobile) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxWidth: isMobile ? double.infinity : 600,
      ),
      child: Wrap(
        spacing: isMobile ? 12 : 16,
        runSpacing: isMobile ? 12 : 16,
        alignment: WrapAlignment.center,
                children: [
          _buildPrimaryButton(
            context,
            'View Projects',
            Icons.work_outline,
            () => Navigator.of(context).pushNamed('/projects'),
            isMobile,
          ),
          _buildSecondaryButton(
            context,
            'Contact Me',
            Icons.mail_outline,
            () => Navigator.of(context).pushNamed('/contact'),
            isMobile,
          ),
          _buildIconButton(
            context,
            'Resume',
            Icons.download_outlined,
            () => _downloadResume(),
            isMobile,
          ),
        ],
      ),
    );
  }

  Widget _buildPrimaryButton(BuildContext context, String text, IconData icon, VoidCallback onPressed, bool isMobile) {
    return Container(
      constraints: BoxConstraints(
        minWidth: isMobile ? 120 : 140,
        maxWidth: isMobile ? 150 : 200,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: [AppColors.night, AppColors.night.withOpacity(0.8)],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.night.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: isMobile ? 18 : 20),
        label: Text(
          text,
          style: TextStyle(fontSize: isMobile ? 12 : 14),
          overflow: TextOverflow.ellipsis,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.ghostWhite,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 24, 
            vertical: isMobile ? 12 : 16,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(BuildContext context, String text, IconData icon, VoidCallback onPressed, [bool? isMobile]) {
    final mobile = isMobile ?? Responsive.isMobile(context);
    return Container(
      constraints: BoxConstraints(
        minWidth: mobile ? 120 : 140,
        maxWidth: mobile ? 150 : 200,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.night.withOpacity(0.2)),
        color: AppColors.ghostWhite.withOpacity(0.8),
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: mobile ? 18 : 20),
        label: Text(
          text,
          style: TextStyle(fontSize: mobile ? 12 : 14),
          overflow: TextOverflow.ellipsis,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.night,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(
            horizontal: mobile ? 16 : 24, 
            vertical: mobile ? 12 : 16,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
    );
  }

  Widget _buildIconButton(BuildContext context, String text, IconData icon, VoidCallback onPressed, bool isMobile) {
    return Container(
          constraints: BoxConstraints(
        minWidth: isMobile ? 100 : 120,
        maxWidth: isMobile ? 130 : 160,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColors.sunshine.withOpacity(0.1),
        border: Border.all(color: AppColors.sunshine.withOpacity(0.3)),
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: isMobile ? 18 : 20),
        label: Text(
          text,
          style: TextStyle(fontSize: isMobile ? 12 : 14),
          overflow: TextOverflow.ellipsis,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.night,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 24, 
            vertical: isMobile ? 12 : 16,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 64,
        vertical: isMobile ? 60 : 100,
      ),
      child: AnimatedBuilder(
        animation: _statsAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: 0.8 + (_statsAnimation.value * 0.2),
            child: Opacity(
              opacity: _statsAnimation.value,
              child: _buildStatsGrid(context, isMobile),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context, bool isMobile) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = Responsive.isTablet(context);
        final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);
        final childAspectRatio = isMobile ? 3.5 : (isTablet ? 2.5 : 1.2);
        
                  return GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: isMobile ? 16 : 24,
          mainAxisSpacing: isMobile ? 16 : 24,
          childAspectRatio: childAspectRatio,
                    children: [
            _buildStatCard(
                        context,
              '${ResumeData.experiences.length}',
              'Years Experience',
              Icons.work_outline,
              AppColors.sunshine,
            ),
            _buildStatCard(
                        context,
              '${ResumeData.projects.length}',
              'Projects Completed',
                        Icons.code,
              AppColors.night,
                      ),
            _buildStatCard(
                        context,
              '${ResumeData.skills.length}+',
                        'Technologies',
                        Icons.settings,
              AppColors.sunshine,
                      ),
                    ],
                  );
                },
    );
  }

  Widget _buildStatCard(BuildContext context, String number, String label, IconData icon, Color accentColor) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.ghostWhite,
        border: Border.all(color: accentColor.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: accentColor,
            ),
            const SizedBox(height: 16),
            Text(
              number,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.night,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.night.withOpacity(0.7),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutPreview(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 64,
        vertical: isMobile ? 60 : 100,
      ),
      child: Column(
        children: [
          Text(
            'About Me',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.night,
            ),
          ),
          const SizedBox(height: 40),
          Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Text(
              ResumeData.summary,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 18,
                height: 1.8,
                color: AppColors.night.withOpacity(0.8),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 40),
          _buildSecondaryButton(
            context,
            'Learn More',
            Icons.arrow_forward,
            () => Navigator.of(context).pushNamed('/about'),
          ),
        ],
      ),
    );
  }

  Widget _buildCTASection(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 64),
      padding: EdgeInsets.all(isMobile ? 40 : 60),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: [
            AppColors.night,
            AppColors.night.withOpacity(0.9),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.night.withOpacity(0.3),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Ready to Work Together?',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: AppColors.ghostWhite,
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Let\'s create something amazing together',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.ghostWhite.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: AppColors.sunshine,
              boxShadow: [
                BoxShadow(
                  color: AppColors.sunshine.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pushNamed('/contact'),
              icon: const Icon(Icons.mail_outline, size: 20),
              label: const Text('Get In Touch'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: AppColors.night,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Text(
        '© 2024 ${ResumeData.fullName}. Crafted with Flutter',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: AppColors.night.withOpacity(0.5),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildFloatingNavigation(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      top: _showFloatingNav ? 40 : -100,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 24),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 12 : 20, 
            vertical: isMobile ? 8 : 12,
          ),
          decoration: BoxDecoration(
            color: AppColors.ghostWhite.withOpacity(0.95),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: AppColors.night.withOpacity(0.1)),
            boxShadow: [
              BoxShadow(
                color: AppColors.night.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: isMobile 
              ? _buildMobileNav(context)
              : _buildDesktopNav(context),
        ),
      ),
    );
  }

  Widget _buildMobileNav(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildNavItem(context, 'About', '/about'),
          _buildNavItem(context, 'Experience', '/experience'),
          _buildNavItem(context, 'Projects', '/projects'),
          _buildNavItem(context, 'Skills', '/skills'),
          _buildNavItem(context, 'Contact', '/contact'),
        ],
      ),
    );
  }

  Widget _buildDesktopNav(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildNavItem(context, 'About', '/about'),
        _buildNavItem(context, 'Experience', '/experience'),
        _buildNavItem(context, 'Projects', '/projects'),
        _buildNavItem(context, 'Skills', '/skills'),
        _buildNavItem(context, 'Contact', '/contact'),
      ],
    );
  }

  Widget _buildNavItem(BuildContext context, String title, String route) {
    final isMobile = Responsive.isMobile(context);
    
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(route),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 12 : 16, 
          vertical: isMobile ? 6 : 8,
        ),
        margin: EdgeInsets.symmetric(horizontal: isMobile ? 2 : 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.transparent,
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.night,
            fontSize: isMobile ? 12 : 14,
          ),
        ),
      ),
    );
  }

  void _downloadResume() {
    HapticFeedback.lightImpact();
    // TODO: Implement resume download
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Resume download will be implemented'),
        backgroundColor: AppColors.night,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
} 