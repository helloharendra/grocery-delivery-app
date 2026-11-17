import 'package:flutter/material.dart';

import '../basket.dart';
import '../core/contact.dart';
import '../main.dart';
import '../widgets.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final b = BasketScope.of(context);
    if (b.items.isEmpty) {
      return const Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text('🛒', style: TextStyle(fontSize: 72)),
          SizedBox(height: 8),
          Text('Your cart is empty', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
          Text('Add items from Home or Categories', style: TextStyle(color: Colors.black45)),
        ]),
      );
    }
    final delivery = b.total >= 199 ? 0 : 25;
    const handling = 4;
    final saved = b.mrpTotal - b.total;

    return SafeArea(
      child: ListView(padding: const EdgeInsets.all(16), children: [
        const Text('Checkout', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: const Color(0xFFE6F6EC), borderRadius: BorderRadius.circular(14)),
          child: Row(children: [
            const Icon(Icons.bolt_rounded, color: brand),
            const SizedBox(width: 8),
            Expanded(child: Text('Delivery in 10 minutes · You saved ₹$saved', style: const TextStyle(fontWeight: FontWeight.w700, color: brand))),
          ]),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
          child: Column(
            children: b.items.keys
                .map((p) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(children: [
                        Container(width: 52, height: 52, alignment: Alignment.center, decoration: BoxDecoration(color: p.tint, borderRadius: BorderRadius.circular(12)), child: Text(p.emoji, style: const TextStyle(fontSize: 28))),
                        const SizedBox(width: 12),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(p.name, style: const TextStyle(fontWeight: FontWeight.w700)), Text(p.unit, style: const TextStyle(color: Colors.black45, fontSize: 12))])),
                        AddButton(p),
                        SizedBox(width: 64, child: Text('₹${p.price * b.qty(p)}', textAlign: TextAlign.right, style: const TextStyle(fontWeight: FontWeight.w800))),
                      ]),
                    ))
                .toList(),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
          child: Column(children: [
            const Align(alignment: Alignment.centerLeft, child: Text('Bill details', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16))),
            const SizedBox(height: 10),
            _line('Items total', '₹${b.total}', strike: '₹${b.mrpTotal}'),
            _line('Delivery fee', delivery == 0 ? 'FREE' : '₹$delivery', green: delivery == 0),
            _line('Handling charge', '₹$handling'),
            const Divider(height: 24),
            _line('To pay', '₹${b.total + delivery + handling}', bold: true),
          ]),
        ),
        const SizedBox(height: 16),
        FilledButton(
          style: FilledButton.styleFrom(padding: const EdgeInsets.all(18), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
          onPressed: () => Contact.show(context, appName, 'Payments, Slot Booking & Live Tracking'),
          child: Text('Pay ₹${b.total + delivery + handling}  ·  Place order', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
        ),
      ]),
    );
  }

  Widget _line(String k, String v, {String? strike, bool green = false, bool bold = false}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(children: [
          Expanded(child: Text(k, style: TextStyle(fontWeight: bold ? FontWeight.w800 : FontWeight.w500, color: bold ? Colors.black : Colors.black54))),
          if (strike != null) Text('$strike  ', style: const TextStyle(color: Colors.black38, decoration: TextDecoration.lineThrough, fontSize: 12)),
          Text(v, style: TextStyle(fontWeight: bold ? FontWeight.w900 : FontWeight.w700, color: green ? brand : Colors.black87, fontSize: bold ? 16 : 14)),
        ]),
      );
}
