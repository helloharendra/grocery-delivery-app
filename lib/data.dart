import 'package:flutter/material.dart';

/// Sample catalogue for the UI demo. The full app loads products, stock & prices from the store backend.
class Product {
  const Product(this.name, this.unit, this.price, this.mrp, this.emoji, this.category, this.tint);
  final String name, unit, emoji, category;
  final int price, mrp;
  final Color tint;
  int get off => ((mrp - price) / mrp * 100).round();
}

const categories = <(String, String, Color)>[
  ('Fruits & Vegetables', '🥦', Color(0xFFE6F6EC)),
  ('Dairy, Bread & Eggs', '🥛', Color(0xFFFFF6DB)),
  ('Atta, Rice & Dal', '🌾', Color(0xFFFDEFE3)),
  ('Snacks & Munchies', '🍿', Color(0xFFFDE8EC)),
  ('Cold Drinks & Juices', '🧃', Color(0xFFE4F1FD)),
  ('Tea, Coffee & More', '☕', Color(0xFFF1EAE4)),
  ('Cleaning Essentials', '🧽', Color(0xFFE9F7F7)),
  ('Personal Care', '🧴', Color(0xFFF0E9FB)),
];

const products = <Product>[
  Product('Fresh Bananas', '6 pcs', 48, 60, '🍌', 'Fruits & Vegetables', Color(0xFFFFF6DB)),
  Product('Hass Avocado', '1 pc', 129, 179, '🥑', 'Fruits & Vegetables', Color(0xFFE6F6EC)),
  Product('Red Tomatoes', '500 g', 32, 40, '🍅', 'Fruits & Vegetables', Color(0xFFFDE8EC)),
  Product('Broccoli', '250 g', 59, 79, '🥦', 'Fruits & Vegetables', Color(0xFFE6F6EC)),
  Product('Shimla Apples', '4 pcs', 149, 199, '🍎', 'Fruits & Vegetables', Color(0xFFFDE8EC)),
  Product('Toned Milk', '1 L', 66, 68, '🥛', 'Dairy, Bread & Eggs', Color(0xFFE4F1FD)),
  Product('Brown Bread', '400 g', 45, 55, '🍞', 'Dairy, Bread & Eggs', Color(0xFFFDEFE3)),
  Product('Farm Eggs', '12 pcs', 96, 120, '🥚', 'Dairy, Bread & Eggs', Color(0xFFFFF6DB)),
  Product('Salted Butter', '100 g', 58, 60, '🧈', 'Dairy, Bread & Eggs', Color(0xFFFFF6DB)),
  Product('Basmati Rice', '1 kg', 149, 199, '🍚', 'Atta, Rice & Dal', Color(0xFFF1EAE4)),
  Product('Masala Chips', '90 g', 20, 20, '🍟', 'Snacks & Munchies', Color(0xFFFDE8EC)),
  Product('Dark Chocolate', '100 g', 99, 125, '🍫', 'Snacks & Munchies', Color(0xFFF1EAE4)),
  Product('Orange Juice', '1 L', 110, 135, '🧃', 'Cold Drinks & Juices', Color(0xFFFDEFE3)),
  Product('Filter Coffee', '200 g', 189, 230, '☕', 'Tea, Coffee & More', Color(0xFFF1EAE4)),
];
