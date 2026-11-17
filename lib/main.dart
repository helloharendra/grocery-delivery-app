// FreshKart – Grocery delivery app UI demo by Naya Prayog Technologies (https://nayaprayog.com)
// Run: flutter pub get && flutter run   (Android, iOS or Chrome)
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'basket.dart';
import 'screens/cart.dart';
import 'screens/categories.dart';
import 'screens/home.dart';

const appName = 'FreshKart';
const brand = Color(0xFF0C8A4B);
const accent = Color(0xFFFFC83D);

/// Created once so state survives root rebuilds (resize, rotation, theme changes).
final _basket = Basket();

void main() => runApp(const FreshKartApp());

class FreshKartApp extends StatelessWidget {
  const FreshKartApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: brand, primary: brand, tertiary: accent));
    return BasketScope(
      basket: _basket,
      child: MaterialApp(
        title: appName,
        debugShowCheckedModeBanner: false,
        theme: base.copyWith(scaffoldBackgroundColor: const Color(0xFFF5F7F5), textTheme: GoogleFonts.manropeTextTheme(base.textTheme)),
        home: const Shell(),
      ),
    );
  }
}

class Shell extends StatefulWidget {
  const Shell({super.key});
  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  int i = 0;

  @override
  Widget build(BuildContext context) {
    final basket = BasketScope.of(context);
    return Scaffold(
      body: IndexedStack(index: i, children: const [HomeScreen(), CategoriesScreen(), CartScreen()]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: i,
        backgroundColor: Colors.white,
        onDestinationSelected: (v) => setState(() => i = v),
        destinations: [
          const NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded, color: brand), label: 'Home'),
          const NavigationDestination(icon: Icon(Icons.grid_view_outlined), selectedIcon: Icon(Icons.grid_view_rounded, color: brand), label: 'Categories'),
          NavigationDestination(
            icon: Badge(isLabelVisible: basket.count > 0, label: Text('${basket.count}'), child: const Icon(Icons.shopping_bag_outlined)),
            selectedIcon: const Icon(Icons.shopping_bag_rounded, color: brand),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}
