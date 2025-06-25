import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class HomeScreen extends StatefulWidget {
  final String email;

  const HomeScreen({super.key, required this.email});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, int> cart = {};

  String get displayName {
    if (widget.email == "guest@kas.com") return "Guest";
    return widget.email.split('@').first;
  }

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  Future<void> _loadCart() async {
    final file = await _getLocalFile();
    if (await file.exists()) {
      final contents = await file.readAsString();
      setState(() {
        cart = Map<String, int>.from(json.decode(contents));
      });
    }
  }

  Future<void> _saveCart() async {
    final file = await _getLocalFile();
    await file.writeAsString(json.encode(cart));
  }

  Future<File> _getLocalFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/cart.json');
  }

  void _updateQuantity(String productName, int change) {
    setState(() {
      cart[productName] = (cart[productName] ?? 0) + change;
      if (cart[productName]! < 0) cart[productName] = 0;
    });
    _saveCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appBar(context), body: _body);
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 107, 5, 5),
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hello, $displayName 👋",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
          ),
          Text(
            '(${widget.email})',
            style: const TextStyle(fontSize: 12, color: Colors.white70),
          ),
        ],
      ),
      actions: [
        _iconButton(Icons.search),
        const SizedBox(width: 8),
        _iconButton(Icons.notifications),
        const SizedBox(width: 8),
        Stack(
          children: [
            _iconButton(Icons.shopping_cart),
            if (cart.values.any((q) => q > 0))
              Positioned(
                right: 0,
                top: -5,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    cart.values.reduce((a, b) => a + b).toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 12),
      ],
    );
  }

  Widget _iconButton(IconData icon) {
    return Container(
      margin: const EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade200,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.black87),
        onPressed: () {},
      ),
    );
  }

  Widget get _body {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome back!",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Here's your overview for today.",
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            _searchBox(),
            const SizedBox(height: 24),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/kasSignboard.jpg',
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
            ),
            const SizedBox(height: 24),
            _sectionHeader("Recommend"),
            const SizedBox(height: 12),
            _recommendList(),
            const SizedBox(height: 24),
            _sectionHeader("Products"),
            const SizedBox(height: 12),
            _productGrid(),
          ],
        ),
      ),
    );
  }

  Widget _searchBox() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search products...',
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: (value) {
        print('Searching: $value');
      },
    );
  }

  Widget _sectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {},
          child: const Text("Show all", style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }

  Widget _recommendList() {
    final imageList = [
      'assets/images/item1.jpg',
      'assets/images/item2.jpg',
      'assets/images/item3.jpg',
      'assets/images/item4.jpg',
      'assets/images/item5.jpg',
      'assets/images/item6.jpg',
    ];

    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        reverse: false,
        itemCount: imageList.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imageList[index],
              width: 160,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }

  Widget _productGrid() {
    final products = [
      {'name': 'G-Shock watch', 'img': 'assets/images/item1.jpg'},
      {'name': 'M1 Laser Keyboard', 'img': 'assets/images/item2.jpg'},
      {'name': 'Smart Phone', 'img': 'assets/images/item3.jpg'},
      {'name': 'AirPods', 'img': 'assets/images/item4.jpg'},
      {'name': 'Apple Pencil', 'img': 'assets/images/item5.jpg'},
      {'name': 'Golden Coin', 'img': 'assets/images/item6.jpg'},
    ];

    return SizedBox(
      height: 260,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Container(
            width: 180,
            margin: const EdgeInsets.only(right: 12),
            child: _productCard(products[index]),
          );
        },
      ),
    );
  }

  Widget _productCard(Map<String, String> product) {
    final productName = product['name']!;
    final productImg = product['img']!;
    final quantity = cart[productName] ?? 0;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                productImg,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Column(
              children: [
                Text(productName, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () => _updateQuantity(productName, -1),
                    ),
                    Text(quantity.toString(), style: const TextStyle(fontSize: 16)),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: () => _updateQuantity(productName, 1),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
