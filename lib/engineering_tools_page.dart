import 'package:flutter/material.dart';
import 'engineering_tools_details_page.dart';

class EngineeringToolsPage extends StatelessWidget {
  const EngineeringToolsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final List<Map<String, String>> tools = [
      {
        "title": "Tool Kit Pro",
        "description": "Complete engineering tools set for projects.",
        "price": "25 JD",
        "image": "assets/engineering_tools.png",
        "phone": "+962789123456"
      },
      {
        "title": "Mechanical Set",
        "description": "All essential tools for mechanical engineers.",
        "price": "30 JD",
        "image": "assets/engineering_tools.png",
        "phone": "+962787777777"
      },
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: const Color(0xFF3B3B98),
        title: const Text('Engineering Tools', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[850] : Colors.grey[200],
                borderRadius: BorderRadius.circular(15),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search tools...',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: tools.length,
                itemBuilder: (context, index) {
                  final item = tools[index];
                  return Card(
                    color: isDark ? Colors.grey[900] : Colors.white,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(item["image"]!, width: 60, height: 60, fit: BoxFit.cover),
                      ),
                      title: Text(
                        item["title"]!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        item["description"]!,
                        style: TextStyle(
                          color: isDark ? Colors.white60 : Colors.black54,
                        ),
                      ),
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3B3B98),
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EngineeringToolsDetailsPage(
                                image: item["image"]!,
                                title: item["title"]!,
                                description: item["description"]!,
                                price: item["price"]!,
                                phoneNumber: item["phone"]!,
                              ),
                            ),
                          );
                        },
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
