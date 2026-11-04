import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  runApp(const MyApp());
}

const navy = Color(0xFF172554);
const gold = Color(0xFFF5B942);

class Contact {
  String name, phone, email, category;
  DateTime date;

  Contact(this.name, this.phone, this.email, this.category, this.date);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: navy),
        scaffoldBackgroundColor: const Color(0xFFF4F6FA),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  String? selectedCategory;

  final categories = ['Keluarga', 'Teman', 'Kerja'];

  // Replaced Faker with dummy data
  final List<Contact> contacts = [
    Contact("Budi Santoso", "08123456789", "budi@mail.com", "Keluarga", DateTime.now()),
    Contact("Siti Aminah", "08198765432", "siti@mail.com", "Teman", DateTime.now()),
    Contact("Andi Wijaya", "08111222333", "andi@mail.com", "Kerja", DateTime.now()),
  ];

  String dateFormat(DateTime date) {
    return DateFormat('dd MMMM yyyy', 'id_ID').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          contactPage(),
          searchPage(),
          profilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: navy,
        selectedItemColor: gold,
        unselectedItemColor: Colors.white,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.contacts), label: 'Kontak'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Cari'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }

  Widget contactPage() {
    return SafeArea(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(color: navy, borderRadius: BorderRadius.vertical(bottom: Radius.circular(25))),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Selamat Datang!', style: TextStyle(color: Colors.white70)),
                SizedBox(height: 8),
                Text('Daftar Kontak', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: contacts.length,
              itemBuilder: (context, i) {
                final c = contacts[i];
                return Card(
                  child: ListTile(
                    title: Text(c.name),
                    subtitle: Text('${c.phone}\n${c.email}'),
                    isThreeLine: true,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget searchPage() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          DropdownButtonFormField<String>(
            value: selectedCategory,
            hint: const Text('Pilih Kategori'),
            items: categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
            onChanged: (val) => setState(() => selectedCategory = val),
          ),
        ],
      ),
    );
  }

  Widget profilePage() {
    return const Center(child: CircleAvatar(radius: 65, backgroundColor: navy, child: Icon(Icons.person, size: 75, color: gold)));
  }
}
