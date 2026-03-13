import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  bool _isHandled = false;
  final TextEditingController _manualQrController = TextEditingController();

  bool get _useManualEntry =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.windows;

  void _onDetect(BarcodeCapture capture) {
    if (_isHandled) {
      return;
    }

    if (capture.barcodes.isEmpty) {
      return;
    }

    final String? value = capture.barcodes.first.rawValue;
    if (value == null || value.isEmpty) {
      return;
    }

    _isHandled = true;
    Navigator.pop(context, value);
  }

  void _submitManualQr() {
    final String value = _manualQrController.text.trim();
    if (value.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter a QR value')));
      return;
    }

    Navigator.pop(context, value);
  }

  @override
  void dispose() {
    _manualQrController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan QR Code')),
      body: _useManualEntry
          ? Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Manual QR Entry',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Camera scanning is not available on this platform. Enter QR text manually.',
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _manualQrController,
                    decoration: const InputDecoration(
                      labelText: 'QR code value',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _submitManualQr,
                    child: const Text('Use This QR Value'),
                  ),
                ],
              ),
            )
          : MobileScanner(onDetect: _onDetect),
    );
  }
}
