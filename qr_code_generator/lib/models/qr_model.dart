// Represents a QR code data structure.
// Currently minimal, but scalable for future use cases
// (e.g., saving history, categorizing QR codes, etc.).
library;

class QrModel {
  final String data;
  final DateTime createdAt;

  QrModel({required this.data, required this.createdAt});
}
