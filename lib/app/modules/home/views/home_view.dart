import 'package:flutter/material.dart';
import 'dart:ui';
import '../../../../core/utils/responsive.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/resume_data.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/routes/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';  // Import for URL launching

/// Home View - Stunning Visual Resume
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late AnimationController _heroAnimationController;
  late AnimationController _floatingAnimationController;
  late Animation<double> _heroAnimation;
  late Animation<double> _floatingAnimation;

  @override
  void initState() {
    super.initState();
    _heroAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _floatingAnimationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _heroAnimation = CurvedAnimation(
      parent: _heroAnimationController,
      curve: Curves.easeOutCubic,
    );
    _floatingAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _floatingAnimationController,
      curve: Curves.easeInOut,
    ));

    _heroAnimationController.forward();
    _floatingAnimationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _heroAnimationController.dispose();
    _floatingAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: _buildGradientBackground(),
        child: ResponsiveLayout(
          mobile: _buildMobileLayout(context),
          tablet: _buildDesktopLayout(context),
          desktop: _buildDesktopLayout(context),
        ),
      ),
    );
  }

  BoxDecoration _buildGradientBackground() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppColors.ghostWhite,
          Color(0xFFFFFDF7),
          Color(0xFFFFF9E6),
          AppColors.ghostWhite,
        ],
        stops: [0.0, 0.3, 0.7, 1.0],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          _buildMobileNavigation(context),
          _buildHeroSection(context, true),
          _buildSkillsSection(context, true),
          _buildProjectsPreview(context, true),
          _buildContactSection(context),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildDesktopNavigation(context),
          _buildHeroSection(context, false),
          _buildSkillsSection(context, false),
          _buildExperienceTimeline(context),
          _buildProjectsShowcase(context),
          _buildContactSection(context),
        ],
      ),
    );
  }

  Widget _buildMobileNavigation(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildLogo(),
          GestureDetector(
            onTap: () => _showMobileMenu(context),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.9),
                    Colors.white.withOpacity(0.7),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.sunshine.withOpacity(0.3)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.sunshine.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.menu,
                color: AppColors.night,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopNavigation(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildLogo(),
          Row(
            children: [
              _buildNavButton('About', () => Navigator.pushNamed(context, '/about')),
              _buildNavButton('Experience', () => Navigator.pushNamed(context, '/experience')),
              _buildNavButton('Projects', () => Navigator.pushNamed(context, '/projects')),
              _buildNavButton('Contact', () => Navigator.pushNamed(context, '/contact')),
              const SizedBox(width: 20),
              _buildGradientButton('Download CV', Icons.download, 
              () async {
                          print('Downloading CV');
                              const url = 'https://drive.google.com/drive/folders/1uD25fNowI78n-DYNqB3zKwvIdfg0f-lI?usp=sharing';
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                // Show an error message if launch fails
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Could not launch URL')),
                                );
                              }
                          
                        },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.sunshine, Color(0xFFFFD700)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.sunshine.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Text(
        'SK',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.night,
        ),
      ),
    );
  }

  Widget _buildNavButton(String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: AppColors.night,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildGradientButton(String text, IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.sunshine, Color(0xFFFFD700)],
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: AppColors.sunshine.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ElevatedButton.icon(
       onPressed: onPressed,
        icon: Icon(icon, color: AppColors.night),
        label: Text(
          text,
          style: const TextStyle(
            color: AppColors.night,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context, bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 50,
        vertical: isMobile ? 40 : 80,
      ),
      child: AnimatedBuilder(
        animation: _heroAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: 0.8 + (_heroAnimation.value * 0.2),
            child: Opacity(
              opacity: _heroAnimation.value,
              child: isMobile
                  ? _buildMobileHeroContent(context)
                  : _buildDesktopHeroContent(context),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMobileHeroContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          _buildProfileAvatar(MediaQuery.of(context).size.width > 600 ? 10 : 100),
          const SizedBox(height: 32),
          _buildHeroText(context, true),
          const SizedBox(height: 32),
          _buildHeroButtons(context, true),
        ],
      ),
    );
  }

  Widget _buildDesktopHeroContent(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeroText(context, false),
              const SizedBox(height: 40),
              _buildHeroButtons(context, false),
            ],
          ),
        ),
        const SizedBox(width: 80),
        Expanded(
          flex: 2,
          child: AnimatedBuilder(
            animation: _floatingAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _floatingAnimation.value * 20),
                child: _buildProfileAvatar(200),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProfileAvatar(double size) {
    return Column(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.sunshine,
                Color(0xFFFFD700),
                AppColors.sunshine,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.sunshine.withOpacity(0.3),
                blurRadius: 25,
                offset: const Offset(0, 12),
              ),
              BoxShadow(
                color: Colors.white.withOpacity(0.8),
                blurRadius: 20,
                offset: const Offset(-10, -10),
              ),
            ],
          ),
          child: Container(
            margin: const EdgeInsets.all(0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.ghostWhite,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Image.asset(
              AppImages.profileAvatar,
              width: size*1.2,
              height: size*1.2,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroText(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppColors.night, Color(0xFF333333)],
          ).createShader(bounds),
          child: Text(
            'Hello, I\'m',
            style: TextStyle(
              fontSize: isMobile ? 18 : 24,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
          ),
        ),
        const SizedBox(height: 8),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppColors.night, AppColors.sunshine, AppColors.night],
          ).createShader(bounds),
          child: Text(
            ResumeData.fullName,
            style: TextStyle(
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.2,
            ),
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.sunshine.withOpacity(0.15),
                AppColors.sunshine.withOpacity(0.08),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.sunshine.withOpacity(0.3),
            ),
          ),
          child: Text(
            ResumeData.title,
            style: TextStyle(
              fontSize: isMobile ? 16 : 20,
              fontWeight: FontWeight.w600,
              color: AppColors.night,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          ResumeData.summary,
          style: TextStyle(
            fontSize: isMobile ? 14 : 18,
            color: AppColors.night.withOpacity(0.7),
            height: 1.6,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildHeroButtons(BuildContext context, bool isMobile) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
      children: [
        _buildGradientButton('View Projects', Icons.rocket_launch, () {
         Navigator.pushNamed(context, '/projects');
        }),
        _buildOutlineButton('Contact Me', Icons.message, () {
          Navigator.pushNamed(context, '/contact');
        }),
      ],
    );
  }

  Widget _buildOutlineButton(String text, IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: AppColors.night.withOpacity(0.3)),
        color: Colors.white.withOpacity(0.8),
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: AppColors.night),
        label: Text(
          text,
          style: const TextStyle(
            color: AppColors.night,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }

  Widget _buildSkillsSection(BuildContext context, bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 50,
        vertical: 60,
      ),
      child: Column(
        children: [
          _buildSectionTitle('Skills & Technologies'),
          const SizedBox(height: 40),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: ResumeData.skills.map((skill) => _buildSkillChip(skill)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [AppColors.night, AppColors.sunshine, AppColors.night],
      ).createShader(bounds),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSkillChip(String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.9),
            Colors.white.withOpacity(0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.sunshine.withOpacity(0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.sunshine.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Text(
        skill,
        style: const TextStyle(
          color: AppColors.night,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildProjectsPreview(BuildContext context, bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 50,
        vertical: 60,
      ),
      child: Column(
        children: [
          _buildSectionTitle('Featured Projects'),
          const SizedBox(height: 40),
          if (isMobile)
            // Mobile: Vertical list of project cards
            Column(
              children: ResumeData.projects.take(3).map((project) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: _buildProjectCard(project),
                );
              }).toList(),
            )
          else
            // Desktop: Grid layout
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 1.2,
              ),
              itemCount: ResumeData.projects.take(4).length,
              itemBuilder: (context, index) {
                final project = ResumeData.projects[index];
                return _buildProjectCard(project);
              },
            ),
          const SizedBox(height: 20),
          _buildGradientButton('View All Projects', Icons.arrow_forward, () {
            Navigator.pushNamed(context, '/projects');
          }),
        ],
      ),
    );
  }

  Widget _buildProjectsShowcase(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 60),
      child: Column(
        children: [
          _buildSectionTitle('Featured Projects'),
          const SizedBox(height: 40),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 30,
              mainAxisSpacing: 30,
              childAspectRatio: 1.0,
            ),
            itemCount: ResumeData.projects.length,
            itemBuilder: (context, index) {
              final project = ResumeData.projects[index];
              return _buildProjectCard(project);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(Project project) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.9),
            Colors.white.withOpacity(0.7),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.sunshine.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 48,
                    height: 48,
                    color: Colors.white,
                    child: AppImages.hasProjectLogo(project.name)
                        ? Image.asset(
                            AppImages.getProjectLogo(project.name),
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.code,
                                color: AppColors.night,
                                size: 24,
                              );
                            },
                          )
                        : const Icon(
                            Icons.code,
                            color: AppColors.night,
                            size: 24,
                          ),
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    final route = AppRoutes.getProjectRouteByName(project.name);
                    if (route != null) {
                      Navigator.pushNamed(context, route);
                    }
                  },
                  child: Text(
                  project.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.night,
                  ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  project.year,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.night.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  project.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.night.withOpacity(0.8),
                    height: 1.4,
                  ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExperienceTimeline(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 60),
      child: Column(
        children: [
          _buildSectionTitle('Experience'),
          const SizedBox(height: 40),
          ...ResumeData.experiences.asMap().entries.map((entry) {
            final index = entry.key;
            final exp = entry.value;
            return _buildTimelineItem(exp, index == ResumeData.experiences.length - 1);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(Experience experience, bool isLast) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [AppColors.sunshine, Color(0xFFFFD700)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.sunshine.withOpacity(0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.sunshine.withOpacity(0.5),
                      AppColors.sunshine.withOpacity(0.1),
                    ],
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 40),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.9),
                  Colors.white.withOpacity(0.7),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.sunshine.withOpacity(0.2),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.sunshine.withOpacity(0.1),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  experience.position,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.night,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${experience.company} • ${experience.period}',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.night.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 12),
                ...experience.responsibilities.map((resp) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        margin: const EdgeInsets.only(top: 6, right: 8),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.sunshine,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          resp,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.night.withOpacity(0.8),
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(60),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            AppColors.sunshine.withOpacity(0.1),
          ],
        ),
      ),
      child: Column(
        children: [
          _buildSectionTitle('Let\'s Connect'),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildContactButton(Icons.email, 'Email', () {}),
              const SizedBox(width: 20),
              _buildContactButton(Icons.phone, 'Call', () {}),
              const SizedBox(width: 20),
              _buildContactButton(Icons.link, 'LinkedIn', () {}),
            ],
          ),
          const SizedBox(height: 40),
          Text(
            '© 2024 ${ResumeData.fullName}. Crafted in Flutter',
            style: TextStyle(
              color: AppColors.night.withOpacity(0.6),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactButton(IconData icon, String label, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.sunshine, Color(0xFFFFD700)],
        ),
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: AppColors.sunshine.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: AppColors.night),
        iconSize: 24,
        padding: const EdgeInsets.all(16),
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withOpacity(0.95),
              Colors.white.withOpacity(0.85),
            ],
          ),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: AppColors.sunshine.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Handle bar
                  Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.sunshine.withOpacity(0.6),
                          AppColors.sunshine.withOpacity(0.4),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  
                  // Menu header
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.sunshine.withOpacity(0.8),
                              AppColors.sunshine.withOpacity(0.6),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.menu,
                          color: AppColors.night,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [
                            AppColors.night,
                            AppColors.sunshine.withOpacity(0.8),
                          ],
                        ).createShader(bounds),
                        child: const Text(
                          'Navigation',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Menu items
                  _buildMobileMenuItem(
                    icon: Icons.person_outline,
                    title: 'About Me',
                    subtitle: 'Learn more about me',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/about');
                    },
                  ),
                  _buildMobileMenuItem(
                    icon: Icons.work_outline,
                    title: 'Experience',
                    subtitle: 'My work journey',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/experience');
                    },
                  ),
                  _buildMobileMenuItem(
                    icon: Icons.code_outlined,
                    title: 'Projects',
                    subtitle: 'Things I\'ve built',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/projects');
                    },
                  ),
                  _buildMobileMenuItem(
                    icon: Icons.build_outlined,
                    title: 'Skills',
                    subtitle: 'Technologies I use',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/skills');
                    },
                  ),
                  _buildMobileMenuItem(
                    icon: Icons.contact_mail_outlined,
                    title: 'Contact',
                    subtitle: 'Get in touch',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/contact');
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Download CV button
                  GestureDetector(
                    onTap: () async {
                      print('Downloading CV');
                      const url = 'https://drive.google.com/drive/folders/1uD25fNowI78n-DYNqB3zKwvIdfg0f-lI?usp=sharing';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        // Show an error message if launch fails
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Could not launch URL')),
                        );
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.sunshine.withOpacity(0.8),
                            AppColors.sunshine.withOpacity(0.6),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.sunshine.withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ElevatedButton.icon(
                        
                         onPressed: () async {
                          print('Downloading CV');
                              const url = 'https://drive.google.com/drive/folders/1uD25fNowI78n-DYNqB3zKwvIdfg0f-lI?usp=sharing';
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                // Show an error message if launch fails
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Could not launch URL')),
                                );
                              }
                          
                        },
                        icon: const Icon(
                          Icons.download_outlined,
                          color: AppColors.night,
                        ),
                        label: const Text(
                          'Download CV',
                          style: TextStyle(
                            color: AppColors.night,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.sunshine.withOpacity(0.2),
        ),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.sunshine.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: AppColors.night,
            size: 22,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.night,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: AppColors.night.withOpacity(0.7),
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: AppColors.night.withOpacity(0.5),
          size: 16,
        ),
      ),
    );
  }
} 