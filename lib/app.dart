import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const GreenConnectApp());
}

class GreenConnectApp extends StatelessWidget {
  const GreenConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Green Connect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
        // Pleasant mint-green background
        scaffoldBackgroundColor: const Color(0xFFE8F5E9), 
      ),
      home: const LoginPage(),
    );
  }
}

// --- 1. LOGIN PAGE ---
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  void _handleLogin() {
    String phone = _phoneController.text;
    // Regex ensures first digit is 6, 7, 8, or 9 for Indian mobile standards
    bool isValidIndianPrefix = RegExp(r'^[6-9]').hasMatch(phone);

    if (phone.length == 10 && isValidIndianPrefix && _passController.text.isNotEmpty) {
      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => const LanguagePage())
      );
    } else {
      // Descriptive error messages based on what is missing
      String msg = (phone.length == 10 && isValidIndianPrefix) 
          ? "Please enter your password" 
          : "Enter a valid 10-digit mobile number starting with 6-9";
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg), 
          backgroundColor: const Color.fromARGB(255, 32, 170, 57),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            // Fixed: maxWidth nested inside BoxConstraints
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Clean branding without redundant text
                Image.asset('lib/assets/logo.png', height: 160), 
                const SizedBox(height: 10),
                const Text(
                  "Farm to Family",
                  style: TextStyle(
                    fontSize: 22, 
                    color: Color.fromARGB(255, 16, 93, 21), // Dark Forest Green
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic
                  ),
                ),
                const SizedBox(height: 40),
                
                // Mobile Number Input
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.phone, color: Colors.green),
                    prefixText: '+91 ', 
                    prefixStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    labelText: 'Mobile Number',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                
                // Password Input
                TextField(
                  controller: _passController,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock, color: Colors.green),
                    labelText: 'Password',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                
                // Login Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[700],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    onPressed: _handleLogin, // Triggers validation logic
                    child: const Text("LOGIN", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- 2. LANGUAGE SELECTION PAGE ---
class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Language"),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _langTile(context, "English", "🌍"),
          _langTile(context, "Hindi", "🚜"),
          _langTile(context, "Tamil", "🌿"),
          _langTile(context, "Telugu", "🌾"),
          _langTile(context, "Kannada", "🍏"),
        ],
      ),
    );
  }

  Widget _langTile(BuildContext context, String lang, String icon) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Text(icon, style: const TextStyle(fontSize: 24)),
        title: Text(lang, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.green),
        onTap: () => Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => RoleSelectionPage(language: lang))
        ),
      ),
    );
  }
}

// --- 3. ROLE SELECTION PAGE ---
class RoleSelectionPage extends StatelessWidget {
  final String language;
  const RoleSelectionPage({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    final Map<String, Map<String, String>> labels = {
      'English': {'title': 'Who are you?', 'farmer': 'Farmer', 'buyer': 'Buyer', 'back': 'Back to Login'},
      'Hindi': {'title': 'आप कौन हैं?', 'farmer': 'किसान', 'buyer': 'खरीददार', 'back': 'लॉगिन पर वापस जाएं'},
      'Tamil': {'title': 'நீங்கள் யார்?', 'farmer': 'விவசாயி', 'buyer': 'வாங்குபவர்', 'back': 'உள்நுழைவுக்குத் திரும்பு'},
      'Telugu': {'title': 'మీరు ఎవరు?', 'farmer': 'రైతు', 'buyer': 'కొనుగోలుదారు', 'back': 'లాగిన్‌కి తిరిగి వెళ్లండి'},
      'Kannada': {'title': 'ನೀವು ಯಾರು?', 'farmer': 'ರೈತ', 'buyer': 'ಖರೀದಿದಾರ', 'back': 'ಲಾಗಿನ್‌ಗೆ ಹಿಂತಿರುಗಿ'},
    };

    var text = labels[language] ?? labels['English']!;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Fixed lowercase
            children: [
              Text(
                text['title']!, 
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.green[900])
              ),
              const SizedBox(height: 50),
              
              _roleButton(text['farmer']!, Icons.agriculture, Colors.green),
              const SizedBox(height: 25),
              _roleButton(text['buyer']!, Icons.shopping_basket, Colors.brown),
              
              const SizedBox(height: 60),
              
              TextButton.icon(
                onPressed: () => Navigator.pushAndRemoveUntil(
                  context, 
                  MaterialPageRoute(builder: (context) => const LoginPage()), 
                  (route) => false
                ),
                icon: const Icon(Icons.logout, color: Colors.grey),
                label: Text(text['back']!, style: const TextStyle(color: Colors.grey, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _roleButton(String title, IconData icon, Color color) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 320),
      height: 110,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          // Fixed: .withValues(alpha: 0.1) replaces deprecated .withOpacity
          BoxShadow(color: color.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 5))
        ],
        border: Border.all(color: color, width: 2),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 45, color: color),
              const SizedBox(width: 20),
              Text(title, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: color)),
            ],
          ),
        ),
      ),
    );
  }
}