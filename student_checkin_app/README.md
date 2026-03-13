# Smart Class Check-in App

Smart Class Check-in App is a Flutter MVP for classroom attendance and learning reflection. The app allows students to check in before class, finish class after class, capture GPS location, scan QR codes, answer reflection questions, and store records locally using SQLite.

## Project Description

This project was built for the Smart Class Check-in & Learning Reflection App lab exam. The goal is to verify student participation by combining three types of evidence:

- GPS location
- QR code scanning
- Learning reflection form input

Main screens in the app:

- Home Screen
- Check-in Screen
- Finish Class Screen

Main capabilities:

- Navigation between screens
- QR code scanning with camera support
- GPS location capture
- Mood selection and text form input
- Local SQLite data storage for check-in and check-out records

## Tech Stack

- Flutter
- MaterialApp with named routes
- geolocator
- mobile_scanner
- sqflite
- path

## Setup Instructions

1. Install Flutter SDK and verify the environment.

```bash
flutter doctor
```

2. Open the project folder.

```bash
cd student_checkin_app
```

3. Install dependencies.

```bash
flutter pub get
```

## How To Run The App

Run on Chrome:

```bash
flutter run -d chrome
```

Run on Windows:

```bash
flutter run -d windows
```

Run on Android:

```bash
flutter run -d android
```

Build for web:

```bash
flutter build web
```

Build for Windows:

```bash
flutter build windows
```

Build Android APK:

```bash
flutter build apk
```

## Platform Notes

- Android: QR scanning uses the camera and GPS uses geolocator.
- Web: QR scanning can use the browser camera, and GPS depends on browser permission.
- Windows: GPS depends on Windows location settings. QR input may fall back depending on platform support.

## Project Structure

- lib/main.dart
- lib/screens/home_screen.dart
- lib/screens/checkin_screen.dart
- lib/screens/finish_class_screen.dart
- lib/screens/qr_scanner_screen.dart
- lib/data/database_helper.dart

## Local Data Storage

SQLite helper is implemented in lib/data/database_helper.dart.

Stored fields:

- studentId
- checkinTime
- checkinLocation
- checkoutTime
- checkoutLocation
- mood
- previousTopic
- expectedTopic
- learnedToday
- feedback

## Firebase Configuration Notes

This project can be deployed to Firebase Hosting for the web version.

1. Install Firebase CLI.

```bash
npm install -g firebase-tools
```

2. Login to Firebase.

```bash
firebase login
```

3. Initialize Firebase Hosting in the project root.

```bash
firebase init
```

Recommended Hosting settings:

- Choose Hosting
- Select your Firebase project
- Set public directory to build/web
- Configure as a single-page app: Yes

4. Build the Flutter web app.

```bash
flutter build web
```

5. Deploy to Firebase Hosting.

```bash
firebase deploy
```

6. Save the generated Firebase Hosting URL in your submission.

Notes:

- Current MVP stores data locally using SQLite.
- Firebase Hosting is used for deployment of the web build.
- If Firebase data storage is needed later, firebase_core and cloud_firestore can be added separately.

## Permissions Notes

- Android camera and location permissions are configured in android/app/src/main/AndroidManifest.xml.
- iOS camera and location usage descriptions are configured in ios/Runner/Info.plist.
- Web requires camera and location permission from the browser.
- Windows requires location access to be enabled in system settings.

## Quick Verification

```bash
flutter analyze
flutter test
```
## AI Usage Report

AI tools used in this project include ChatGPT, GitHub Copilot, and Google Gemini.

AI was mainly used to generate Flutter UI scaffolding, QR scanner integration, and basic Firebase configuration guidance. It also assisted in debugging code errors and suggesting improvements during development.

I reviewed and modified the generated code to fit the application requirements. I implemented the check-in logic, adjusted the UI layout, handled Firebase data structure, and ensured that the application flow worked correctly.