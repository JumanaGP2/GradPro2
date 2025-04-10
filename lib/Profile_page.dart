import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;
import 'contact_info_page.dart'; // تأكد أن هذه الصفحة موجودة

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _imageFile;
  String _username = 'Username';
  String _email = 'your@email.com';

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('profileImagePath');
    if (imagePath != null && File(imagePath).existsSync()) {
      _imageFile = File(imagePath);
    }
    setState(() {
      _username = prefs.getString('username') ?? 'Username';
      _email = prefs.getString('email') ?? 'your@email.com';
    });
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final dir = await getApplicationDocumentsDirectory();
      final fileName = path.basename(picked.path);
      final savedImage = await File(picked.path).copy('${dir.path}/$fileName');

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profileImagePath', savedImage.path);

      setState(() {
        _imageFile = savedImage;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Profile image changed successfully')),
      );
    }
  }

  void _editUsername() async {
    final controller = TextEditingController(text: _username);
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Username'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Enter new username"),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
              onPressed: () => Navigator.pop(context, controller.text),
              child: const Text('Save')),
        ],
      ),
    );

    if (result != null && result.trim().isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', result);
      setState(() => _username = result);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Username changed successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1746A2),
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          GestureDetector(
            onTap: _pickImage,
            child: CircleAvatar(
              radius: 45,
              backgroundColor: Colors.blue.shade100,
              backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
              child: _imageFile == null
                  ? const Icon(Icons.person, size: 45, color: Colors.blue)
                  : null,
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: _editUsername,
            child: Text(
              _username,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _email,
            style: TextStyle(color: isDark ? Colors.white70 : Colors.grey),
          ),
          const SizedBox(height: 30),
          _buildItem(
            context,
            Icons.phone,
            "Contact Info",
            Colors.green,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ContactInfoPage()),
              );
            },
          ),
          _buildItem(context, Icons.history, "Recent Activities", Colors.pinkAccent, () {}),
          _buildItem(context, Icons.security, "Security Settings", Colors.amber, () {}),
          _buildItem(context, Icons.logout, "Log out", Colors.red, () {
            // TODO: logout logic
          }),
        ],
      ),
    );
  }

  Widget _buildItem(
    BuildContext context,
    IconData icon,
    String label,
    Color color,
    VoidCallback onTap,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withOpacity(0.1),
        child: Icon(icon, color: color),
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          color: label == 'Log out'
              ? Colors.red
              : (isDark ? Colors.white : Colors.black),
          fontWeight: label == 'Log out' ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: onTap,
    );
  }
}
