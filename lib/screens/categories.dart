import 'package:flutter/material.dart';

import '../data.dart';
import '../main.dart';
import '../widgets.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});
  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  int sel = 0;

  @override
  Widget build(BuildContext context) {
    final cat = categories[sel];
    final list = products.where((p) => p.category == cat.$1).toList();
    return SafeArea(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(padding: const EdgeInsets.fromLTRB(16, 12, 16, 12), child: Text(cat.$1, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800))),
        Expanded(
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Left rail
            SizedBox(
              width: 86,
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (_, i) => InkWell(
                  onTap: () => setState(() => sel = i),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(color: i == sel ? Colors.white : Colors.transparent, border: Border(right: BorderSide(color: i == sel ? brand : Colors.transparent, width: 3))),
                    child: Column(children: [
                      CircleAvatar(radius: 24, backgroundColor: categories[i].$3, child: Text(categories[i].$2, style: const TextStyle(fontSize: 24))),
                      const SizedBox(height: 4),
                      Text(categories[i].$1, textAlign: TextAlign.center, maxLines: 2, style: TextStyle(fontSize: 10, fontWeight: i == sel ? FontWeight.w800 : FontWeight.w500)),
                    ]),
                  ),
                ),
              ),
            ),
            Expanded(
              child: list.isEmpty
                  ? const Center(child: Text('More products coming soon', style: TextStyle(color: Colors.black45)))
                  : GridView.builder(
                      padding: const EdgeInsets.fromLTRB(8, 0, 16, 16),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10, mainAxisExtent: 262),
                      itemCount: list.length,
                      itemBuilder: (_, i) => ProductTile(list[i], width: null),
                    ),
            ),
          ]),
        ),
      ]),
    );
  }
}
