import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lock/models/cart_model.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import 'dart:math';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final database = FirebaseDatabase.instance.ref();
  
  @override
  Widget build(BuildContext context) {
    final buyerRef = database.child('accounts/buyers/');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart')
      ),
      body: Consumer<CartModel>(
        builder: (context, value, child) {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: value.cartItems.length,
                padding: EdgeInsets.all(12),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8)
                        ),
                      child: ListTile(
                        leading: Image.asset(
                          value.cartItems[index][2],
                          height: 36
                        ),
                        title: Text(value.cartItems[index][0]),
                        subtitle: Text('\$' + value.cartItems[index][1]),
                        trailing: IconButton(
                          icon: Icon(Icons.cancel),
                          onPressed: () => 
                              Provider.of<CartModel>(context, listen: false).removeItemFromCart(index)
                        )
                      ),
                    ),
                  );
                },
              )
            ),

            Padding(
              padding: const EdgeInsets.all(36.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12)
                ),
                padding: EdgeInsets.all(24),  
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Price",
                          style: TextStyle(color: Colors.green[100])
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '\$' + value.calculateTotal(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          )
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () async {
                        var name = Provider.of<UserModel>(context, listen: false).username;
                        var pass = Provider.of<UserModel>(context, listen: false).password;
                        var type = Provider.of<UserModel>(context, listen: false).typeOfUser;
                        var cart = Provider.of<CartModel>(context, listen: false).cartItems;
                        var orders = [];
                        cart.forEach((item) => orders.add(item[0]));
                        var id = Random().nextInt(1000);
                        try {
                          await buyerRef.set({
                            id: {
                              'user': name,
                              'type': type,
                              'password': pass,
                              'order': orders
                            }
                          });
                        } catch (e) {
                          print("error");
                        }

                        // if (context.mounted) {
                        //   Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder:(context) {
                        //         return const StatusPage();
                        //       },
                        //     )
                        //   );
                        // }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green.shade100),
                          borderRadius: BorderRadius.circular(12)
                        ),
                        padding: const EdgeInsets.all(12),
                        child: const Row(
                          children: [
                            Text(
                              "Order",
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Colors.white
                            )                            
                          ]
                        )
                      )
                    )
                  ],
                ),          
              ),
            )
          ]
        );
      })
    );
  }
}