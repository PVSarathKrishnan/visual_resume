# 🚀 Visual Resume Deployment Guide

## Quick Deploy Options

### 1. Firebase Hosting (Recommended)

#### Prerequisites
- Node.js installed
- Firebase CLI: `npm install -g firebase-tools`

#### Steps
```bash
# 1. Login to Firebase
firebase login

# 2. Create/Select Firebase project
firebase init hosting
# - Select "Use an existing project" or create new
# - Choose build/web as public directory
# - Configure as single-page app: Yes
# - Don't overwrite index.html

# 3. Build and Deploy
flutter build web --release
firebase deploy
```

#### Custom Domain
1. Go to Firebase Console > Hosting
2. Click "Add custom domain"
3. Follow DNS configuration steps

---

### 2. Netlify (Drag & Drop)

#### Steps
1. Build: `flutter build web --release`
2. Go to [netlify.com](https://netlify.com)
3. Drag `build/web` folder to deploy area
4. Get instant URL!

#### Auto-Deploy from Git
1. Connect GitHub repository
2. Build command: `flutter build web --release`
3. Publish directory: `build/web`

---

### 3. Vercel (Zero Config)

#### Steps
```bash
# Install Vercel CLI
npm install -g vercel

# Deploy
flutter build web --release
vercel --prod
```

---

### 4. GitHub Pages (Free)

#### Steps
1. Build with base href:
```bash
flutter build web --base-href "/visual_resume/"
```

2. Copy `build/web` contents to `docs` folder
3. Enable GitHub Pages in repo settings
4. Choose `docs` folder as source

---

## 🛠️ Build Optimization

### Performance Tips
```bash
# Optimized build
flutter build web --release --web-renderer canvaskit --dart-define=FLUTTER_WEB_USE_SKIA=true

# For better SEO
flutter build web --release --web-renderer html
```

### Pre-deployment Checklist
- [ ] Test responsive design
- [ ] Check all navigation links
- [ ] Verify contact form functionality
- [ ] Test on different browsers
- [ ] Optimize images and assets
- [ ] Update meta tags for SEO

---

## 🌐 Domain & SEO Setup

### Custom Domain Setup
1. Purchase domain from Namecheap, GoDaddy, etc.
2. Configure DNS records:
   - A record: @ → hosting IP
   - CNAME: www → your-app.web.app

### SEO Optimization
Update `web/index.html`:
```html
<title>Sarath Krishnan P V - Flutter Developer</title>
<meta name="description" content="Flutter Developer with 2 years of experience in mobile app development">
<meta name="keywords" content="Flutter, Developer, Mobile Apps, Dart">
<meta property="og:title" content="Sarath Krishnan P V - Flutter Developer">
<meta property="og:description" content="Professional Flutter Developer Portfolio">
```

---

## 📊 Hosting Comparison

| Platform | Free Tier | Custom Domain | SSL | CDN | Auto Deploy |
|----------|-----------|---------------|-----|-----|-------------|
| Firebase | 10GB/month | ✅ | ✅ | ✅ | ✅ |
| Netlify | 100GB/month | ✅ | ✅ | ✅ | ✅ |
| Vercel | 100GB/month | ✅ | ✅ | ✅ | ✅ |
| GitHub Pages | 1GB/month | ✅ | ✅ | ❌ | ✅ |

---

## 🚨 Troubleshooting

### Common Issues

**1. Routing Issues**
- Ensure rewrites are configured in hosting config
- Use hash routing if needed: `flutter build web --web-renderer html --route-url-strategy hash`

**2. Large Bundle Size**
- Use `--split-debug-info` flag
- Enable tree-shaking: default in release mode

**3. Font Loading Issues**
- Preload fonts in index.html
- Use web-safe fallbacks

**4. Performance Issues**
- Use CanvasKit for complex UI
- Use HTML renderer for better SEO
- Optimize images and assets

---

## 📈 Analytics Setup

### Google Analytics
1. Create GA4 property
2. Add tracking code to `web/index.html`
3. Track page views and events

### Firebase Analytics
```dart
// Add to pubspec.yaml
firebase_analytics: ^10.7.4

// Initialize in main.dart
FirebaseAnalytics.instance;
```

---

## 🔄 Continuous Deployment

### GitHub Actions
Create `.github/workflows/deploy.yml`:
```yaml
name: Deploy to Firebase
on:
  push:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - uses: subosito/flutter-action@v2
    - run: flutter build web --release
    - uses: FirebaseExtended/action-hosting-deploy@v0
      with:
        repoToken: '${{ secrets.GITHUB_TOKEN }}'
        firebaseServiceAccount: '${{ secrets.FIREBASE_SERVICE_ACCOUNT }}'
        projectId: your-project-id
```

---

## 💡 Pro Tips

1. **Use a custom domain** for professional appearance
2. **Enable compression** in hosting settings
3. **Set up monitoring** with Firebase Performance
4. **Use environment variables** for API keys
5. **Test on mobile devices** thoroughly
6. **Set up error tracking** with Sentry or Crashlytics

---

## 📞 Support

If you encounter issues:
1. Check Flutter web documentation
2. Review hosting platform docs
3. Test locally first: `flutter run -d chrome`
4. Check browser console for errors

Happy deploying! 🎉 