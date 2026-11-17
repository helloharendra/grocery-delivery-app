import 'package:flutter/material.dart';

import 'basket.dart';
import 'data.dart';
import 'main.dart';

class ProductTile extends StatelessWidget {
  const ProductTile(this.p, {super.key, this.width = 150});
  final Product p;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: Colors.black.withValues(alpha: .05))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Stack(children: [
          Container(
            height: 96,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: p.tint, borderRadius: BorderRadius.circular(14)),
            child: Text(p.emoji, style: const TextStyle(fontSize: 52)),
          ),
          if (p.off > 0)
            Positioned(
              left: 0, top: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: const BoxDecoration(color: Color(0xFF2563EB), borderRadius: BorderRadius.only(topLeft: Radius.circular(14), bottomRight: Radius.circular(10))),
                child: Text('${p.off}%\nOFF', textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w900, height: 1.1)),
              ),
            ),
        ]),
        const SizedBox(height: 8),
        Row(children: [
          const Icon(Icons.timer_outlined, size: 12, color: Colors.black45),
          const SizedBox(width: 3),
          Text('10 MINS', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: Colors.black.withValues(alpha: .55))),
        ]),
        const SizedBox(height: 4),
        Text(p.name, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w700, height: 1.2)),
        Text(p.unit, style: const TextStyle(color: Colors.black45, fontSize: 12)),
        const Spacer(),
        Row(children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('₹${p.price}', style: const TextStyle(fontWeight: FontWeight.w800)),
              if (p.mrp > p.price) Text('₹${p.mrp}', style: const TextStyle(fontSize: 11, color: Colors.black38, decoration: TextDecoration.lineThrough)),
            ]),
          ),
          AddButton(p),
        ]),
      ]),
    );
  }
}

class AddButton extends StatelessWidget {
  const AddButton(this.p, {super.key});
  final Product p;

  @override
  Widget build(BuildContext context) {
    final b = BasketScope.of(context);
    final q = b.qty(p);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 34,
      width: q == 0 ? 64 : 80,
      decoration: BoxDecoration(color: q == 0 ? Colors.white : brand, borderRadius: BorderRadius.circular(10), border: Border.all(color: brand)),
      child: q == 0
          ? InkWell(onTap: () => b.add(p), child: const Center(child: Text('ADD', style: TextStyle(color: brand, fontWeight: FontWeight.w900))))
          : Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              InkWell(onTap: () => b.remove(p), child: const Icon(Icons.remove, color: Colors.white, size: 18)),
              Text('$q', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
              InkWell(onTap: () => b.add(p), child: const Icon(Icons.add, color: Colors.white, size: 18)),
            ]),
    );
  }
}
