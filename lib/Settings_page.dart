import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'theme_provider.dart';
import 'profile_page.dart';
import 'terms_conditions_page.dart';
import 'privacy_policy_page.dart';
import 'about_app_page.dart';
// ignore: unused_import
import 'rate_app_page.dart'; // تأكدي أن الملف موجود ومساره صحيح
import 'package:share_plus/share_plus.dart'; // أضف هذا السطر في الأعلى



class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsOn = false;
  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    _loadSettings();
  }

  Future<void> _initializeNotifications() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);
    await _notificationsPlugin.initialize(initSettings);
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      notificationsOn = prefs.getBool('notificationsOn') ?? false;
    });

    if (notificationsOn) {
      _showTestNotification();
    }
  }

  Future<void> _saveNotifications(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notificationsOn', value);
  }

  Future<void> _showTestNotification() async {
    const androidDetails = AndroidNotificationDetails(
      'test_channel_id',
      'Test Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(
      0,
      '🔔 Notifications Enabled',
      'You will now receive app notifications!',
      notificationDetails,
    );
  }

  Future<void> _cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3B3B98),
        centerTitle: true,
        title: const Text('Settings', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // يرجع مباشرة للصفحة السابقة
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ListTile(
            leading: const Icon(Icons.person, color: Colors.green),
            title: const Text('Edit Profile'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfilePage()));
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Text('General Settings', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.brightness_6, color: Colors.orange),
            title: const Text('Mode'),
            subtitle: const Text('Dark & Light'),
            value: themeProvider.isDarkMode,
            onChanged: (val) => themeProvider.toggleTheme(val),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.notifications, color: Colors.amber),
            title: const Text('Notifications'),
            value: notificationsOn,
            onChanged: (val) {
              setState(() {
                notificationsOn = val;
              });

              _saveNotifications(val);

              if (val) {
                _showTestNotification();
              } else {
                _cancelAllNotifications();
              }
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.description, color: Colors.indigo),
            title: const Text('Terms & Conditions'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const TermsAndConditionsPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock, color: Colors.red),
            title: const Text('Privacy Policy'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const PrivacyPolicyPage()));
            },
          ),
          ListTile(
  leading: const Icon(Icons.star, color: Colors.purple),
  title: const Text('Rate This App'),
  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RateAppPage()),
    );
  },
),

          ListTile(
  leading: const Icon(Icons.share, color: Colors.pink),
  title: const Text('Share This App'),
  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
  onTap: () {
    Share.share(
       '\nhttps://JUSTSTORE.com/juststore',
  subject: 'Just Store App 🌟',
    );
  },
),

          ListTile(
            leading: const Icon(Icons.info_outline, color: Colors.teal),
            title: const Text('About'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutAppPage()));
            },
          ),
        ],
      ),
    );
  }
}
