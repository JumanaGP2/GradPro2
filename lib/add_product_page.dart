// AddProductPage with Multiple Image Upload and Dark Mode support
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final List<File> _images = [];
  final ImagePicker _picker = ImagePicker();

  final TextEditingController _productInfoController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String? selectedCategory;
  final List<String> categories = [
    'Books & Slides',
    'Electronics',
    'Engineering Tools',
  ];

  bool isCallSelected = false;
  bool isChatSelected = false;

  Future<void> _pickImages() async {
    final pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      setState(() {
        _images.addAll(pickedFiles.map((x) => File(x.path)).take(6 - _images.length));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        elevation: 0,
        backgroundColor: const Color(0xFF3B3B98),
        title: const Text("Add Product", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Upload Product Images", style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
            const SizedBox(height: 10),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _images.length + 1,
                itemBuilder: (context, index) {
                  if (index == _images.length && _images.length < 6) {
                    return GestureDetector(
                      onTap: _pickImages,
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.add_a_photo, size: 30, color: Colors.grey),
                      ),
                    );
                  } else if (index < _images.length) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: FileImage(_images[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),

            const SizedBox(height: 20),
            TextField(
              controller: _productInfoController,
              maxLines: 3,
              style: TextStyle(color: textColor),
              decoration: _inputDecoration("Add product info", isDark),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: textColor),
              decoration: _inputDecoration("Product Price", isDark),
            ),
            const SizedBox(height: 30),
            Text("Select Categories ▼", style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                filled: true,
                fillColor: isDark ? Colors.grey[800] : Colors.grey.shade100,
              ),
              dropdownColor: isDark ? Colors.grey[900] : Colors.white,
              hint: Text("Choose a category", style: TextStyle(color: textColor)),
              items: categories.map((cat) => DropdownMenuItem(
                value: cat,
                child: Text(cat, style: TextStyle(color: textColor)),
              )).toList(),
              onChanged: (val) => setState(() => selectedCategory = val),
            ),
            const SizedBox(height: 30),
            Text("Select contact info", style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _contactOption(
                  icon: Icons.phone,
                  label: "Call",
                  isSelected: isCallSelected,
                  onTap: () => setState(() => isCallSelected = !isCallSelected),
                ),
                _contactOption(
                  icon: Icons.chat,
                  label: "Chat",
                  isSelected: isChatSelected,
                  onTap: () => setState(() => isChatSelected = !isChatSelected),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (isCallSelected)
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                style: TextStyle(color: textColor),
                decoration: _inputDecoration("Enter your phone number", isDark),
              ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => print("Publishing product..."),
                icon: const Icon(Icons.check_circle_outline),
                label: const Text("Publish Product"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, bool isDark) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
      filled: true,
      fillColor: isDark ? Colors.grey[800] : Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _contactOption({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: isSelected ? Colors.blue : Colors.grey[400],
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(height: 6),
          Text(label),
        ],
      ),
    );
  }
}
