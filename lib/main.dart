import 'package:flutter/material.dart';

String? userRole;

class Product {
  String name;
  String price;
  String quantity;
  String buyerName;
  String status;
  int cartQty;

  Product({
    required this.name,
    required this.price,
    required this.quantity,
    this.buyerName = "",
    this.status = "Pending",
    this.cartQty = 1,
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
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
                    builder: (context) => const RegisterRoleScreen(),
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
        title: const Text("Farmer Dashboard"),
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
              "Add Product",
              Icons.add,
              Colors.green,
              const AddProductScreen(),
            ),
            dashboardItem(
              context,
              "My Product",
              Icons.inventory,
              Colors.blue,
              const ProductListScreen(),
            ),
            dashboardItem(
              context,
              "Orders Received",
              Icons.shopping_cart,
              Colors.orange,
              const OrderScreen(),
            ),
            dashboardItem(
              context,
              "Buyer Demand",
              Icons.show_chart,
              Colors.purple,
              const DemandScreen(),
            ),
            dashboardItem(
              context,
              "Sell Directly To Market",
              Icons.store,
              Colors.teal,
              const MarketScreen(),
            ),
            dashboardItem(
              context,
              "Recent Orders",
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
        title: Text("Buyer Dashboard ($type)"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: [
            dashboardItem(context, "Search", Icons.search, () {}),
            dashboardItem(context, "Browse Products", Icons.store, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BrowseProductsScreen(),
                ),
              );
            }),
            dashboardItem(context, "My Orders", Icons.shopping_bag, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyOrderScreen()),
              );
            }),
            dashboardItem(context, "Demand Alert", Icons.notifications, () {}),
            dashboardItem(context, "My Cart", Icons.shopping_cart, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            }),

            if (type == "wholesale")
              dashboardItem(context, "My Bid", Icons.gavel, () {}),
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
        title: const Text("Register"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Full Name"),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: register,
                child: const Text("Register"),
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
        title: const Text("Buyer Type"),
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
            child: const Text("Household 🏠"),
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
            child: const Text("Wholesale 🏪"),
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
      appBar: AppBar(title: const Text("Farmer Register")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),

            TextField(
              controller: farmController,
              decoration: const InputDecoration(labelText: "Farm Location"),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: "Phone Number"),
            ),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(labelText: "Location"),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: "Password"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(onPressed: register, child: const Text("Register")),
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
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("${widget.type} Buyer Registered")));

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
      appBar: AppBar(title: Text("${widget.type} Register")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: "Phone Number"),
            ),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(labelText: "Address"),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: "Password"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(onPressed: register, child: const Text("Register")),
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

  void addProduct() {
    String name = nameController.text.trim();
    String price = priceController.text.trim();
    String qty = quantityController.text.trim();

    if (name.isEmpty || price.isEmpty || qty.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please Fill all fields")));
      return;
    }
    productList.add(Product(name: name, price: price, quantity: qty));

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Product Added Successfully")));
    nameController.clear();
    priceController.clear();
    quantityController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Product Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Price",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Quantity",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
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
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  "Add Product",
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
      appBar: AppBar(title: const Text("My Product")),
      body: productList.isEmpty
          ? const Center(child: Text("No Products Added"))
          : ListView.builder(
              itemCount: productList.length,
              itemBuilder: (context, index) {
                final product = productList[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.shopping_bag,
                      color: Colors.green,
                    ),
                    title: Text(
                      product.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    subtitle: Text(
                      "Price:${product.price} | Qty:${product.quantity}",
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
        title: const Text("Order Received"),
        backgroundColor: Colors.orange,
      ),
      body: orderList.isEmpty
          ? const Center(child: Text("No orders yet"))
          : ListView.builder(
              itemCount: orderList.length,
              itemBuilder: (context, index) {
                final order = orderList[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(order.name),
                    subtitle: Text(
                      "${order.price} | Qty: ${order.quantity}\nBuyer:${order.buyerName}\nStatus:${order.status}",
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        order.status = "Delivered";
                      },
                      child: Text("Mark Delivered"),
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
      appBar: AppBar(title: const Text("Buyer OrderDemand")),
      body: const Center(child: Text("No Demand data yet")),
    );
  }
}

class MarketScreen extends StatelessWidget {
  const MarketScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sell to Market")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Sent to Market")));
          },
          child: const Text("Sell Remaining Stock"),
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
        title: const Text("Available Products"),
        backgroundColor: Colors.orange,
      ),
      body: productList.isEmpty
          ? const Center(child: Text("No products available"))
          : ListView.builder(
              itemCount: productList.length,
              itemBuilder: (context, index) {
                final product = productList[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(product.name),
                    subtitle: Text(
                      "Price: ₹${product.price} | Qty: ${product.quantity} kg",
                    ),

                    trailing: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "${product.name} ordered successfully",
                            ),
                          ),
                        );
                      },
                      child: const Text("Buy"),
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
        title: const Text("Browse Products"),
        backgroundColor: Colors.orange,
      ),
      body: productList.isEmpty
          ? const Center(
              child: Text(
                "No products available",
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
                      "Price: ₹${product.price} | Qty: ${product.quantity}",
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
                            content: Text("${product.name} added to cart"),
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
        title: const Text("My Cart"),
        backgroundColor: Colors.orange,
      ),
      body: cartList.isEmpty
          ? const Center(child: Text("Cart is Empty"))
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
                            "${product.price}|Qty:${product.quantity}",
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
                          const SnackBar(content: Text("Order Placed")),
                        );
                      },
                      child: const Text("Place Order"),
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
        title: const Text("My Orders"),
        backgroundColor: Colors.orange,
      ),
      body: orderList.isEmpty
          ? const Center(child: Text("No orders yet"))
          : ListView.builder(
              itemCount: orderList.length,
              itemBuilder: (context, index) {
                final product = orderList[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(product.name),
                    subtitle: Text(
                      "${product.price} | Qty:${product.quantity}",
                    ),
                  ),
                );
              },
            ),
    );
  }
}
