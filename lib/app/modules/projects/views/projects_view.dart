import 'package:flutter/material.dart';
import '../../../../core/constants/resume_data.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';

class ProjectsView extends StatefulWidget {
  const ProjectsView({super.key});

  @override
  State<ProjectsView> createState() => _ProjectsViewState();
}

class _ProjectsViewState extends State<ProjectsView> with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<AnimationController> _cardControllers;
  late List<Animation<double>> _cardAnimations;
  late List<Animation<Offset>> _slideAnimations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _cardControllers = List.generate(
      ResumeData.projects.length,
      (index) => AnimationController(
        duration: Duration(milliseconds: 600 + (index * 150)),
        vsync: this,
      ),
    );

    _cardAnimations = _cardControllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.elasticOut),
      );
    }).toList();

    _slideAnimations = _cardControllers.map((controller) {
      return Tween<Offset>(
        begin: const Offset(0, 0.3),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    }).toList();

    _controller.forward();
    _startCardAnimations();
  }

  void _startCardAnimations() {
    for (int i = 0; i < _cardControllers.length; i++) {
      Future.delayed(Duration(milliseconds: 200 + (i * 150)), () {
        if (mounted) _cardControllers[i].forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    for (var controller in _cardControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Scaffold(
      backgroundColor: AppColors.ghostWhite,
      appBar: _buildAppBar(context),
      body: FadeTransition(
        opacity: _controller,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : 64,
            vertical: 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, isMobile),
              const SizedBox(height: 60),
              _buildProjectsGrid(context, isMobile),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.ghostWhite.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.night.withOpacity(0.1)),
        ),
        child: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: AppColors.night),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      title: Text(
        'Projects',
        style: TextStyle(
          color: AppColors.night,
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildHeader(BuildContext context, bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 32 : 48),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
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
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.sunshine.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              Icons.code,
              size: isMobile ? 40 : 50,
              color: AppColors.sunshine,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Featured Projects',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.ghostWhite,
              fontSize: isMobile ? 28 : 36,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'A showcase of my technical skills and creativity',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.ghostWhite.withOpacity(0.8),
              fontSize: isMobile ? 16 : 18,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsGrid(BuildContext context, bool isMobile) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = Responsive.isTablet(context);
        final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : (constraints.maxWidth > 1200 ? 3 : 2));
        final aspectRatio = isMobile ? 0.85 : (isTablet ? 0.95 : 0.9);
        
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: isMobile ? 16 : 24,
            mainAxisSpacing: isMobile ? 16 : 24,
            childAspectRatio: aspectRatio,
          ),
          itemCount: ResumeData.projects.length,
          itemBuilder: (context, index) {
            return AnimatedBuilder(
              animation: _cardAnimations[index],
              builder: (context, child) {
                return FadeTransition(
                  opacity: _cardAnimations[index],
                  child: SlideTransition(
                    position: _slideAnimations[index],
                    child: Transform.scale(
                      scale: 0.8 + (_cardAnimations[index].value * 0.2),
                      child: _buildProjectCard(
                        context,
                        ResumeData.projects[index],
                        index,
                        isMobile,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildProjectCard(BuildContext context, Project project, int index, bool isMobile) {
    final colors = [
      AppColors.sunshine,
      AppColors.night,
      AppColors.sunshine.withOpacity(0.8),
      AppColors.night.withOpacity(0.8),
    ];
    final accentColor = colors[index % colors.length];
    
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.ghostWhite,
        border: Border.all(color: accentColor.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project header with icon and year
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    accentColor.withOpacity(0.1),
                    accentColor.withOpacity(0.05),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: accentColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          _getProjectIcon(project.name),
                          color: accentColor,
                          size: 24,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.night.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          project.year,
                          style: TextStyle(
                            color: AppColors.night,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    project.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.night,
                      fontSize: isMobile ? 18 : 20,
                    ),
                  ),
                ],
              ),
            ),
            
            // Project description
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        project.description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.night.withOpacity(0.8),
                          height: 1.5,
                        ),
                      ),
                    ),
                    
                    if (project.links != null && project.links!.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: project.links!.entries.map((entry) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: _buildLinkButton(context, entry.key, entry.value, accentColor),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLinkButton(BuildContext context, String label, String? url, Color accentColor) {
    final isAvailable = url != null;
    
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isAvailable ? accentColor.withOpacity(0.3) : AppColors.night.withOpacity(0.2),
        ),
        color: isAvailable ? accentColor.withOpacity(0.1) : AppColors.night.withOpacity(0.05),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: isAvailable ? () {
          // TODO: Launch URL
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Would open $label'),
              backgroundColor: AppColors.night,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          );
        } : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _getLinkIcon(label),
                size: 16,
                color: isAvailable ? accentColor : AppColors.night.withOpacity(0.5),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: isAvailable ? accentColor : AppColors.night.withOpacity(0.5),
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
              if (!isAvailable) ...[
                const SizedBox(width: 4),
                Text(
                  '(Soon)',
                  style: TextStyle(
                    color: AppColors.night.withOpacity(0.4),
                    fontSize: 10,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  IconData _getProjectIcon(String projectName) {
    switch (projectName.toLowerCase()) {
      case 'piggyback sports':
        return Icons.sports_basketball;
      case 'leadsden':
        return Icons.real_estate_agent;
      case 'my property journey':
        return Icons.home_work;
      case 'budget bee':
        return Icons.account_balance_wallet;
      case 'knack':
        return Icons.school;
      default:
        return Icons.code;
    }
  }

  IconData _getLinkIcon(String linkType) {
    switch (linkType.toLowerCase()) {
      case 'play store':
        return Icons.android;
      case 'app store':
        return Icons.phone_iphone;
      case 'github':
        return Icons.code;
      case 'web':
      case 'website':
        return Icons.language;
      default:
        return Icons.link;
    }
  }
} 