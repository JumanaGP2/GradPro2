import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactInfoPage extends StatefulWidget {
  const ContactInfoPage({super.key});

  @override
  State<ContactInfoPage> createState() => _ContactInfoPageState();
}

class _ContactInfoPageState extends State<ContactInfoPage> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController whatsappController = TextEditingController();
  bool remember = false;

  @override
  void initState() {
    super.initState();
    _loadContactInfo();
  }

  Future<void> _loadContactInfo() async {
    final prefs = await SharedPreferences.getInstance();
    phoneController.text = prefs.getString('phoneNumber') ?? '';
    whatsappController.text = prefs.getString('whatsappNumber') ?? '';
    remember = prefs.getBool('rememberContact') ?? false;
    setState(() {});
  }

  Future<void> _saveContactInfo() async {
    final prefs = await SharedPreferences.getInstance();
    if (remember) {
      await prefs.setString('phoneNumber', phoneController.text);
      await prefs.setString('whatsappNumber', whatsappController.text);
      await prefs.setBool('rememberContact', true);
    } else {
      await prefs.remove('phoneNumber');
      await prefs.remove('whatsappNumber');
      await prefs.setBool('rememberContact', false);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Contact info saved!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3B3B98),
        centerTitle: true,
        title: const Text('Contact Information', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Phone Number',
              style: TextStyle(
                fontSize: 16,
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: '+962-7xxx-xxxx',
                filled: true,
                fillColor: isDark ? Colors.grey[850] : Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: textColor),
            ),
            const SizedBox(height: 20),
            Text(
              'WhatsApp Number',
              style: TextStyle(
                fontSize: 16,
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: whatsappController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: '+962-7xxx-xxxx',
                filled: true,
                fillColor: isDark ? Colors.grey[850] : Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: textColor),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                  value: remember,
                  onChanged: (val) {
                    setState(() {
                      remember = val ?? false;
                    });
                  },
                ),
                Text(
                  'Remember my settings',
                  style: TextStyle(color: textColor),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _saveContactInfo,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B3B98),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                ),
                child: const Text(
                  'Save my information',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
