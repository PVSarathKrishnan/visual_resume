import 'package:flutter/material.dart';

/// Data model for resume content
class ResumeData {
  ResumeData._();

  // Personal
  static const String fullName = 'Sarath Krishnan P V';
  static const String title = 'Flutter Developer';
  static const String location = 'Trivandrum, India';
  static const String email = 'pvsarathkrishnan@gmail.com';
  static const String phone = '+91 90745 39022';
  static const String linkedIn = 'www.linkedin.com/in/sarath-krishnan-p-v';

  static const String summary =
      'Flutter Developer with 2 years of experience creating high-quality, responsive mobile applications. Passionate about clean UI/UX design, scalable architecture and maintainable code. Comfortable with GetX, Provider and Bloc for state management, and adept at leveraging AI tools to accelerate development.';

  // Education
  static const education = <Education>[ 
    Education(
      institution: 'SIMAT, Kerala Technical University',
      degree: 'B.Tech in Computer Science',
      period: '2019 – 2023',
      location: 'Vavanoor, Palakkad, Kerala',
      grade: 'CGPA: 7.2',
    ),
  ];

  // Experiences
  static const experiences = <Experience>[
    Experience(
      position: 'Junior Software Engineer',
      company: 'ATeam Soft Solutions',
      location: 'Trivandrum, India',
      period: 'Aug 2024 – Present',
      responsibilities: [
        'Delivered high-quality Flutter apps using clean, maintainable code and modern architectures.',
        'Utilised GraphQL for efficient API integration and improved app performance.',
        'Participated in full software lifecycle — from requirement gathering to deployment.',
        'Contributed to code reviews, team discussions, and agile development practices.',
        'Worked on key projects including PiggyBack, LeadsDen, My Property Journey and Fintalkr.',
      ],
    ),
    Experience(
      position: 'Flutter Developer',
      company: 'Coderspace',
      location: 'Trivandrum, India',
      period: 'Jul 2023 – Jul 2024',
      responsibilities: [
        'Built a strong foundation in Flutter, focusing on mobile app development.',
        'Gained expertise in state management using GetX and Provider.',
        'Applied learned skills to real-time projects such as Tanq Driver and Tanq Rider.',
        'Contributed to app development, UI/UX improvements, and integration of backend services.',
      ],
    ),
  ];

  // Projects
  static const projects = <Project>[
    Project(
      name: 'My Property Journey',
      year: '2024',
      description: 'Support app for Leadsden used by real-estate agents for daily operations. Built with Flutter and GetX.',
      links: {
        'Play Store': null,
      },
    ),
    Project(
      name: 'Leadsden',
      year: '2024',
      description: 'Large-scale CRM application for real-estate data and agent management. Flutter + Bloc with REST APIs, integrates with REX and Agentbox CRMs.',
    ),
    Project(
      name: 'Fintalkr',
      year: '2025',
      description: 'Financial advisory and consultation platform connecting users with certified financial experts. Features secure chat, video calls, portfolio analysis, and investment recommendations. Built with Flutter and Firebase.',
      links: {
        'Play Store': null,
        'App Store': null,
      },
    ),
    Project(
      name: 'Piggyback Sports',
      year: '2024',
      description: 'Sports bet tracking app allowing users to manage real or hypothetical bets, similar to a stock portfolio tracker. Built with Flutter (Provider), GraphQL and Firebase chat.',
      links: {
        'Play Store': null,
        'App Store': null,
      },
    ),
    Project(
      name: 'Tanq Driver',
      year: '2023',
      description: 'Driver companion app for the Tanq ride-sharing platform. Features real-time ride requests, GPS navigation, earnings tracking, and driver performance analytics. Built with Flutter and GetX.',
      links: {
        'Play Store': null,
        'App Store': null,
      },
    ),
    Project(
      name: 'Knack',
      year: '2023',
      description: 'E-learning platform designed with MVVM & DDD, built as responsive Flutter Web app with Firebase sync. Available on Amazon Appstore.',
      links: {
        'Amazon Appstore': 'https://www.amazon.com/dp/B0XXXXXXXX',
      },
    ),
    Project(
      name: 'Budget Bee',
      year: '2022',
      description: 'Cross-platform money management app focused on intuitive personal finance. Released on Play Store.',
      links: {
        'Play Store': 'https://play.google.com/store/apps/details?id=com.budgetbee.app',
      },
    ),
  ];

  // Skills
  static const skills = <String>[
    'Dart',
    'Flutter',
    'GraphQL',
    'Firebase',
    'Hive',
    'Provider',
    'GetX',
    'Bloc',
    'Git',
    'Figma',
  ];
}

class Education {
  final String institution;
  final String degree;
  final String period;
  final String location;
  final String grade;

  const Education({
    required this.institution,
    required this.degree,
    required this.period,
    required this.location,
    required this.grade,
  });
}

class Experience {
  final String position;
  final String company;
  final String location;
  final String period;
  final List<String> responsibilities;

  const Experience({
    required this.position,
    required this.company,
    required this.location,
    required this.period,
    required this.responsibilities,
  });
}

class Project {
  final String name;
  final String year;
  final String description;
  final Map<String, String?>? links;

  const Project({
    required this.name,
    required this.year,
    required this.description,
    this.links,
  });
} 