import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  final List _shopItems = [
    ["Avocado", "4.00", "lib/images/avocado.png", Colors.green],
    ["Banana", "2.50", "lib/images/banana.png", Colors.yellow],
    ["Chicken", "10.69", "lib/images/chicken.png", Colors.brown],
    ["Water", "1.00", "lib/images/water.png", Colors.blue]
  ];

  List _cartItems = [];


  get shopItems => _shopItems;

  get cartItems => _cartItems;

  void addToCart(int index) {
    _cartItems.add(_shopItems[index]);
    notifyListeners();
  }

  void removeItemFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  void emptyCart() {
    _cartItems.clear();
    notifyListeners();
  }

  String calculateTotal() {
    double totalPrice = 0;
    for (int i = 0; i < _cartItems.length; i++) {
      totalPrice += double.parse(_cartItems[i][1]);
    }
    return totalPrice.toStringAsFixed(2);
  }

}