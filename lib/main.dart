import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'app_text.dart';

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
      home: const LoginScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GREEN CONNECT")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondScreen()),
            );
          },
          child: Text("Go To Next Screen"),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Second Screen")),
      body: Center(
        child: Text("This is second screen", style: TextStyle(fontSize: 20)),
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
        title: const Text("Select Role"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Text("Choose Your Role", style: TextStyle(fontSize: 22)),
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
              child: const Text("Farmer"),
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
              child: const Text("Buyer"),
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
        title: const Text("Buyer Type"),
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
              child: const Text("Household"),
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
              child: const Text("Wholesale"),
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
      ),
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
              tr(context, 'view_Bids'),
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
        title: Text("${tr(context, 'buyer_type')}($type)"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: [
            dashboardItem(context, tr(context, 'search'), Icons.search, () {}),
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
              () {},
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

            if (type == "wholesale")
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
                  builder: (context) =>
                      const BuyerRegisterScreen(type: "household"),
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
                  builder: (context) =>
                      const BuyerRegisterScreen(type: "wholesale"),
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
    ).showSnackBar(const SnackBar(content: Text("Farmer Registered")));

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FarmerDashboard()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr(context, 'farmer_register'))),
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
              decoration: InputDecoration(labelText: tr(context, 'phone_no')),
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
        content: Text("${widget.type} ${tr(context, 'buyer_registerd')}"),
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
      appBar: AppBar(title: Text("${widget.type}${tr(context, 'register')}")),
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
              decoration: InputDecoration(labelText: tr(context, 'phone_no')),
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
  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(tr(context, 'fill_fields'))));
      return;
    }
    productList.add(
      Product(name: name, price: price, quantity: qty, image: _image),
    );

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(tr(context, 'product_added'))));
    nameController.clear();
    priceController.clear();
    quantityController.clear();

    setState(() {
      _image = null;
    });
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
                          Icon(Icons.camera_alt, size: 50),
                          SizedBox(height: 10),
                          Text(tr(context, 'upload_image')),
                        ],
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.file(_image!, fit: BoxFit.cover),
                      ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: tr(context, 'product_name'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 15),
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
                  style: TextStyle(fontSize: 16),
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
              child: Text(
                tr(context, 'no_product'),
                style: TextStyle(fontSize: 16),
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
          ? Center(child: Text(tr(context, 'no_order')))
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
                        order.status = tr(context, 'delevierd');
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
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'buyer_demand')),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.show_chart, size: 80, color: Colors.grey),

            SizedBox(height: 20),

            Text(
              tr(context, 'no_demands_yet'),
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),

            SizedBox(height: 10),

            Text(tr(context, 'you_see'), style: TextStyle(color: Colors.grey)),
          ],
        ),
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
                  ? Center(child: Text(tr(context, 'no_list')))
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
      appBar: AppBar(title: const Text("Recent Orders")),
      body: ListView(
        children: const [
          ListTile(
            title: Text("Tomatoes"),
            subtitle: Text("Ordered by Buyer A"),
          ),
          ListTile(
            title: Text("Potatoes"),
            subtitle: Text("Ordered by Buyer B"),
          ),
        ],
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
          ? Center(child: Text(tr(context, 'no_product')))
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
              child: Text(
                tr(context, 'no_product'),
                style: TextStyle(fontSize: 18),
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
          ? Center(child: Text(tr(context, 'cart_is_empty')))
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
                              buyerName: "Ram",
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
          ? Center(child: Text(tr(context, 'no_order')))
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
              child: Text(
                tr(context, 'no_bids_yet'),
                style: TextStyle(fontSize: 16),
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
        title: Text(tr(context, 'market_my_bids')),
        backgroundColor: Colors.orange,
      ),

      body: Column(
        children: [
          /// 🔹 MARKET PRODUCTS
          Expanded(
            child: marketList.isEmpty
                ? Center(child: Text(tr(context, 'no_market_product')))
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
                ? Center(child: Text(tr(context, 'no_bids_yet')))
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
