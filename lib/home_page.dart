import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add_product_page.dart';
import 'settings_page.dart';
import 'profile_page.dart';
import 'theme_provider.dart';
import 'chat_list_page.dart';
import 'books_products_page.dart';
import 'engineering_tools_page.dart';
import 'electronics_page.dart';
import 'arts_crafts_page.dart';
import 'clothes_page.dart';
import 'dental_equipment_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String _username = 'User';
  int _unreadMessages = 3;

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? 'User';
    });
  }

  Widget _buildBody() {
    return _selectedIndex == 0
        ? HomeContent(username: _username, unreadMessages: _unreadMessages)
        : const ProfilePage();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: Stack(
        children: [
          _buildBody(),
          Positioned(
            top: 77,
            right: 20,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.settings, color: Colors.white),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage()));
                  },
                ),
                Stack(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chat_bubble_outline, color: Colors.white),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatListPage()));
                      },
                    ),
                    if (_unreadMessages > 0)
                      Positioned(
                        right: 6,
                        top: 6,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          child: Text(
                            '$_unreadMessages',
                            style: const TextStyle(color: Colors.white, fontSize: 10),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF3B3B98),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const AddProductPage()));
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: const Color(0xFF3B3B98),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.home, color: Colors.white),
                onPressed: () => setState(() => _selectedIndex = 0),
              ),
              const SizedBox(width: 40),
              IconButton(
                icon: const Icon(Icons.person, color: Colors.white),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfilePage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ===========================

class HomeContent extends StatelessWidget {
  final String username;
  final int unreadMessages;

  const HomeContent({
    super.key,
    required this.username,
    required this.unreadMessages,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF3B3B98), Color(0xFF2C2C54)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Text(
                'Welcome, $username!',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Category',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search here...',
                      filled: true,
                      fillColor: isDark ? Colors.grey[800] : Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              children: [
                CategoryItem(label: 'Books & Slide', icon: Icons.menu_book, onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const BooksProductsPage()));
                }),
                CategoryItem(label: 'Engineering Tools', icon: Icons.architecture, onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const EngineeringToolsPage()));
                }),
                CategoryItem(label: 'Electronics', icon: Icons.computer, onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const ElectronicsPage()));
                }),
                CategoryItem(label: 'Arts & Crafts', icon: Icons.brush, onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const ArtsCraftsPage()));
                }),
                CategoryItem(label: 'Clothes', icon: Icons.checkroom, onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const ClothesPage()));
                }),
                CategoryItem(label: 'Dental Equipment', icon: Icons.medical_services, onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const DentalEquipmentPage()));
                }),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Recommended', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset('assets/laptop.png', height: 80),
                    Image.asset('assets/books.png', height: 80),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset('assets/stethoscope.png', height: 80),
                    Image.asset('assets/labcoat.png', height: 80),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  const CategoryItem({
    super.key,
    required this.label,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: isDark ? Colors.blueGrey : Colors.blue.shade100,
            radius: 30,
            child: Icon(icon, size: 30, color: Colors.blue),
          ),
          const SizedBox(height: 6),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
