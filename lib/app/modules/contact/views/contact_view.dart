import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/resume_data.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';

class ContactView extends StatefulWidget {
  const ContactView({super.key});

  @override
  State<ContactView> createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<AnimationController> _cardControllers;
  late List<Animation<double>> _cardAnimations;
  late List<Animation<Offset>> _slideAnimations;

  final List<ContactMethod> _contactMethods = [
    ContactMethod(
      title: 'Email',
      value: ResumeData.email,
      icon: Icons.email_outlined,
      color: AppColors.sunshine,
      action: 'Send Email',
    ),
    ContactMethod(
      title: 'Phone',
      value: ResumeData.phone,
      icon: Icons.phone_outlined,
      color: AppColors.night,
      action: 'Call Now',
    ),
    ContactMethod(
      title: 'Location',
      value: ResumeData.location,
      icon: Icons.location_on_outlined,
      color: AppColors.sunshine.withOpacity(0.8),
      action: 'View Map',
    ),
    ContactMethod(
      title: 'LinkedIn',
      value: ResumeData.linkedIn,
      icon: Icons.business_center_outlined,
      color: AppColors.night.withOpacity(0.8),
      action: 'Connect',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _cardControllers = List.generate(
      _contactMethods.length,
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
              _buildContactMethods(context, isMobile),
              const SizedBox(height: 60),
              _buildCTASection(context, isMobile),
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
        'Contact',
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
              Icons.connect_without_contact,
              size: isMobile ? 40 : 50,
              color: AppColors.sunshine,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Let\'s Connect',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.ghostWhite,
              fontSize: isMobile ? 28 : 36,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Ready to discuss your next project? I\'d love to hear from you.',
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

  Widget _buildContactMethods(BuildContext context, bool isMobile) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = Responsive.isTablet(context);
        final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 2);
        final aspectRatio = isMobile ? 2.2 : (isTablet ? 1.8 : 2.0);
        
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: isMobile ? 16 : 24,
            mainAxisSpacing: isMobile ? 16 : 24,
            childAspectRatio: aspectRatio,
          ),
          itemCount: _contactMethods.length,
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
                      child: _buildContactCard(
                        context,
                        _contactMethods[index],
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

  Widget _buildContactCard(BuildContext context, ContactMethod method, bool isMobile) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.ghostWhite,
        border: Border.all(color: method.color.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: method.color.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => _handleContactAction(method),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: method.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      method.icon,
                      color: method.color,
                      size: 24,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: method.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: method.color.withOpacity(0.3)),
                    ),
                    child: Text(
                      method.action,
                      style: TextStyle(
                        color: method.color,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                method.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.night,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Text(
                  method.value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.night.withOpacity(0.8),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCTASection(BuildContext context, bool isMobile) {
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
          Text(
            'Prefer Email?',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.night,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Drop me a line and I\'ll get back to you as soon as possible.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.night.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Container(
                  width: isMobile ? double.infinity : null,
                  constraints: BoxConstraints(
                    maxWidth: isMobile ? double.infinity : 200,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
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
                    onPressed: () => _copyEmail(),
                    icon: const Icon(Icons.copy, size: 20),
                    label: const Text('Copy Email'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: AppColors.ghostWhite,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    ),
                  ),
                ),
              ),
              if (!isMobile) ...[
                const SizedBox(width: 16),
                Flexible(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 200),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: AppColors.night.withOpacity(0.2)),
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () => _openEmailApp(),
                      icon: const Icon(Icons.mail_outline, size: 20),
                      label: const Text('Open Email App'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: AppColors.night,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  void _handleContactAction(ContactMethod method) {
    HapticFeedback.lightImpact();
    
    switch (method.title.toLowerCase()) {
      case 'email':
        _openEmailApp();
        break;
      case 'phone':
        _makePhoneCall();
        break;
      case 'location':
        _openMap();
        break;
      case 'linkedin':
        _openLinkedIn();
        break;
    }
  }

  void _copyEmail() {
    Clipboard.setData(ClipboardData(text: ResumeData.email));
    _showSnackBar('Email copied to clipboard!');
  }

  void _openEmailApp() {
    // TODO: Implement email app opening
    _showSnackBar('Would open email app');
  }

  void _makePhoneCall() {
    // TODO: Implement phone call
    _showSnackBar('Would initiate phone call');
  }

  void _openMap() {
    // TODO: Implement map opening
    _showSnackBar('Would open map location');
  }

  void _openLinkedIn() {
    // TODO: Implement LinkedIn opening
    _showSnackBar('Would open LinkedIn profile');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.night,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

class ContactMethod {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String action;

  ContactMethod({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.action,
  });
} 