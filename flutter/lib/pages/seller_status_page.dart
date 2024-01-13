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

  @override
  Widget build(BuildContext context) {
    final ref = database.child('accounts/buyers');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Status')
      ),
      body: Container(
        height: double.infinity,
        child: Expanded(
          child: FirebaseAnimatedList(
            query: ref,
            itemBuilder: (context, snapshot, animation, index) {
              return ListTile(
                title: Text(snapshot.value.toString())
              );
            },
          ),
        )
      )
    );
  }
}