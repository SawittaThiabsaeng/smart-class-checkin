# Smart Class Check-in App

Flutter application for classroom check-in and finish-class reflection.

The app includes:
- Home dashboard with navigation
- Check-in Before Class screen
- Finish Class screen
- QR scanning (Android camera, manual input on Web and Windows)
- GPS location capture
- Local SQLite helper for attendance records

## Features

1. Navigation
- HomeScreen is the start screen
- Navigate to CheckInScreen and FinishClassScreen

2. Check-in flow
- Capture GPS location
- Scan or enter QR
- Select mood
- Enter previous topic and expected topic

3. Finish-class flow
- Capture GPS location
- Scan or enter QR
- Enter learned today and feedback

4. Local database helper
- SQLite helper class included at lib/data/database_helper.dart
- Supports saveCheckIn and saveCheckOut methods

## Tech Stack

- Flutter (MaterialApp + named routes)
- geolocator
- mobile_scanner
- sqflite
- path

## Platform Behavior

1. QR code
- Android: camera scanning via mobile_scanner
- Web and Windows: manual QR text input screen

2. GPS
- Android: real-time GPS with permission and service checks
- Web and Windows: location retrieval supported through geolocator (depends on browser and OS permissions)

## Project Structure

- lib/main.dart
- lib/screens/home_screen.dart
- lib/screens/checkin_screen.dart
- lib/screens/finish_class_screen.dart
- lib/screens/qr_scanner_screen.dart
- lib/data/database_helper.dart

## Setup

1. Install Flutter SDK and verify:

	flutter doctor

2. Install dependencies:

	flutter pub get

## Run

1. Web:

	flutter run -d chrome

2. Windows:

	flutter run -d windows

3. Android:

	flutter run -d android

## Build

1. Web build:

	flutter build web

2. Windows build:

	flutter build windows

3. Android APK:

	flutter build apk

## Firebase Configuration Notes

This project is prepared for Firebase Hosting deployment (Web).

1. Install Firebase CLI:

	npm install -g firebase-tools

2. Login to Firebase:

	firebase login

3. Initialize Firebase in project root:

	firebase init

Recommended options:
- Select Hosting
- Choose your Firebase project
- Set public directory to build/web
- Configure as single-page app: Yes

4. Build Flutter web app:

	flutter build web

5. Deploy to Firebase Hosting:

	firebase deploy

6. Save deployed URL in your submission.

Notes:
- Current MVP uses local SQLite for data storage.
- If Firestore is required, add firebase_core and cloud_firestore, then configure Android/iOS/Web app IDs from Firebase Console.
- For Web app config, create Firebase web app in Firebase Console and include the generated config in your Flutter web setup.

## Permissions Notes

1. Android
- Camera and location permissions are configured in android/app/src/main/AndroidManifest.xml

2. iOS
- Camera and location usage descriptions are configured in ios/Runner/Info.plist

3. Web
- Allow location permission in the browser when prompted

4. Windows
- Enable system location from Windows settings if location is unavailable

## Quick Verify

1. Check project health:

	flutter analyze

2. Optional tests:

	flutter test
