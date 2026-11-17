import 'package:flutter/material.dart';

import '../core/contact.dart';
import '../data.dart';
import '../main.dart';
import '../widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, MediaQuery.paddingOf(context).top + 14, 20, 20),
          decoration: const BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFFFFD84D), Color(0xFFFFF3C4)]),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              const Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Delivery in', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                  Text('10 minutes', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28, height: 1.1)),
                  Text('Home · Flat 1204, Prestige Lakeside ▾', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                ]),
              ),
              IconButton.filled(
                style: IconButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black87),
                onPressed: () => Contact.show(context, appName, 'Customer Account & Wallet'),
                icon: const Icon(Icons.person_outline_rounded),
              ),
            ]),
            const SizedBox(height: 16),
            TextField(
              readOnly: true,
              onTap: () => Contact.show(context, appName, 'Product Search & Voice Search'),
              decoration: InputDecoration(
                hintText: 'Search "milk", "atta", "chips"…',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
              ),
            ),
          ]),
        ),
      ),
      SliverToBoxAdapter(
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF0C8A4B), Color(0xFF14B86A)]), borderRadius: BorderRadius.circular(22)),
          child: const Row(children: [
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Fresh fruits & veggies', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 20)),
                SizedBox(height: 4),
                Text('Farm to door · Up to 40% off', style: TextStyle(color: Colors.white70)),
              ]),
            ),
            Text('🥬🍓', style: TextStyle(fontSize: 44)),
          ]),
        ),
      ),
      const SliverToBoxAdapter(child: Padding(padding: EdgeInsets.fromLTRB(16, 4, 16, 12), child: Text('Shop by category', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)))),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 12, crossAxisSpacing: 10, mainAxisExtent: 112),
          delegate: SliverChildListDelegate(categories
              .map((c) => Column(children: [
                    Container(height: 72, alignment: Alignment.center, decoration: BoxDecoration(color: c.$3, borderRadius: BorderRadius.circular(16)), child: Text(c.$2, style: const TextStyle(fontSize: 34))),
                    const SizedBox(height: 6),
                    Text(c.$1, textAlign: TextAlign.center, maxLines: 2, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, height: 1.2)),
                  ]))
              .toList()),
        ),
      ),
      _row('Bestsellers', products.take(7).toList()),
      _row('Breakfast essentials', products.where((p) => p.category.startsWith('Dairy')).toList()),
      const SliverToBoxAdapter(child: SizedBox(height: 24)),
    ]);
  }

  Widget _row(String title, List<Product> items) => SliverToBoxAdapter(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(padding: const EdgeInsets.fromLTRB(16, 20, 16, 12), child: Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18))),
          SizedBox(
            height: 262,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, i) => ProductTile(items[i]),
            ),
          ),
        ]),
      );
}
