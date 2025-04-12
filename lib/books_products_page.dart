import 'package:flutter/material.dart';
import 'book_details_page.dart';

class BooksProductsPage extends StatefulWidget {
  const BooksProductsPage({super.key});

  @override
  State<BooksProductsPage> createState() => _BooksProductsPageState();
}

class _BooksProductsPageState extends State<BooksProductsPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> allBooks = [];
  List<Map<String, String>> filteredBooks = [];

  @override
  void initState() {
    super.initState();
    _initBooks();
  }

  void _initBooks() {
    allBooks = [
      {
        'image': 'assets/books.png',
        'title': 'Medical Notes',
        'description': 'Summary of all medicine topics.',
        'price': '10',
        'phone': '+962789999111',
      },
      {
        'image': 'assets/books.png',
        'title': 'Programming Basics',
        'description': 'Learn Dart & Flutter basics.',
        'price': '15',
        'phone': '+962798888222',
      },
      {
        'image': 'assets/books.png',
        'title': 'Dtata mining slides',
        'description': 'Comprehensive data mining info.',
        'price': '12',
        'phone': '+962797777333',
      },
    ];
    filteredBooks = List.from(allBooks);
  }

  void _filterBooks(String query) {
    setState(() {
      filteredBooks = allBooks.where((book) {
        return book['title']!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3B3B98),
        title: const Text('Books & Slides'),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔍 شريط البحث
            TextField(
              controller: _searchController,
              onChanged: _filterBooks,
              decoration: InputDecoration(
                hintText: 'Search books...',
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
            // 🗂️ قائمة الكتب
            Expanded(
              child: filteredBooks.isEmpty
                  ? const Center(child: Text('No books found.'))
                  : ListView.builder(
                      itemCount: filteredBooks.length,
                      itemBuilder: (context, index) {
                        final book = filteredBooks[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                book['image']!,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(book['title']!,
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text(
                              book['description']!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => BookDetailsPage(
                                      image: book['image']!,
                                      title: book['title']!,
                                      description: book['description']!,
                                      price: book['price']!,
                                      phoneNumber: book['phone']!,
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF3B3B98),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              ),
                              child: const Text('View'),
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
