#!/bin/bash
# =============================================================
# Nitara – Flutter Pregnancy App Setup Script
# =============================================================
# Run this script after installing Flutter to set up the project.
# Usage: bash setup.sh

set -e

echo ""
echo "🌸 ======================================"
echo "   Nitara Pregnancy App Setup Script"
echo "🌸 ======================================"
echo ""

# ─── Step 1: Check Flutter ─────────────────────────────────────
echo "📋 Checking Flutter installation..."
if ! command -v flutter &> /dev/null; then
    echo ""
    echo "❌ Flutter not found!"
    echo ""
    echo "📥 Install Flutter by following this guide:"
    echo "   https://docs.flutter.dev/get-started/install/macos"
    echo ""
    echo "   Quick install with Homebrew:"
    echo "   brew install flutter"
    echo ""
    echo "   Or download directly:"
    echo "   https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_arm64_3.22.0-stable.zip"
    echo ""
    exit 1
fi

echo "✅ Flutter found: $(flutter --version | head -1)"

# ─── Step 2: Get dependencies ─────────────────────────────────
echo ""
echo "📦 Getting Flutter dependencies..."
flutter pub get

echo "✅ Dependencies installed!"

# ─── Step 3: Firebase check ────────────────────────────────────
echo ""
echo "🔥 Firebase Setup Required"
echo "─────────────────────────────────────────"
echo "Before building, you MUST set up Firebase:"
echo ""
echo "1. Go to: https://console.firebase.google.com"
echo "2. Click 'Add Project' → Name it 'Nitara'"
echo "3. Add an Android app:"
echo "   Package name: com.nitara.pregnancyapp"
echo "   App nickname: Nitara"
echo "4. Download google-services.json"
echo "5. Replace: android/app/google-services.json"
echo "6. Enable Authentication → Email/Password"
echo "7. Create Firestore Database (start in test mode)"
echo ""
echo "Then run: dart pub global activate flutterfire_cli"
echo "Then run: flutterfire configure"
echo ""

# ─── Step 4: Check if Firebase is configured ──────────────────
if grep -q "YOUR_API_KEY" android/app/google-services.json 2>/dev/null; then
    echo "⚠️  WARNING: google-services.json still has placeholder values."
    echo "   The app will build but Firebase features won't work."
    echo "   Replace android/app/google-services.json with your real file."
    echo ""
fi

# ─── Step 5: Analyze code ─────────────────────────────────────
echo "🔍 Running Flutter analyze..."
flutter analyze --no-fatal-infos || true

# ─── Step 6: Build options ────────────────────────────────────
echo ""
echo "🔨 Build Options:"
echo "─────────────────────────────────────────"
echo ""
echo "▶ Run on device/emulator:"
echo "   flutter run"
echo ""
echo "▶ Build debug APK:"
echo "   flutter build apk --debug"
echo ""
echo "▶ Build release APK:"
echo "   flutter build apk --release"
echo "   APK location: build/app/outputs/flutter-apk/app-release.apk"
echo ""
echo "▶ Build App Bundle (Google Play):"
echo "   flutter build appbundle --release"
echo ""
echo "🌸 ======================================"
echo "   Nitara is ready to build!"
echo "   Good luck, Mama! 💕"
echo "🌸 ======================================"
echo ""
