@echo off
cls

echo 🚀 Visual Resume Deployment Helper
echo ==================================
echo.

REM Check if Flutter is installed
flutter --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Flutter is not installed. Please install Flutter first.
    pause
    exit /b 1
)

echo 📋 Choose your deployment platform:
echo 1^) Firebase Hosting ^(Recommended^)
echo 2^) Netlify
echo 3^) Vercel
echo 4^) GitHub Pages
echo 5^) Just build for manual deployment
echo.

set /p choice="Enter your choice (1-5): "

if "%choice%"=="1" goto firebase
if "%choice%"=="2" goto netlify
if "%choice%"=="3" goto vercel
if "%choice%"=="4" goto github
if "%choice%"=="5" goto build
goto invalid

:firebase
echo 🔥 Deploying to Firebase Hosting...
echo.

REM Check if Firebase CLI is installed
firebase --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Firebase CLI is not installed.
    echo 📦 Install it with: npm install -g firebase-tools
    pause
    exit /b 1
)

REM Build the app
echo 🏗️  Building Flutter web app...
flutter build web --release

REM Check if Firebase is initialized
if not exist "firebase.json" (
    echo 🔧 Initializing Firebase...
    firebase init hosting
)

REM Deploy
echo 🚀 Deploying to Firebase...
firebase deploy
goto end

:netlify
echo 🌐 Preparing for Netlify deployment...
echo.

REM Build the app
echo 🏗️  Building Flutter web app...
flutter build web --release

echo ✅ Build complete!
echo 📁 Upload the 'build/web' folder to Netlify:
echo    1. Go to https://netlify.com
echo    2. Drag and drop the 'build/web' folder
echo    3. Your site will be live instantly!
goto end

:vercel
echo ⚡ Deploying to Vercel...
echo.

REM Check if Vercel CLI is installed
vercel --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Vercel CLI is not installed.
    echo 📦 Install it with: npm install -g vercel
    pause
    exit /b 1
)

REM Build the app
echo 🏗️  Building Flutter web app...
flutter build web --release

REM Deploy
echo 🚀 Deploying to Vercel...
cd build\web
vercel --prod
cd ..\..
goto end

:github
echo 📚 Preparing for GitHub Pages...
echo.

set /p repo_name="Enter your GitHub repository name: "

REM Build with base href
echo 🏗️  Building Flutter web app for GitHub Pages...
flutter build web --base-href "/%repo_name%/"

REM Create docs folder
if not exist "docs" mkdir docs
xcopy "build\web\*" "docs\" /E /Y

echo ✅ Build complete!
echo 📁 Files copied to 'docs' folder
echo 🔧 Next steps:
echo    1. Commit and push the 'docs' folder to your GitHub repo
echo    2. Go to your repo settings
echo    3. Enable GitHub Pages with 'docs' folder as source
goto end

:build
echo 🏗️  Building Flutter web app...
flutter build web --release

echo ✅ Build complete!
echo 📁 Your built files are in the 'build\web' folder
echo 🚀 You can now upload these files to any web hosting service
goto end

:invalid
echo ❌ Invalid choice. Please run the script again.
pause
exit /b 1

:end
echo.
echo 🎉 Deployment process complete!
echo 💡 Don't forget to:
echo    - Set up a custom domain
echo    - Configure SSL ^(usually automatic^)
echo    - Set up analytics
echo    - Test on different devices
echo.
echo 📖 For detailed instructions, check deployment-guide.md
echo.
pause 