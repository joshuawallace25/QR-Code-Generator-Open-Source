// UI for generating and displaying QR codes.
// Uses QrController (Controller) to manage state.
library;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../controllers/qr_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(QrController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'QR Code Generator',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Create Your QR Code',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),

                      // Input Field
                      TextField(
                        controller: controller.textController,
                        decoration: const InputDecoration(
                          labelText: 'Text, URL, or Wi-Fi Details',
                          hintText: 'e.g., https://example.com or Wi-Fi SSID',
                        ),
                        maxLines: 2,
                        onChanged: (value) {
                          controller.payload.value = value;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Generate Button
                      Obx(
                        () => AnimatedOpacity(
                          opacity: controller.payload.trim().isEmpty
                              ? 0.5
                              : 1.0,
                          duration: const Duration(milliseconds: 300),
                          child: ElevatedButton.icon(
                            onPressed: controller.payload.trim().isEmpty
                                ? null
                                : () {
                                    controller.payload.refresh();
                                    Get.snackbar(
                                      'Success',
                                      'QR code generated!',
                                      snackPosition: SnackPosition.TOP,
                                      backgroundColor: Colors.green,
                                      colorText: Colors.white,
                                    );
                                  },
                            icon: const Icon(Icons.qr_code_2),
                            label: const Text('Generate QR'),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // QR Preview
                      Center(
                        child: RepaintBoundary(
                          key: controller.qrKey,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Obx(() {
                              final payload = controller.payload.value.trim();
                              return AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                child: payload.isEmpty
                                    ? SizedBox(
                                        key: const ValueKey('empty'),
                                        width: 200,
                                        height: 200,
                                        child: const Center(
                                          child: Text(
                                            'Enter text to generate QR',
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      )
                                    : QrImage(
                                        key: const ValueKey('qr'),
                                        data: payload,
                                        version: QrVersions.auto,
                                        size: 200.0,
                                        gapless: false,
                                        backgroundColor: Colors.white,
                                      ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
