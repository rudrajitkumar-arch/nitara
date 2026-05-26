# Nitara – Pregnancy Companion App 🌸

A beautiful, full-featured Flutter pregnancy tracking app for Android.

---

## Features

| Feature | Status |
|---|---|
| Baby Growth Tracker (40 weeks) | ✅ |
| Fruit Size Comparisons | ✅ |
| Trimester Progress | ✅ |
| Weight Tracker + Chart | ✅ |
| Water Intake Tracker | ✅ |
| Sleep Tracker | ✅ |
| Mood Tracker | ✅ |
| Nutrition Guide (Safe/Avoid/Recipes) | ✅ |
| Yoga & Exercise (12 exercises) | ✅ |
| Safety Warning System | ✅ |
| Reminders with Local Notifications | ✅ |
| Motivational Quotes | ✅ |
| Affirmations Grid | ✅ |
| Relaxation Techniques | ✅ |
| Partner Support Tips | ✅ |
| Firebase Auth (Email/Password) | ✅ |
| Cloud Firestore | ✅ |
| Offline Support (Hive) | ✅ |
| Dark Mode | ✅ |
| Smooth Animations | ✅ |

---

## Quick Start

### 1. Install Flutter

```bash
# macOS with Homebrew
brew install flutter

# Or download: https://docs.flutter.dev/get-started/install
```

### 2. Run Setup Script

```bash
cd /path/to/Nitara
bash setup.sh
```

### 3. Firebase Setup (Required for Auth & Cloud)

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Create project → Add Android App
3. Package name: `com.nitara.pregnancyapp`
4. Download `google-services.json` → place in `android/app/`
5. Enable **Email/Password** Authentication
6. Create **Firestore Database** (test mode)
7. Run: `flutterfire configure`

### 4. Install Dependencies

```bash
flutter pub get
```

### 5. Run App

```bash
flutter run
```

### 6. Build APK

```bash
# Debug APK
flutter build apk --debug

# Release APK
flutter build apk --release
# → build/app/outputs/flutter-apk/app-release.apk
```

---

## Project Structure

```
lib/
├── main.dart              # App entry point
├── firebase_options.dart  # Firebase config (replace with yours)
├── app/
│   ├── app.dart           # Root MaterialApp
│   ├── router.dart        # GoRouter navigation
│   └── theme.dart         # Light + Dark themes
├── core/
│   ├── constants/         # Colors, strings, assets
│   ├── services/          # Auth, Notifications
│   └── utils/             # Pregnancy calculator
├── features/
│   ├── auth/              # Splash, Onboarding, Login, Signup, Setup
│   ├── home/              # Dashboard
│   ├── baby_growth/       # 40-week tracker
│   ├── health/            # Weight, Water, Sleep, Mood
│   ├── nutrition/         # Safe/Avoid foods, Recipes
│   ├── yoga/              # Exercises with safety dialog
│   ├── reminders/         # Local push notifications
│   ├── emotional/         # Quotes, Affirmations, Relaxation
│   └── profile/           # Settings, Dark mode
└── shared/
    └── widgets/           # GradientButton, NitaraCard, etc.
```

---

## Tech Stack

- **Flutter** — Cross-platform UI
- **Provider** — State management
- **GoRouter** — Navigation
- **Firebase Auth** — Authentication
- **Cloud Firestore** — Cloud database
- **Hive** — Offline local storage
- **flutter_local_notifications** — Push notifications
- **fl_chart** — Weight charts
- **flutter_animate** — Smooth animations
- **google_fonts** — Nunito typography

---

## Design

- 🎨 Soft pastel palette: Pink, Lavender, Peach, White
- 🌙 Full dark mode support
- ✨ Micro-animations on every screen
- 📱 Rounded cards, clean typography
- 🌸 Nunito font throughout

---

## License

© 2024 Nitara. All rights reserved.
