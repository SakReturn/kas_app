import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class CartStorage {
  static Future<String> _getPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/cart_data.json';
  }

  static Future<Map<String, int>> readCart() async {
    try {
      final path = await _getPath();
      final file = File(path);
      if (await file.exists()) {
        final content = await file.readAsString();
        return Map<String, int>.from(json.decode(content));
      }
    } catch (e) {
      // Handle read error
    }
    return {};
  }

  static Future<void> writeCart(Map<String, int> cart) async {
    final path = await _getPath();
    final file = File(path);
    await file.writeAsString(json.encode(cart));
  }
}

