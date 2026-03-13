# Smart Class Check-in & Learning Reflection App

## Product Requirement Document

## Problem Statement

Universities need a simple way to verify that students are physically present in class and actively participate in the session. Traditional attendance methods are easy to fake and do not capture student reflection after class. This project solves that problem by combining GPS location, QR code verification, and short learning reflection in a single Flutter application.

## Target User

- University students who need to check in before class and finish class after the session
- Instructors or course staff who need a reliable attendance and participation record

## Product Goal

Build a working MVP that allows students to:

- Check in before class
- Confirm attendance with QR code and GPS location
- Record mood and expected learning outcome
- Finish class with another QR code and GPS verification
- Submit what they learned and class feedback
- Save the data locally for review

## Feature List

### 1. Home Screen

- Display the main dashboard
- Provide navigation to:
	- Check-in Before Class
	- Finish Class

### 2. Check-in Before Class

- Capture timestamp automatically
- Capture GPS location
- Scan QR code using camera when supported
- Provide manual QR input fallback on unsupported platforms
- Allow the student to enter:
	- Previous class topic
	- Expected topic today
	- Mood before class

### 3. Finish Class

- Capture timestamp automatically
- Capture GPS location
- Scan QR code again
- Allow the student to enter:
	- What they learned today
	- Feedback about the class or instructor

### 4. Local Data Storage

- Store check-in and check-out data locally using SQLite
- Support later retrieval or extension to cloud sync

### 5. Cross-Platform Support

- Android
- Web
- Windows

Platform behavior:

| Feature | Android | Web | Windows |
|------|------|------|------|
| QR Code | Camera scan | Camera scan if browser allows | Manual input fallback |
| GPS | Real-time location | Browser location permission | System location permission |

## User Flow

### Before Class Flow

1. Student opens the app
2. Student lands on Home Screen
3. Student presses Check-in Before Class
4. System records GPS location and timestamp
5. Student scans or enters class QR code
6. Student enters previous class topic
7. Student enters expected topic today
8. Student selects mood
9. Student submits check-in
10. Data is saved locally

### After Class Flow

1. Student returns to Home Screen
2. Student presses Finish Class
3. System records GPS location and timestamp
4. Student scans or enters QR code again
5. Student enters what they learned today
6. Student enters feedback
7. Student submits reflection
8. Data is saved locally as check-out information

## Data Fields

The application stores the following fields:

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

## Tech Stack

- Flutter for cross-platform application development
- MaterialApp and named routes for navigation
- geolocator for GPS location retrieval
- mobile_scanner for QR code scanning
- sqflite for local SQLite storage
- path for database path handling
- Firebase Hosting for deployment of the web version

## MVP Scope

Included in MVP:

- 3 main screens
- Navigation
- GPS capture
- QR scan or fallback input
- Form input
- Local data storage
- Web deployment support via Firebase Hosting

Not included in MVP:

- Authentication system
- Instructor dashboard
- Real-time Firebase database sync
- Attendance analytics

## Success Criteria

- Student can complete check-in flow successfully
- Student can complete finish-class reflection successfully
- GPS and QR flow work on supported platforms
- Data is saved locally without app crash
- Web build can be deployed to Firebase Hosting

## Future Improvements

- Add Firebase Firestore for cloud data sync
- Add student login and identity validation
- Add instructor dashboard and attendance reports
- Add classroom geofencing for stricter presence verification
