#!/bin/bash

# 🚀 Visual Resume Deployment Script
# This script helps you deploy your Flutter web app to various hosting platforms

echo "🚀 Visual Resume Deployment Helper"
echo "=================================="
echo ""

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed. Please install Flutter first."
    exit 1
fi

echo "📋 Choose your deployment platform:"
echo "1) Firebase Hosting (Recommended)"
echo "2) Netlify"
echo "3) Vercel"
echo "4) GitHub Pages"
echo "5) Just build for manual deployment"
echo ""

read -p "Enter your choice (1-5): " choice

case $choice in
    1)
        echo "🔥 Deploying to Firebase Hosting..."
        echo ""
        
        # Check if Firebase CLI is installed
        if ! command -v firebase &> /dev/null; then
            echo "❌ Firebase CLI is not installed."
            echo "📦 Install it with: npm install -g firebase-tools"
            exit 1
        fi
        
        # Build the app
        echo "🏗️  Building Flutter web app..."
        flutter build web --release
        
        # Check if Firebase is initialized
        if [ ! -f "firebase.json" ]; then
            echo "🔧 Initializing Firebase..."
            firebase init hosting
        fi
        
        # Deploy
        echo "🚀 Deploying to Firebase..."
        firebase deploy
        ;;
        
    2)
        echo "🌐 Preparing for Netlify deployment..."
        echo ""
        
        # Build the app
        echo "🏗️  Building Flutter web app..."
        flutter build web --release
        
        echo "✅ Build complete!"
        echo "📁 Upload the 'build/web' folder to Netlify:"
        echo "   1. Go to https://netlify.com"
        echo "   2. Drag and drop the 'build/web' folder"
        echo "   3. Your site will be live instantly!"
        ;;
        
    3)
        echo "⚡ Deploying to Vercel..."
        echo ""
        
        # Check if Vercel CLI is installed
        if ! command -v vercel &> /dev/null; then
            echo "❌ Vercel CLI is not installed."
            echo "📦 Install it with: npm install -g vercel"
            exit 1
        fi
        
        # Build the app
        echo "🏗️  Building Flutter web app..."
        flutter build web --release
        
        # Deploy
        echo "🚀 Deploying to Vercel..."
        cd build/web && vercel --prod
        ;;
        
    4)
        echo "📚 Preparing for GitHub Pages..."
        echo ""
        
        # Get repository name
        read -p "Enter your GitHub repository name: " repo_name
        
        # Build with base href
        echo "🏗️  Building Flutter web app for GitHub Pages..."
        flutter build web --base-href "/$repo_name/"
        
        # Create docs folder
        mkdir -p docs
        cp -r build/web/* docs/
        
        echo "✅ Build complete!"
        echo "📁 Files copied to 'docs' folder"
        echo "🔧 Next steps:"
        echo "   1. Commit and push the 'docs' folder to your GitHub repo"
        echo "   2. Go to your repo settings"
        echo "   3. Enable GitHub Pages with 'docs' folder as source"
        ;;
        
    5)
        echo "🏗️  Building Flutter web app..."
        flutter build web --release
        
        echo "✅ Build complete!"
        echo "📁 Your built files are in the 'build/web' folder"
        echo "🚀 You can now upload these files to any web hosting service"
        ;;
        
    *)
        echo "❌ Invalid choice. Please run the script again."
        exit 1
        ;;
esac

echo ""
echo "🎉 Deployment process complete!"
echo "💡 Don't forget to:"
echo "   - Set up a custom domain"
echo "   - Configure SSL (usually automatic)"
echo "   - Set up analytics"
echo "   - Test on different devices"
echo ""
echo "📖 For detailed instructions, check deployment-guide.md" 