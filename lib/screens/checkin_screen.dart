import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class CheckInScreen extends StatelessWidget {
  const CheckInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Check-In')),
      body: MobileScanner(
        onDetect: (barcode, args) {
          // Handle QR code scan result
        },
      ),
    );
  }
}
