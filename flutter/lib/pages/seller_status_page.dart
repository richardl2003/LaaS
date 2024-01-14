import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../components/biometric_auth.dart';


class SellerStatusPage extends StatefulWidget {
  const SellerStatusPage({super.key});

  @override
  State<SellerStatusPage> createState() => _SellerStatusPageState();
}

class _SellerStatusPageState extends State<SellerStatusPage> {
  final database = FirebaseDatabase.instance.ref();

  bool isUserAuthenticated = false;
  List<bool> hasBeenFulfilled = List.generate(25, (index) => false);
  void onAuthenticationComplete(bool isAuthenticated) {
    setState(() {
      isUserAuthenticated = isAuthenticated;
    });
    
    if (isAuthenticated) {
      openLockbox();
    } else {
      print('Not authenticated');
    }
  }

  void openLockbox() async {
    final boxRef = database.child('box/');
    try {
      await boxRef.update({
        'isOpen': 1
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
        title: const Text('Status')
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
                        Navigator.pushReplacement(
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