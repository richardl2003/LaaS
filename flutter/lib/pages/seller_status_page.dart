import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart_model.dart';
import '../pages/close_box_page.dart';
import '../components/biometric_auth.dart';
import 'login.dart';


class SellerStatusPage extends StatefulWidget {
  const SellerStatusPage({super.key});

  @override
  State<SellerStatusPage> createState() => _SellerStatusPageState();
}

class _SellerStatusPageState extends State<SellerStatusPage> {
  final database = FirebaseDatabase.instance.ref();

  bool isUserAuthenticated = false;
  bool isBoxOpen = false;
  List<bool> hasBeenFulfilled = List.generate(25, (index) => false);

  void onAuthenticationComplete(bool isAuthenticated) {
    setState(() {
      isUserAuthenticated = isAuthenticated;
    });

    if (isBoxOpen) {
      //closeLockbox();
      Navigator.pushAndRemoveUntil(
      context,
        MaterialPageRoute(
          builder: (context) => CloseBoxPage(),
        ),
        (route) => false,
      );
    }
    else if (isUserAuthenticated) {
      // Perform actions after successful authentication
      print('User is authenticated');
      openLockbox();
      Navigator.pushAndRemoveUntil(
      context,
        MaterialPageRoute(
          builder: (context) => CloseBoxPage(),
        ),
        (route) => false,
      );
    } else {
      // Handle unsuccessful authentication
      print('User is not authenticated');
    }
  }

  void openLockbox () async {
    final boxRef = database.child('box/');
    try {
      await boxRef
        .update({
          'isOpen': 1
        }
      );
      setState(() {
        isBoxOpen = true;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final buyerRef = database.child('accounts/buyers/');

    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Status'),
        actions: [
          IconButton(
            onPressed: () {
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
      body: Column (
          children: [
            Expanded(
            child: FirebaseAnimatedList(
              query: buyerRef,
              itemBuilder: (context, snapshot, animation, index) {
                var user = snapshot.child('user').value.toString();
                var cost = snapshot.child('cost').value.toString();
                var orders = snapshot.child('order').value.toString();
                return ListTile (
                  minVerticalPadding: 20,
                  title: Text("Order from: " + user.toString()),
                  subtitle: Text("Cost: \$" + cost.toString() + "\nItems: " + orders.toString()),
                  trailing: MaterialButton(
                    color: hasBeenFulfilled[index] ? Colors.green.shade100 : Colors.orange.shade100,
                    onPressed: () {
                      setState(() {
                        hasBeenFulfilled[index] = !hasBeenFulfilled[index];
                      });
                      
                      if (!hasBeenFulfilled[index]) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BiometricAuth(
                              onAuthenticationComplete: onAuthenticationComplete
                            )
                          )
                        );
                      }
                      
                    },
                    child: Text(
                      hasBeenFulfilled[index] ? 'Open': 'Fulfill', 
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ]
      )
    );
  }
}