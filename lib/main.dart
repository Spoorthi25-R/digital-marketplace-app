import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'app_text.dart';
import 'screens/price_prediction_screen.dart';
import 'package:url_launcher/url_launcher.dart';

String tr(BuildContext context, String key) {
  String lang = Localizations.localeOf(context).languageCode;
  return AppText.translations[lang]?[key] ?? key;
}

String? userRole;

class MarketItem {
  String productName;
  String price;
  MarketItem({required this.productName, required this.price});
}

List<MarketItem> marketList = [];

class Bid {
  String productName;
  String buyerName;
  String price;

  Bid({
    required this.productName,
    required this.buyerName,
    required this.price,
  });
}

List<Bid> bidList = [];

class Product {
  String name;
  String price;
  String quantity;
  String buyerName;
  String status;
  int cartQty;
  File? image;

  Product({
    required this.name,
    required this.price,
    required this.quantity,
    this.buyerName = "",
    this.status = "Pending",
    this.cartQty = 1,
    this.image,
  });
}

class Order {
  String productName;
  String buyerName;
  Order({required this.productName, required this.buyerName});
}

List<Map<String, String>> orderlist = [];
List<Product> orderList = [];
List<Product> cartList = [];
List<Product> productList = [];
List<Order> orderList1 = [];
final products = productList;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static _MyAppState? of(BuildContext context) {
    return context.findAncestorStateOfType<_MyAppState>();
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en');

  void changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: _locale,
      supportedLocales: const [
        Locale('en'),
        Locale('kn'),
        Locale('hi'),
        Locale('te'),
        Locale('ta'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    /// FADE ANIMATION
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);

    _controller.forward();

    /// MOVE TO LOGIN SCREEN
    Future.delayed(const Duration(seconds: 10), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// LOGO
              Image.asset(
                'assets/logo.png',
                height: 190,
                width: 190,
              ),

              const SizedBox(height: 20),

              /// APP NAME

              const SizedBox(height: 10),

              /// CAPTION
              const Text(
                "Farm to Family",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black54,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    String email = emailController.text;
    String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      showMessage("Please fill all fields");
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RoleSelectionScreen()),
      );
    }
  }

  void showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Login",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: login,
                child: const Text("Login"),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LanguageSelectionScreen(),
                  ),
                );
              },
              child: const Text("New user? Register"),
            ),
          ],
        ),
      ),
    );
  }
}

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'select_role')),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Text(
              tr(context, 'choose_your_role'),
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FarmerRegisterScreen(),
                  ),
                );
              },
              child: Text(tr(context, 'farmer')),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BuyerTypeRegisterScreen(),
                  ),
                );
              },
              child: Text(tr(context, 'buyer')),
            ),
          ],
        ),
      ),
    );
  }
}

class BuyerTypeScreen extends StatelessWidget {
  const BuyerTypeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'buyer_type')),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const BuyerDashboard(type: "household"),
                  ),
                );
              },
              child: Text(tr(context, 'household')),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const BuyerDashboard(type: "wholesale"),
                  ),
                );
              },
              child: Text(tr(context, 'wholesale')),
            ),
          ],
        ),
      ),
    );
  }
}

class FarmerDashboard extends StatelessWidget {
  const FarmerDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(tr(context, "farmer_dashboard")),
          backgroundColor: Colors.green,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
            ),
          ]),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: [
            dashboardItem(
              context,
              tr(context, 'add_product'),
              Icons.add,
              Colors.green,
              const AddProductScreen(),
            ),
            dashboardItem(
              context,
              tr(context, 'my_product'),
              Icons.inventory,
              Colors.blue,
              const ProductListScreen(),
            ),
            dashboardItem(
              context,
              tr(context, 'orders_received'),
              Icons.shopping_cart,
              Colors.orange,
              const OrderScreen(),
            ),
            dashboardItem(
              context,
              tr(context, 'buyer_demand'),
              Icons.show_chart,
              Colors.purple,
              const DemandScreen(),
            ),
            dashboardItem(
              context,
              tr(context, 'sell_market'),
              Icons.store,
              Colors.teal,
              const MarketScreen(),
            ),
            dashboardItem(
              context,
              tr(context, 'view_bids'),
              Icons.gavel,
              Colors.green,
              const ViewBidsScreen(),
            ),
            dashboardItem(
              context,
              tr(context, 'recent_orders'),
              Icons.history,
              Colors.red,
              const RecentOrderScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget dashboardItem(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    Widget screen,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 10),
            Text(title, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class BuyerDashboard extends StatelessWidget {
  final String type; // "household" or "wholesale"

  const BuyerDashboard({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${tr(context, 'buyer_type')}(${tr(context, type)})"),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: [
            dashboardItem(context, tr(context, 'search'), Icons.search, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            }),
            dashboardItem(
              context,
              tr(context, 'browse_product'),
              Icons.store,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BrowseProductsScreen(),
                  ),
                );
              },
            ),
            dashboardItem(
              context,
              tr(context, 'my_order'),
              Icons.shopping_bag,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyOrderScreen(),
                  ),
                );
              },
            ),
            dashboardItem(
              context,
              tr(context, 'demand_alert'),
              Icons.notifications,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DemandAlertScreen(),
                  ),
                );
              },
            ),
            dashboardItem(
              context,
              tr(context, 'my_cart'),
              Icons.shopping_cart,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartScreen()),
                );
              },
            ),
            if (type.toLowerCase() == "wholesale")
              dashboardItem(context, tr(context, 'my_bid'), Icons.gavel, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyBidScreen()),
                );
              }),
          ],
        ),
      ),
    );
  }

  Widget dashboardItem(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.orange.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.orange),
            const SizedBox(height: 10),
            Text(title, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void register() {
    String name = nameController.text;
    String phone = phoneController.text;
    String email = emailController.text;
    String password = passwordController.text;

    if (name.isEmpty || phone.isEmpty || email.isEmpty || password.isEmpty) {
      showMessage("Fill all Fields");
    } else {
      showMessage("Registered Successfully");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RoleSelectionScreen()),
      );
    }
  }

  void showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'register')),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: tr(context, 'name')),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: tr(context, 'email')),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: tr(context, 'password')),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: register,
                child: Text(tr(context, 'register')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterRoleScreen extends StatelessWidget {
  const RegisterRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register As"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FarmerRegisterScreen(),
                  ),
                );
              },
              child: const Text("Farmer 🌾"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BuyerTypeRegisterScreen(),
                  ),
                );
              },
              child: const Text("Buyer 🛒"),
            ),
          ],
        ),
      ),
    );
  }
}

class BuyerTypeRegisterScreen extends StatelessWidget {
  const BuyerTypeRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'buyer_type')),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BuyerRegisterScreen(type: "household"),
                ),
              );
            },
            child: Text("${tr(context, 'household')} 🏠"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BuyerRegisterScreen(type: "wholesale"),
                ),
              );
            },
            child: Text("${tr(context, 'wholesale')} 🏪"),
          ),
        ],
      ),
    );
  }
}

class FarmerRegisterScreen extends StatefulWidget {
  const FarmerRegisterScreen({super.key});

  @override
  State<FarmerRegisterScreen> createState() => _FarmerRegisterScreenState();
}

class _FarmerRegisterScreenState extends State<FarmerRegisterScreen> {
  final nameController = TextEditingController();
  final farmController = TextEditingController();
  final phoneController = TextEditingController();
  final locationController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void register() {
    userRole = "farmer";
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(tr(context, 'farmers_register'))));

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FarmerDashboard()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr(context, 'farmers_register'))),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: tr(context, 'name')),
            ),
            TextField(
              controller: farmController,
              decoration: InputDecoration(
                labelText: tr(context, 'farm_location'),
              ),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: tr(context, 'phone_number'),
              ),
            ),
            TextField(
              controller: locationController,
              decoration: InputDecoration(labelText: tr(context, 'location')),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: tr(context, 'email')),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: tr(context, 'password')),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: register,
              child: Text(tr(context, 'register')),
            ),
          ],
        ),
      ),
    );
  }
}

class BuyerRegisterScreen extends StatefulWidget {
  final String type;

  const BuyerRegisterScreen({super.key, required this.type});

  @override
  State<BuyerRegisterScreen> createState() => _BuyerRegisterScreenState();
}

class _BuyerRegisterScreenState extends State<BuyerRegisterScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void register() {
    userRole = "buyer";
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${widget.type}   ${tr(context, 'buyer_registerd')}"),
      ),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BuyerDashboard(type: widget.type),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.type} ${tr(context, 'register')}")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: tr(context, 'name')),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: tr(context, 'phone_number'),
              ),
            ),
            TextField(
              controller: addressController,
              decoration: InputDecoration(labelText: tr(context, 'address')),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: tr(context, 'email')),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: tr(context, 'password')),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: register,
              child: Text(tr(context, 'register')),
            ),
          ],
        ),
      ),
    );
  }
}

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();

  File? _image;
  String? selectedCrop;

  List<String> cropList = [
    'rice',
    'wheat',
    'tomato',
    'onion',
    'potato',
    'carrot',
    'cabbage',
    'corn',
    'sugarcane',
    'cotton',
    'banana',
    'mango',
  ];

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
    }
  }

  void addProduct() {
    String name = nameController.text.trim();
    String price = priceController.text.trim();
    String qty = quantityController.text.trim();

    if (name.isEmpty || price.isEmpty || qty.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(tr(context, 'fill_fields')),
        ),
      );
      return;
    }

    productList.add(
      Product(
        name: name,
        price: price,
        quantity: qty,
        image: _image,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(tr(context, 'product_added')),
      ),
    );

    nameController.clear();
    priceController.clear();
    quantityController.clear();

    setState(() {
      _image = null;
    });
  }

  /// OPEN SMART PRICE PREDICTION WEBPAGE
  void openPricePrediction() async {
    final Uri url = Uri.parse("http://127.0.0.1:5000");

    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        webOnlyWindowName: "_blank",
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Could not open Smart Price Prediction"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'add_product')),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            /// IMAGE PICKER
            GestureDetector(
              onTap: pickImage,
              child: Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.green),
                ),
                child: _image == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.camera_alt,
                            size: 50,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            tr(context, 'upload_image'),
                          ),
                        ],
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.file(
                          _image!,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 20),

            /// SMART PRICE PREDICTION BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: openPricePrediction,
                icon: const Icon(Icons.show_chart),
                label: Text(
                  tr(context, 'smart_price_prediction'),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// PRODUCT NAME
            DropdownButtonFormField<String>(
              value: selectedCrop,
              decoration: InputDecoration(
                labelText: tr(context, 'select_crop'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: cropList.map((crop) {
                return DropdownMenuItem(
                  value: crop,
                  child: Text(
                    tr(context, crop),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCrop = value;
                  nameController.text = value!;
                });
              },
            ),

            const SizedBox(height: 15),

            /// PRICE
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: tr(context, 'price'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 15),

            /// QUANTITY
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: tr(context, 'quantity'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 25),

            /// ADD PRODUCT BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: addProduct,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  tr(context, 'add_product'),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'my_product')),
        backgroundColor: Colors.green,
      ),
      body: productList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 90,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 15),
                  Text(
                    tr(context, 'no_products'),
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: productList.length,
              itemBuilder: (context, index) {
                final product = productList[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(15),
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: product.image != null
                              ? Image.file(
                                  product.image!,
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  height: 80,
                                  width: 80,
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.image),
                                ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text("${tr(context, 'price')}:${product.price}"),
                              Text(
                                "${tr(context, 'quantity')} : ${product.quantity}",
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            productList.removeAt(index);
                            (context as Element).markNeedsBuild();
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'order_received')),
        backgroundColor: Colors.orange,
      ),
      body: orderList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 90,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 15),
                  Text(
                    tr(context, 'no_order'),
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: orderList.length,
              itemBuilder: (context, index) {
                final order = orderList[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(order.name),
                    subtitle: Text(
                      "${order.price} |${tr(context, 'quantity')} :${order.quantity}\n${tr(context, 'buyer')}:${order.buyerName}\n${tr(context, 'status')}:${order.status}",
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        order.status = tr(context, 'delivered');
                      },
                      child: Text(tr(context, 'mark_delivered')),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class DemandScreen extends StatelessWidget {
  const DemandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, int> demandCount = {};

    // Count product orders
    for (var order in orderList) {
      if (demandCount.containsKey(order.name)) {
        demandCount[order.name] = demandCount[order.name]! + 1;
      } else {
        demandCount[order.name] = 1;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'buyer_demand')),
        backgroundColor: Colors.green,
      ),
      body: demandCount.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.trending_up,
                    size: 90,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 15),
                  Text(
                    tr(context, 'no_demand_yet'),
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: demandCount.length,
              itemBuilder: (context, index) {
                String productName = demandCount.keys.elementAt(index);

                int count = demandCount[productName]!;

                return Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.trending_up,
                      color: Colors.green,
                      size: 35,
                    ),
                    title: Text(
                      productName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      "$count ${tr(context, 'buyers_ordered_this_product')}",
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        tr(context, 'high_demand'),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  final priceController = TextEditingController();
  Product? selectedProduct;

  void addToMarket() {
    if (selectedProduct == null || priceController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(tr(context, 'select'))));
      return;
    }

    marketList.add(
      MarketItem(
        productName: selectedProduct!.name,
        price: priceController.text,
      ),
    );

    priceController.clear();
    setState(() {
      selectedProduct = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'sell_market')),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            /// SELECT PRODUCT
            DropdownButtonFormField<Product>(
              value: selectedProduct,
              hint: Text(tr(context, 'select_product')),
              initialValue: selectedProduct,
              items: productList.map((product) {
                return DropdownMenuItem(
                  value: product,
                  child: Text(product.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedProduct = value;
                });
              },
            ),

            const SizedBox(height: 15),

            /// PRICE INPUT
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: tr(context, 'enter_price'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 15),

            /// ADD BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: addToMarket,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: Text(tr(context, 'sell_now')),
              ),
            ),

            const SizedBox(height: 20),

            /// MARKET LIST
            Expanded(
              child: marketList.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.inventory_2_outlined,
                            size: 90,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 15),
                          Text(
                            tr(context, 'no_products'),
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: marketList.length,
                      itemBuilder: (context, index) {
                        final item = marketList[index];

                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.store),
                            title: Text(item.productName),
                            subtitle: Text(
                              "${tr(context, 'price')}: ₹${item.price}",
                            ),
                            trailing: const Icon(Icons.chevron_right),
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

class RecentOrderScreen extends StatelessWidget {
  const RecentOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'recent_orders')),
        backgroundColor: Colors.green,
      ),
      body: orderList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 90,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 15),
                  Text(
                    tr(context, 'no_order'),
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: orderList.length,
              itemBuilder: (context, index) {
                final order = orderList[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.shopping_bag,
                      color: Colors.green,
                    ),
                    title: Text(
                      order.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "${tr(context, 'buyer')}: ${order.buyerName}\n"
                      "${tr(context, 'quantity')}: ${order.quantity}\n"
                      "${tr(context, 'price')}: ₹${order.price}\n"
                      "${tr(context, 'status')}: ${order.status}",
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class BuyerProductsScreen extends StatelessWidget {
  const BuyerProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'available_product')),
        backgroundColor: Colors.orange,
      ),
      body: productList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 90,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 15),
                  Text(
                    tr(context, 'no_products'),
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: productList.length,
              itemBuilder: (context, index) {
                final product = productList[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(product.name),
                    subtitle: Text(
                      "${tr(context, 'price')}: ₹${product.price} | ${tr(context, 'quantity')}: ${product.quantity} ${tr(context, 'kg')}",
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "${product.name} ${tr(context, 'order_successfully')}",
                            ),
                          ),
                        );
                      },
                      child: Text(tr(context, 'buy')),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class BrowseProductsScreen extends StatelessWidget {
  const BrowseProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'browse_product')),
        backgroundColor: Colors.orange,
      ),
      body: productList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 90,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 15),
                  Text(
                    tr(context, 'no_products'),
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: productList.length,
              itemBuilder: (context, index) {
                final product = productList[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 4,
                  child: ListTile(
                    leading: product.image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              product.image!,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(Icons.image, size: 50),
                    title: Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "${tr(context, 'price')}: ₹${product.price} | ${tr(context, 'quantity')}: ${product.quantity}",
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.add_shopping_cart,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        product.cartQty = 1;
                        cartList.add(product);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "${product.name} ${tr(context, 'added_to_cart')}",
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'my_cart')),
        backgroundColor: Colors.orange,
      ),
      body: cartList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 90,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 15),
                  Text(
                    tr(context, 'cart_is_empty'),
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartList.length,
                    itemBuilder: (context, index) {
                      final product = cartList[index];
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          title: Text(product.name),
                          subtitle: Text(
                            "${product.price}${tr(context, 'quantity')}:${product.quantity}",
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  int qty = int.parse(
                                    product.quantity.replaceAll("kg", ""),
                                  );
                                  if (qty > 1) qty--;
                                  product.quantity = "${qty}kg";
                                  (context as Element).markNeedsBuild();
                                },
                              ),
                              Text(product.quantity),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  int qty = int.parse(
                                    product.quantity.replaceAll("kg", ""),
                                  );
                                  qty++;
                                  product.quantity = "${qty}kg";
                                  (context as Element).markNeedsBuild();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsGeometry.all(15),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        for (var item in cartList) {
                          orderList.add(
                            Product(
                              name: item.name,
                              price: item.price,
                              quantity: item.quantity,
                              buyerName: tr(context, 'ram'),
                            ),
                          );
                        }
                        cartList.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(tr(context, 'order_placed'))),
                        );
                      },
                      child: Text(tr(context, 'place_order')),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'my_order')),
        backgroundColor: Colors.orange,
      ),
      body: orderList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 90,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 15),
                  Text(
                    tr(context, 'no_order'),
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: orderList.length,
              itemBuilder: (context, index) {
                final product = orderList[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(product.name),
                    subtitle: Text(
                      "${product.price} |${tr(context, 'quantity')}:${product.quantity}",
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class BidDialog extends StatefulWidget {
  final String productName;

  const BidDialog({super.key, required this.productName});

  @override
  State<BidDialog> createState() => _BidDialogState();
}

class _BidDialogState extends State<BidDialog> {
  final priceController = TextEditingController();

  void submitBid() {
    if (priceController.text.isEmpty) return;

    bidList.add(
      Bid(
        productName: widget.productName,
        buyerName: tr(context, 'buyer'), // you can improve later
        price: priceController.text,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("${tr(context, 'place_bid')} - ${widget.productName}"),
      content: TextField(
        controller: priceController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: tr(context, 'enter_bid')),
      ),
      actions: [
        TextButton(onPressed: submitBid, child: Text(tr(context, 'submit'))),
      ],
    );
  }
}

class ViewBidsScreen extends StatefulWidget {
  const ViewBidsScreen({super.key});

  @override
  State<ViewBidsScreen> createState() => _ViewBidsScreenState();
}

class _ViewBidsScreenState extends State<ViewBidsScreen> {
  void acceptBid(int index) {
    final acceptedBid = bidList[index];

    setState(() {
      bidList.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "${tr(context, 'accepted')} ₹${acceptedBid.price} ${tr(context, 'for')} ${acceptedBid.productName}",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'bids_received')),
        backgroundColor: Colors.green,
      ),
      body: bidList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 90,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 15),
                  Text(
                    tr(context, 'no_bids_yet'),
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: bidList.length,
              itemBuilder: (context, index) {
                final bid = bidList[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.gavel,
                      color: Colors.green,
                      size: 30,
                    ),
                    title: Text(
                      bid.productName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${tr(context, 'buyer')}: ${bid.buyerName}"),
                        Text("${tr(context, 'bid_price')}: ₹${bid.price}"),
                      ],
                    ),
                    trailing: ElevatedButton(
                      onPressed: () => acceptBid(index),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: Text(tr(context, 'bid_price')),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class MyBidScreen extends StatefulWidget {
  const MyBidScreen({super.key});

  @override
  State<MyBidScreen> createState() => _MyBidScreenState();
}

class _MyBidScreenState extends State<MyBidScreen> {
  void openBidDialog(String productName) {
    TextEditingController bidController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("${tr(context, 'bid_for')} $productName"),
          content: TextField(
            controller: bidController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: tr(context, 'enter_bid_price'),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(tr(context, 'cancle')),
            ),
            ElevatedButton(
              onPressed: () {
                if (bidController.text.isEmpty) return;

                bidList.add(
                  Bid(
                    productName: productName,
                    buyerName: tr(context, 'buyer'),
                    price: bidController.text,
                  ),
                );

                Navigator.pop(context);
                setState(() {}); // refresh UI

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(tr(context, 'bid_placed_successfully')),
                  ),
                );
              },
              child: Text(tr(context, 'submit')),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'market_and_my_bids')),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          /// 🔹 MARKET PRODUCTS
          Expanded(
            child: marketList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inventory_2_outlined,
                          size: 90,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 15),
                        Text(
                          tr(context, 'no_market_product_available'),
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: marketList.length,
                    itemBuilder: (context, index) {
                      final item = marketList[index];

                      return Card(
                        margin: const EdgeInsets.all(8),
                        child: ListTile(
                          title: Text(item.productName),
                          subtitle: Text(
                            "${tr(context, 'base_price')}: ₹${item.price}",
                          ),
                          trailing: ElevatedButton(
                            onPressed: () => openBidDialog(item.productName),
                            child: Text(tr(context, 'make_bid')),
                          ),
                        ),
                      );
                    },
                  ),
          ),

          const Divider(),

          /// 🔹 MY BIDS SECTION
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              tr(context, 'my_bid'),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          Expanded(
            child: bidList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.gavel_outlined,
                          size: 90,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 15),
                        Text(
                          tr(context, 'no_bids_yet'),
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: bidList.length,
                    itemBuilder: (context, index) {
                      final bid = bidList[index];

                      return Card(
                        margin: const EdgeInsets.all(8),
                        child: ListTile(
                          leading: const Icon(
                            Icons.gavel,
                            color: Colors.orange,
                          ),
                          title: Text(bid.productName),
                          subtitle: Text(
                            "${tr(context, 'bid_price')}: ₹${bid.price}",
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  void changeAppLanguage(BuildContext context, String languageCode) {
    MyApp.of(context)?.changeLanguage(Locale(languageCode));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const RoleSelectionScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: Text(
          AppText.translations[Localizations.localeOf(
                context,
              ).languageCode]?['select_language'] ??
              "Select Language",
        ),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => changeAppLanguage(context, 'en'),
                child: const Text("English"),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => changeAppLanguage(context, 'kn'),
                child: const Text("ಕನ್ನಡ"),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => changeAppLanguage(context, 'hi'),
                child: const Text("हिन्दी"),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => changeAppLanguage(context, 'te'),
                child: const Text("తెలుగు"),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => changeAppLanguage(context, 'ta'),
                child: const Text("தமிழ்"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DemandAlertScreen extends StatelessWidget {
  const DemandAlertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, int> demandMap = {};

    // Count orders
    for (var order in orderList) {
      if (demandMap.containsKey(order.name)) {
        demandMap[order.name] = demandMap[order.name]! + 1;
      } else {
        demandMap[order.name] = 1;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'demand_alert')),
        backgroundColor: Colors.orange,
      ),
      body: demandMap.isEmpty
          ? Center(
              child: Text(
                tr(context, 'no_demand_alert'),
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: demandMap.length,
              itemBuilder: (context, index) {
                String product = demandMap.keys.elementAt(index);

                int count = demandMap[product]!;

                return Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.notifications_active,
                      color: Colors.orange,
                      size: 35,
                    ),
                    title: Text(
                      product,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text("$count ${tr(context, 'recent_orders')}"),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        tr(context, 'trending'),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();

  List<Product> filteredProducts = productList;

  void searchProduct(String value) {
    setState(() {
      filteredProducts = productList
          .where(
            (product) =>
                product.name.toLowerCase().contains(value.toLowerCase()),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'search')),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: searchController,
              onChanged: searchProduct,
              decoration: InputDecoration(
                hintText: "${tr(context, 'search')}",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: filteredProducts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inventory_2_outlined,
                          size: 90,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 15),
                        Text(
                          tr(context, 'no_products'),
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];

                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          leading: product.image != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    product.image!,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const Icon(Icons.image),
                          title: Text(product.name),
                          subtitle: Text(
                            "₹${product.price} | ${tr(context, 'quantity')}: ${product.quantity}",
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
