import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product(
      {this.isFavourite = false,
      required this.id,
      required this.description,
      required this.title,
      required this.imageUrl,
      required this.price});

  void _setFavValue(bool newValue) {
    isFavourite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavouriteStatus(String token) async {
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    final url = Uri.https('shopapp-d7ac6-default-rtdb.firebaseio.com',
        '/products/$id.json?auth=$token');
    try {
      final response = await http.patch(url,
          body: jsonEncode({
            'isFavourite': isFavourite,
          }));
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
      _setFavValue(oldStatus);
    }
  }
}
