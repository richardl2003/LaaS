import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/grocery_item_tile.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';
import 'cart_page.dart';
import 'login.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<CartModel>(context, listen: false).emptyCart();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginPage();
                  }
                )
              );
            },
            icon: const Icon(Icons.logout)
          )
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, 
        MaterialPageRoute(
          builder: (context) {
            return const CartPage();
          }
        )),
        backgroundColor: Colors.black,
        child: const Icon(Icons.shopping_bag, color: Colors.white)
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),

            // good morning
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text("Good morning,"),
            ),

            const SizedBox(height: 4),

            // order item
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "Let's order fresh items for you",
                style: GoogleFonts.notoSerif(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                )
              ),
            ),

            const SizedBox(height: 24),
        
            // divider
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Divider(),
            ),

            const SizedBox(height: 24),
        
            //fresh items + grid
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "Fresh Items",
                style: TextStyle(fontSize: 16),
              ),
            ),

            Expanded(
              child: Consumer<CartModel>(builder: (context, value, child) {
                return GridView.builder(
                  itemCount: value.shopItems.length,
                  padding: EdgeInsets.all(12),
                  gridDelegate: 
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 1.3
                    ),
                  itemBuilder: (context, index) {
                    return GroceryItemTile(
                      itemName: value.shopItems[index][0], 
                      itemPrice: value.shopItems[index][1], 
                      imgPath: value.shopItems[index][2], 
                      color: value.shopItems[index][3],
                      onPressed: () {
                        Provider.of<CartModel>(context, listen: false).addToCart(index);
                      }
                    );
                  }
                );
              }
              
              )
            )

          ]
        ),
      )
    );
  }
}