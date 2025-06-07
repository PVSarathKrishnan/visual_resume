import 'package:flutter/material.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/constants/app_constants.dart';

/// Home View
/// Main landing page of the resume website
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobile: _buildMobileLayout(context),
        tablet: _buildTabletLayout(context),
        desktop: _buildDesktopLayout(context),
      ),
    );
  }

  /// Mobile layout
  Widget _buildMobileLayout(BuildContext context) {
    return _buildMainContent(context, isMobile: true);
  }

  /// Tablet layout
  Widget _buildTabletLayout(BuildContext context) {
    return _buildMainContent(context, isMobile: false);
  }

  /// Desktop layout
  Widget _buildDesktopLayout(BuildContext context) {
    return _buildMainContent(context, isMobile: false);
  }

  /// Main content
  Widget _buildMainContent(BuildContext context, {required bool isMobile}) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Navigation Bar
          _buildNavigationBar(context, isMobile),
          
          // Hero Section
          _buildHeroSection(context, isMobile),
          
          // Quick Info Section
          _buildQuickInfoSection(context, isMobile),
          
          // Footer
          _buildFooter(context),
        ],
      ),
    );
  }

  /// Build navigation bar
  Widget _buildNavigationBar(BuildContext context, bool isMobile) {
    return Container(
      padding: Responsive.responsivePadding(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppConstants.appName,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          if (!isMobile) ...[
            Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('About'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Experience'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Projects'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Contact'),
                ),
              ],
            ),
          ] else ...[
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu),
            ),
          ],
        ],
      ),
    );
  }

  /// Build hero section
  Widget _buildHeroSection(BuildContext context, bool isMobile) {
    return Container(
      padding: Responsive.responsivePadding(context),
      constraints: BoxConstraints(
        minHeight: Responsive.hp(context, 80),
      ),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: Responsive.maxContentWidth(context),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: isMobile ? 60 : 80,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Icon(
                  Icons.person,
                  size: isMobile ? 60 : 80,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: Responsive.spacing(context, factor: 2)),
              Text(
                'John Doe',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Responsive.spacing(context)),
              Text(
                'Full Stack Developer',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Responsive.spacing(context, factor: 2)),
              Text(
                'Passionate developer with expertise in Flutter, React, and Node.js. Creating amazing digital experiences.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
                maxLines: 3,
              ),
              SizedBox(height: Responsive.spacing(context, factor: 3)),
              Wrap(
                spacing: AppConstants.spacingM,
                runSpacing: AppConstants.spacingM,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('View Projects'),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text('Contact Me'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build quick info section
  Widget _buildQuickInfoSection(BuildContext context, bool isMobile) {
    return Container(
      padding: Responsive.responsivePadding(context),
      color: Theme.of(context).colorScheme.surface,
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: Responsive.maxContentWidth(context),
          ),
          child: Column(
            children: [
              Text(
                'Quick Overview',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Responsive.spacing(context, factor: 3)),
              ResponsiveBuilder(
                builder: (context, deviceType) {
                  final columns = deviceType == DeviceType.mobile ? 1 : 3;
                  return GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: columns,
                    crossAxisSpacing: AppConstants.spacingL,
                    mainAxisSpacing: AppConstants.spacingL,
                    childAspectRatio: isMobile ? 3 : 2,
                    children: [
                      _buildInfoCard(
                        context,
                        'Experience',
                        '5+ Years',
                        Icons.work,
                      ),
                      _buildInfoCard(
                        context,
                        'Projects',
                        '20+ Completed',
                        Icons.code,
                      ),
                      _buildInfoCard(
                        context,
                        'Technologies',
                        '15+ Mastered',
                        Icons.settings,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build info card
  Widget _buildInfoCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: AppConstants.iconSizeL,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(height: Responsive.spacing(context)),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: Responsive.spacing(context, factor: 0.5)),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// Build footer
  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: Responsive.responsivePadding(context),
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Center(
        child: Text(
          '© 2024 ${AppConstants.developerName}. All rights reserved.',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
} 