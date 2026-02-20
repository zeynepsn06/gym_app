import 'package:flutter/material.dart';
import '../../core/widgets/premium_background.dart';

class QrScreen extends StatelessWidget {
  const QrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return PremiumBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text("QR Kodum", style: TextStyle(color: onSurface, fontWeight: FontWeight.bold)),
          iconTheme: IconThemeData(color: onSurface),
        ),
        body: Center(
          child: Text(
            'QR Screen',
            style: TextStyle(color: onSurface, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

