# Smart Class Check-in System

Product Requirement Document

## 1. Overview

The Smart Class Check-in System is a cross-platform application built using Flutter.
It allows students to check in and check out of class sessions using QR code scanning and optional GPS verification.

The system helps instructors track attendance efficiently while reducing manual work.

---

## 2. Objectives

* Provide a fast digital check-in process
* Prevent fake attendance
* Collect student reflections about the class
* Store attendance data for later review

---

## 3. Target Users

* University students
* Course instructors

---

## 4. Core Features

### 4.1 Check-in Before Class

Students must:

* Scan a QR code
* Verify GPS location (mobile only)
* Enter previous lesson topic
* Enter expected topic
* Select mood

### 4.2 Check-out After Class

Students submit:

* Reflection about the lesson
* What they learned today

### 4.3 Cross-Platform Support

The system supports:

* Android
* Web
* Windows

Platform behavior:

| Feature    | Android | Web          | Windows      |
| ---------- | ------- | ------------ | ------------ |
| QR Scanner | Camera  | Manual input | Manual input |
| GPS        | Enabled | Skipped      | Skipped      |

---

## 5. Technical Stack

Frontend

* Flutter

Libraries

* mobile_scanner
* geolocator
* sqflite

Deployment

* Firebase Hosting

---

## 6. Future Improvements

* Geo-fence verification
* Instructor dashboard
* Real-time attendance monitoring
