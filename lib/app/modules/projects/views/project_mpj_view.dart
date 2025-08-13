import 'package:flutter/material.dart';
import 'dart:ui';
import '../../../../core/constants/app_colors.dart';

class ProjectMpjView extends StatelessWidget {
  const ProjectMpjView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.ghostWhite,
              Color(0xFFFFFEFA),
              Color(0xFFFFFAEA),
              AppColors.ghostWhite,
            ],
            stops: [0.0, 0.3, 0.7, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios, color: AppColors.night),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'My Property Journey',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: AppColors.night,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '2024 • Real-estate support app',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.night.withOpacity(0.7),
                        ),
                  ),
                  const SizedBox(height: 24),
                  _buildGlassCard(
                    context,
                    child: Text(
                      'Support app for Leadsden used by real-estate agents for daily operations. Built with Flutter and GetX. This screen can be extended with screenshots, roles, responsibilities, and feature highlights.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColors.night.withOpacity(0.85),
                            height: 1.5,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassCard(BuildContext context, {required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: AppColors.sunshine.withOpacity(0.15),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}


