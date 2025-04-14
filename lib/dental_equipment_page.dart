import 'package:flutter/material.dart';
import 'dental_equipment_details_page.dart';

class DentalEquipmentPage extends StatefulWidget {
  const DentalEquipmentPage({super.key});

  @override
  State<DentalEquipmentPage> createState() => _DentalEquipmentPageState();
}

class _DentalEquipmentPageState extends State<DentalEquipmentPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> allItems = [];
  List<Map<String, String>> filteredItems = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() {
    allItems = [
      {
        'image': 'assets/dental_equipment.png',
        'title': 'Dental Kit Pro',
        'description': 'Professional dental kit for hygiene.',
        'price': '15',
        'phone': '+962788888888',
      },
      // يمكنك إضافة المزيد هنا بنفس الشكل
    ];
    filteredItems = List.from(allItems);
  }

  void _filter(String query) {
    setState(() {
      filteredItems = allItems.where((item) {
        return item['title']!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3B3B98),
        title: const Text('Dental Equipment', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔍 شريط البحث
            TextField(
              controller: _searchController,
              onChanged: _filter,
              decoration: InputDecoration(
                hintText: 'Search dental tools...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: isDark ? Colors.grey[850] : Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // 🦷 عرض المنتجات
            Expanded(
              child: filteredItems.isEmpty
                  ? const Center(child: Text('No dental equipment found.'))
                  : ListView.builder(
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = filteredItems[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                item['image']!,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              item['title']!,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              item['description']!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => DentalEquipmentDetailsPage(
                                      image: item['image']!,
                                      title: item['title']!,
                                      description: item['description']!,
                                      price: item['price']!,
                                      phoneNumber: item['phone']!,
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF3B3B98),
                              ),
                              child: const Text("View"),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
