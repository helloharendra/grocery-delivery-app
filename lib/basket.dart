import 'package:flutter/widgets.dart';

import 'data.dart';

/// Shopping basket state shared via InheritedNotifier (no extra packages).
class Basket extends ChangeNotifier {
  final Map<Product, int> items = {};
  int qty(Product p) => items[p] ?? 0;
  int get count => items.values.fold(0, (a, b) => a + b);
  int get total => items.entries.fold(0, (s, e) => s + e.key.price * e.value);
  int get mrpTotal => items.entries.fold(0, (s, e) => s + e.key.mrp * e.value);

  void add(Product p) {
    items[p] = qty(p) + 1;
    notifyListeners();
  }

  void remove(Product p) {
    final q = qty(p) - 1;
    q <= 0 ? items.remove(p) : items[p] = q;
    notifyListeners();
  }
}

class BasketScope extends InheritedNotifier<Basket> {
  const BasketScope({super.key, required Basket basket, required super.child}) : super(notifier: basket);
  static Basket of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<BasketScope>()!.notifier!;
}
