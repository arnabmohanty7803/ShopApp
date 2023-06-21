import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavourite = false});

  void _setFavValue(bool value) {
    isFavourite = value;
    notifyListeners();
  }

  Future<void> toggleFavouriteStatus(String token, String userId) async {
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    final url = Uri.parse(
        'https://shop-app-50fb6-default-rtdb.firebaseio.com/userFavourites/$userId/$id/.json?auth=$token');
    try {
      final response = await http.put(url, body: json.encode(isFavourite));
      notifyListeners();
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
      _setFavValue(oldStatus);
    }
    final response2 = await http.get(url);
    print(json.decode(response2.body));
  }
}
