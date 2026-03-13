import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

import 'qr_scanner_screen.dart';

class FinishClassScreen extends StatefulWidget {
  const FinishClassScreen({super.key});

  @override
  State<FinishClassScreen> createState() => _FinishClassScreenState();
}

class _FinishClassScreenState extends State<FinishClassScreen> {
  final TextEditingController _learnedController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();

  String _location = "Not captured";
  String _qr = "Not scanned";
  String _time = "";
  bool _isGettingLocation = false;

  bool get _usesManualQrInput =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.windows;

  LocationSettings _locationSettings() {
    if (kIsWeb) {
      return WebSettings(
        accuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 15),
      );
    }

    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        forceLocationManager: true,
        timeLimit: const Duration(seconds: 15),
      );
    }

    return const LocationSettings(
      accuracy: LocationAccuracy.high,
      timeLimit: Duration(seconds: 15),
    );
  }

  String _formatPosition(Position position) {
    return "Lat: ${position.latitude.toStringAsFixed(6)}, "
        "Lng: ${position.longitude.toStringAsFixed(6)} "
        "(±${position.accuracy.toStringAsFixed(1)}m)";
  }

  Future<void> _scanQR() async {
    final String? scannedValue = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => const QrScannerScreen()),
    );

    if (scannedValue == null || scannedValue.isEmpty) {
      return;
    }

    setState(() {
      _qr = scannedValue;
    });

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _usesManualQrInput ? "QR value entered" : "QR Code scanned",
        ),
      ),
    );
  }

  Future<void> _getLocation() async {
    setState(() {
      _isGettingLocation = true;
    });

    try {
      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (!kIsWeb) {
          await Geolocator.openLocationSettings();
        }

        setState(() {
          _location = "Location service disabled";
          _isGettingLocation = false;
        });

        if (!mounted) {
          return;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              kIsWeb
                  ? "Please enable browser location access"
                  : "Please enable location services",
            ),
          ),
        );
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        if (!kIsWeb && permission == LocationPermission.deniedForever) {
          await Geolocator.openAppSettings();
        }

        setState(() {
          _location = "Location permission denied";
          _isGettingLocation = false;
        });

        if (!mounted) {
          return;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Location permission is required")),
        );
        return;
      }

      Position? position;

      try {
        position = await Geolocator.getCurrentPosition(
          locationSettings: _locationSettings(),
        );
      } catch (_) {
        position = await Geolocator.getLastKnownPosition();
      }

      if (position == null) {
        setState(() {
          _location = "Unable to get real-time GPS coordinates";
          _isGettingLocation = false;
        });
        return;
      }

      setState(() {
        _location = _formatPosition(position!);
        _isGettingLocation = false;
      });

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("GPS location captured")));
    } catch (_) {
      setState(() {
        _location = "Failed to get GPS location";
        _isGettingLocation = false;
      });
    }
  }

  void _submitReflection() {
    setState(() {
      _time = DateTime.now().toString();
    });

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Reflection Submitted"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("QR: $_qr"),
              Text("Location: $_location"),
              Text("Time: $_time"),
              Text("Learned: ${_learnedController.text}"),
              Text("Feedback: ${_feedbackController.text}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _learnedController.dispose();
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Gradient Header
          Container(
            height: 220,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                /// Header
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),

                      const SizedBox(width: 10),

                      const Text(
                        "After Class",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                /// Main Card
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF4F6FB),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),

                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              "Great job finishing today's session!",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),

                          /// QR + GPS
                          Row(
                            children: [
                              Expanded(
                                child: _button(
                                  icon: Icons.qr_code,
                                  text: "Scan QR",
                                  onTap: _scanQR,
                                ),
                              ),

                              const SizedBox(width: 16),

                              Expanded(
                                child: _button(
                                  icon: Icons.location_on,
                                  text: _isGettingLocation
                                      ? "Getting GPS..."
                                      : "GPS Location",
                                  onTap: _getLocation,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          Text("QR Result: $_qr"),
                          Text("Location: $_location"),

                          const SizedBox(height: 30),

                          /// Learned
                          const Text(
                            "What did you learn today?",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),

                          const SizedBox(height: 8),

                          TextField(
                            controller: _learnedController,
                            maxLines: 4,
                            decoration: InputDecoration(
                              hintText: "Describe what you learned",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          /// Feedback
                          const Text(
                            "Feedback about the class",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),

                          const SizedBox(height: 8),

                          TextField(
                            controller: _feedbackController,
                            maxLines: 3,
                            decoration: InputDecoration(
                              hintText: "Share your feedback",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),

                          const SizedBox(height: 40),

                          /// Submit
                          Container(
                            width: double.infinity,
                            height: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: const LinearGradient(
                                colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                              ),
                            ),

                            child: ElevatedButton(
                              onPressed: _submitReflection,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                              ),
                              child: const Text(
                                "Submit Reflection",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _button({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(icon), const SizedBox(width: 6), Text(text)],
        ),
      ),
    );
  }
}
