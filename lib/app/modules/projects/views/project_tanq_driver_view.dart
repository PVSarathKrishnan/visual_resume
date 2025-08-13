import 'package:flutter/material.dart';
import 'dart:ui';
import '../../../../core/constants/app_colors.dart';

class ProjectTanqDriverView extends StatelessWidget {
  const ProjectTanqDriverView({super.key});

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
                    'Tanq Driver',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: AppColors.night,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '2023 • Ride-sharing driver app',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.night.withOpacity(0.7),
                        ),
                  ),
                  const SizedBox(height: 24),
                  _buildGlassCard(
                    context,
                    child: Text(
                      'Driver companion app for the Tanq ride-sharing platform. Features real-time ride requests, GPS navigation, earnings tracking, and driver performance analytics. Built with Flutter and GetX.',
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


