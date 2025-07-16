import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/resume_data.dart';
import '../../../../core/constants/app_colors.dart';

class ContactView extends StatelessWidget {
  const ContactView({super.key});

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
        child: CustomScrollView(
          slivers: [
            _buildSliverAppBar(context),
            SliverPadding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width > 600 ? 32 : 16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildContactSection(context),
                  const SizedBox(height: 40),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      leading: Navigator.canPop(context)
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            )
          : null,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        title: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              AppColors.night,
              AppColors.sunshine.withOpacity(0.8),
            ],
          ).createShader(bounds),
          child: const Text(
            'Contact',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.sunshine.withOpacity(0.08),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactSection(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width <= 600;
    return Container(
      padding: EdgeInsets.all(isMobile ? 20 : 32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.8),
            Colors.white.withOpacity(0.6),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.sunshine.withOpacity(0.15),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.sunshine.withOpacity(0.8),
                          AppColors.sunshine.withOpacity(0.6),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.contact_mail,
                      color: AppColors.night,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [
                        AppColors.night,
                        AppColors.sunshine.withOpacity(0.8),
                      ],
                    ).createShader(bounds),
                    child: const Text(
                      'Get in Touch',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'Feel free to reach out for collaborations, opportunities, or just to say hello!',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.night.withOpacity(0.7),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              _buildContactItem(Icons.email, 'Email', ResumeData.email),
              _buildContactItem(Icons.phone, 'Phone', ResumeData.phone),
              _buildContactItem(Icons.location_on, 'Location', ResumeData.location),
              _buildContactItem(Icons.link, 'LinkedIn', ResumeData.linkedIn),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String label, String value) {
    return GestureDetector(
      onTap: () async {
        if (label == 'Email') {
          final url = 'mailto:$value';
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            ScaffoldMessenger.of(Get.context!).showSnackBar(
              const SnackBar(content: Text('Could not launch email')),
            );
          }
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.sunshine.withOpacity(0.2),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.sunshine.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: AppColors.night,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.night.withOpacity(0.6),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.night,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactForm(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width <= 600;
    return Container(
      padding: EdgeInsets.all(isMobile ? 20 : 32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.8),
            Colors.white.withOpacity(0.6),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.sunshine.withOpacity(0.15),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.sunshine.withOpacity(0.8),
                          AppColors.sunshine.withOpacity(0.6),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.message,
                      color: AppColors.night,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [
                        AppColors.night,
                        AppColors.sunshine.withOpacity(0.8),
                      ],
                    ).createShader(bounds),
                    child: const Text(
                      'Send a Message',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildTextField('Name', Icons.person),
              const SizedBox(height: 16),
              _buildTextField('Email', Icons.email),
              const SizedBox(height: 16),
              _buildTextField('Subject', Icons.subject),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.sunshine.withOpacity(0.8),
                        AppColors.sunshine.withOpacity(0.6),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.sunshine.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle form submission
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Send Message',
                      style: TextStyle(
                        color: AppColors.night,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, {int maxLines = 1}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.sunshine.withOpacity(0.2),
        ),
      ),
      child: TextField(
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(
            icon,
            color: AppColors.night.withOpacity(0.7),
          ),
          labelStyle: TextStyle(
            color: AppColors.night.withOpacity(0.7),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
        style: const TextStyle(
          color: AppColors.night,
        ),
      ),
    );
  }
} 