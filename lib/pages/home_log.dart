import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tienda_componentes/pages/users_page.dart';
import '../components/grocery_item_tile.dart';
import '../model/cart_model.dart';
import 'cart_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeLog extends StatefulWidget {
  const HomeLog({Key? key}) : super(key: key);

  

  @override
  State<HomeLog> createState() => _HomeLogState();
}
 
class _HomeLogState extends State<HomeLog> {
    final user = FirebaseAuth.instance.currentUser!;
    //final FirebaseAuth user = FirebaseAuth.instance;

      
      void signUserOut(BuildContext context) async {
    try {
      // Cerrar sesión en Firebase
      //await user.signOut();
      await FirebaseAuth.instance.signOut();

      // Navegar a la página de login (o cualquier otra página deseada)
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeLog()),
        (Route<dynamic> route) => false, // Remove all routes below LoginPage from the stack
      );
    } catch (e) {
      print("Logout error: $e");
      // Manejar cualquier error que pueda ocurrir al cerrar sesión
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: IconButton(
                icon: const Icon(Icons.person_add),
                color: Colors.grey, 
                //onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MainPage())),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => UsersPage())),
              ),
        ),
        title: Text(
        // ignore: prefer_interpolation_to_compose_strings
        "Welcome " + user.email!,
        style: const TextStyle(fontSize: 20),
      ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: const Icon(Icons.logout),
                color: Colors.grey, 
                //onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MainPage())),
                onPressed: () => signUserOut(context),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const CartPage();
            },
          ),
        ),
        child: const Icon(Icons.shopping_bag, color: Colors.white,),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(height: 48),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              "Let's order",
              style: GoogleFonts.notoSerif(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Divider(),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              "Basic components",
              style: GoogleFonts.notoSerif(
                fontSize: 18,
              ),
            ),
          ),
          Consumer<CartModel>(
            builder: (context, value, child) {
              return GridView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(), // Enable scrolling here
                padding: const EdgeInsets.all(12),
                itemCount: value.shopItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.2,
                ),
                itemBuilder: (context, index) {
                  return GroceryItemTile(
                    itemName: value.shopItems[index][0],
                    itemPrice: value.shopItems[index][1],
                    imagePath: value.shopItems[index][2],
                    color: value.shopItems[index][3],
                    onPressed: () =>
                        Provider.of<CartModel>(context, listen: false)
                            .addItemToCart(index),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
