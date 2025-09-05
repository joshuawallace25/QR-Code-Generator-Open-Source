// Handles the QR code logic and state management.
// Uses GetX for reactivity.
library;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QrController extends GetxController {
  // Observable payload (the data inside QR code).
  var payload = ''.obs;

  // TextField controller for user input.
  final textController = TextEditingController();

  // Key for capturing the QR widget (if saving/sharing).
  final qrKey = GlobalKey();

  // Generate Wi-Fi QR code payload format.
  String makeWifiPayload({
    required String ssid,
    required String password,
    String auth = 'WPA',
  }) {
    final safeSsid = ssid.replaceAll(';', '\\;');
    final safePass = password.replaceAll(';', '\\;');
    return 'WIFI:T:$auth;S:$safeSsid;P:$safePass;;';
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}
