import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';


class SellerStatusPage extends StatefulWidget {
  const SellerStatusPage({super.key});

  @override
  State<SellerStatusPage> createState() => _SellerStatusPageState();
}

class _SellerStatusPageState extends State<SellerStatusPage> {
  final database = FirebaseDatabase.instance.ref();

  // bool hasBeenFulfilled = false;
  List<bool> hasBeenFulfilled = List.generate(25, (index) => false);

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