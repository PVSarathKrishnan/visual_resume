# Visual Resume - Professional Portfolio Website

A responsive Flutter web application for showcasing your professional resume and portfolio. Built with clean architecture principles, GetX state management, and modern UI/UX design.

## 🚀 Features

- **Responsive Design**: Optimized for desktop, tablet, and mobile devices
- **Clean Architecture**: Well-organized code structure following best practices
- **Modern UI**: Beautiful and professional design with smooth animations
- **Fast Performance**: Optimized for web with excellent loading times
- **SEO Friendly**: Proper meta tags and structure for search engines
- **Dark/Light Theme**: Automatic theme switching based on system preferences

## 🏗️ Architecture

This project follows **Clean Architecture** principles with a modular structure:

```
lib/
├── core/                          # Core functionality
│   ├── bindings/                  # Dependency injection
│   ├── constants/                 # App constants
│   ├── routes/                    # Navigation management
│   ├── services/                  # Custom services (Navigation, Snackbar)
│   ├── theme/                     # Theme configuration
│   └── utils/                     # Utility classes (Responsive)
├── app/
│   └── modules/                   # Feature modules
│       ├── splash/                # Splash screen
│       ├── home/                  # Home page
│       ├── about/                 # About section
│       ├── experience/            # Work experience
│       ├── projects/              # Portfolio projects
│       ├── skills/                # Skills showcase
│       └── contact/               # Contact information
└── main.dart                      # App entry point
```

### Module Structure
Each module follows this structure:
```
module_name/
├── bindings/          # GetX bindings for dependency injection
├── controllers/       # GetX controllers for state management
├── views/            # UI components
└── widgets/          # Reusable widgets (if needed)
```

## 🛠️ Technology Stack

- **Framework**: Flutter 3.7.2+
- **State Management**: GetX 4.6.6
- **Fonts**: Google Fonts
- **Icons**: Material Icons + Custom SVG icons
- **Animations**: Lottie animations
- **Architecture**: Clean Architecture with MVVM pattern

## 📱 Responsive Design

The app uses a custom responsive utility class that handles:
- **Mobile**: < 600px width
- **Tablet**: 600px - 1024px width  
- **Desktop**: > 1024px width

### Responsive Features:
- Adaptive layouts for different screen sizes
- Responsive typography and spacing
- Flexible grid systems
- Touch-friendly mobile interactions
- Optimized desktop navigation

## 🎨 Design System

### Color Scheme
- **Primary**: Blue (#2196F3)
- **Secondary**: Teal (#03DAC6)
- **Accent**: Orange (#FF5722)

### Typography
- **Headings**: Poppins font family
- **Body Text**: Roboto font family
- **Responsive font sizes** based on device type

### Spacing & Layout
- Consistent spacing system (4px base unit)
- Responsive padding and margins
- Maximum content width constraints
- Proper visual hierarchy

## 🚦 Getting Started

### Prerequisites
- Flutter SDK 3.7.2 or higher
- Dart SDK 2.19.0 or higher
- Web browser for testing

### Installation

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd visual_resume
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run -d chrome
   ```

### Building for Production

```bash
# Build for web
flutter build web --release

# The built files will be in build/web/
```

## 📝 Customization

### Personal Information
Update your personal details in:
- `lib/core/constants/app_constants.dart`

### Content
Add your content to the respective module views:
- **About**: `lib/app/modules/about/views/about_view.dart`
- **Experience**: `lib/app/modules/experience/views/experience_view.dart`
- **Projects**: `lib/app/modules/projects/views/projects_view.dart`
- **Skills**: `lib/app/modules/skills/views/skills_view.dart`
- **Contact**: `lib/app/modules/contact/views/contact_view.dart`

### Assets
Place your assets in the appropriate folders:
- **Images**: `assets/images/`
- **Icons**: `assets/icons/`
- **Animations**: `assets/animations/`
- **Documents**: `assets/documents/`

### Theme Customization
Modify colors and styling in:
- `lib/core/theme/app_theme.dart`

## 🔧 Services

### Navigation Service
Custom navigation service that doesn't depend on GetX for routing:
```dart
NavigationService.instance.navigateTo('/about');
NavigationService.instance.goBack();
```

### Snackbar Service
Custom snackbar service for notifications:
```dart
SnackbarService.instance.showSuccess(message: 'Success!');
SnackbarService.instance.showError(message: 'Error occurred');
```

### Responsive Utility
Responsive helper for adaptive layouts:
```dart
Responsive.isMobile(context)
Responsive.valueWhen(context: context, mobile: 16.0, desktop: 24.0)
Responsive.responsivePadding(context)
```

## 📦 Dependencies

### Main Dependencies
- `get: ^4.6.6` - State management and dependency injection
- `google_fonts: ^6.2.1` - Typography
- `flutter_svg: ^2.0.10+1` - SVG support
- `lottie: ^3.1.2` - Animations
- `url_launcher: ^6.2.6` - External links

### Dev Dependencies
- `flutter_lints: ^5.0.0` - Code quality

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- GetX team for the excellent state management solution
- Google Fonts for beautiful typography
- Material Design for design guidelines

---

**Built with ❤️ using Flutter**
