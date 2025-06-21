import 'package:flutter/material.dart';
import '../../../../core/constants/resume_data.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';

class SkillsView extends StatefulWidget {
  const SkillsView({super.key});

  @override
  State<SkillsView> createState() => _SkillsViewState();
}

class _SkillsViewState extends State<SkillsView> with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<AnimationController> _skillControllers;
  late List<Animation<double>> _skillAnimations;

  final Map<String, List<String>> _skillCategories = {
    'Frontend': ['Flutter', 'Dart'],
    'Backend': ['GraphQL', 'Firebase'],
    'Database': ['Hive', 'Firebase'],
    'State Management': ['Provider', 'GetX', 'Bloc'],
    'Tools & Others': ['Git', 'Figma'],
  };

  final Map<String, double> _skillProficiency = {
    'Flutter': 0.9,
    'Dart': 0.9,
    'GraphQL': 0.8,
    'Firebase': 0.85,
    'Hive': 0.75,
    'Provider': 0.8,
    'GetX': 0.85,
    'Bloc': 0.7,
    'Git': 0.8,
    'Figma': 0.7,
  };

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _skillControllers = List.generate(
      ResumeData.skills.length,
      (index) => AnimationController(
        duration: Duration(milliseconds: 800 + (index * 100)),
        vsync: this,
      ),
    );

    _skillAnimations = _skillControllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.elasticOut),
      );
    }).toList();

    _controller.forward();
    _startSkillAnimations();
  }

  void _startSkillAnimations() {
    for (int i = 0; i < _skillControllers.length; i++) {
      Future.delayed(Duration(milliseconds: 300 + (i * 100)), () {
        if (mounted) _skillControllers[i].forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    for (var controller in _skillControllers) {
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
              _buildSkillCategories(context, isMobile),
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
        'Skills',
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
            AppColors.sunshine.withOpacity(0.1),
            AppColors.sunshine.withOpacity(0.05),
          ],
        ),
        border: Border.all(color: AppColors.sunshine.withOpacity(0.2)),
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
              Icons.star_outline,
              size: isMobile ? 40 : 50,
              color: AppColors.sunshine,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Technical Skills',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.night,
              fontSize: isMobile ? 28 : 36,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Technologies and tools I work with',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.night.withOpacity(0.7),
              fontSize: isMobile ? 16 : 18,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCategories(BuildContext context, bool isMobile) {
    return Column(
      children: _skillCategories.entries.map((category) {
        return Container(
          margin: const EdgeInsets.only(bottom: 32),
          child: _buildSkillCategory(context, category.key, category.value, isMobile),
        );
      }).toList(),
    );
  }

  Widget _buildSkillCategory(BuildContext context, String categoryName, List<String> skills, bool isMobile) {
    final categoryColors = {
      'Frontend': AppColors.sunshine,
      'Backend': AppColors.night,
      'Database': AppColors.sunshine.withOpacity(0.8),
      'State Management': AppColors.night.withOpacity(0.8),
      'Tools & Others': AppColors.sunshine.withOpacity(0.6),
    };
    
    final accentColor = categoryColors[categoryName] ?? AppColors.night;
    final isTablet = Responsive.isTablet(context);

    return Container(
      padding: EdgeInsets.all(isMobile ? 20 : 24),
      decoration: BoxDecoration(
        color: AppColors.ghostWhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accentColor.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(isMobile ? 10 : 12),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getCategoryIcon(categoryName),
                  color: accentColor,
                  size: isMobile ? 20 : 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  categoryName,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.night,
                    fontSize: isMobile ? 18 : (isTablet ? 20 : 22),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...skills.map((skill) => _buildSkillItem(context, skill, accentColor, isMobile)),
        ],
      ),
    );
  }

  Widget _buildSkillItem(BuildContext context, String skill, Color accentColor, bool isMobile) {
    final proficiency = _skillProficiency[skill] ?? 0.7;
    final skillIndex = ResumeData.skills.indexOf(skill);
    
    if (skillIndex == -1) return const SizedBox.shrink();

    return AnimatedBuilder(
      animation: _skillAnimations[skillIndex],
      builder: (context, child) {
        return Opacity(
          opacity: _skillAnimations[skillIndex].value,
          child: Container(
            margin: EdgeInsets.only(bottom: isMobile ? 12 : 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        skill,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.night,
                          fontSize: isMobile ? 14 : 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${(proficiency * 100).round()}%',
                      style: TextStyle(
                        color: accentColor,
                        fontWeight: FontWeight.w700,
                        fontSize: isMobile ? 12 : 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  height: isMobile ? 6 : 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: AppColors.night.withOpacity(0.1),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: proficiency * _skillAnimations[skillIndex].value,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        gradient: LinearGradient(
                          colors: [
                            accentColor,
                            accentColor.withOpacity(0.8),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Frontend':
        return Icons.web;
      case 'Backend':
        return Icons.dns;
      case 'Database':
        return Icons.storage;
      case 'State Management':
        return Icons.settings_applications;
      case 'Tools & Others':
        return Icons.build;
      default:
        return Icons.code;
    }
  }
} 