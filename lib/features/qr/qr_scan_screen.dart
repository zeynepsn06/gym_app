import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:gym_app/core/constants/app_colors.dart';
import '../../core/services/attendance_service.dart';

class QrScanScreen extends StatefulWidget {
  const QrScanScreen({super.key});

  @override
  State<QrScanScreen> createState() => _QrScanScreenState();
}

class _QrScanScreenState extends State<QrScanScreen> {
  bool _scanned = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'Scan QR',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: MobileScanner(
        onDetect: (barcode) {
          if (_scanned) return;

          final String? code = barcode.barcodes.first.rawValue;

          if (code != null) {
            setState(() => _scanned = true);

            // âœ… ATTENDANCE EKLENÄ°YOR
            AttendanceService.addAttendance(code);

            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Success'),
                content: const Text(
                  'Attendance recorded successfully.',
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

