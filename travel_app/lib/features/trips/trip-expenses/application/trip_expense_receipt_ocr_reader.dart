import 'package:flutter/foundation.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import '../data/models/trip_expenses_models.dart';
import 'trip_expense_receipt_ocr.dart';

/// Runs on-device OCR then parses receipt fields.
Future<TripExpenseOcrResult> recognizeExpenseReceipt({
  required String imagePath,
  TripExpensesCurrency currency = TripExpensesCurrency.vnd,
}) async {
  if (!isExpenseReceiptOcrSupported()) {
    throw UnsupportedError('OCR không hỗ trợ trên nền tảng này');
  }

  final input = InputImage.fromFilePath(imagePath);
  final recognizer = TextRecognizer(script: TextRecognitionScript.latin);
  try {
    final recognized = await recognizer.processImage(input);
    return parseExpenseReceiptText(recognized.text, currency: currency);
  } finally {
    await recognizer.close();
  }
}

/// Debug helper: skip ML Kit and parse provided text (tests / desktop).
TripExpenseOcrResult recognizeExpenseReceiptFromText(
  String text, {
  TripExpensesCurrency currency = TripExpensesCurrency.vnd,
}) => parseExpenseReceiptText(text, currency: currency);

bool get expenseReceiptOcrAvailable {
  if (kDebugMode && !isExpenseReceiptOcrSupported()) {
    return false;
  }
  return isExpenseReceiptOcrSupported();
}
