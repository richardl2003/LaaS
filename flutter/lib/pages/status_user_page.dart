import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/biometric_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../models/user_model.dart';

class StatusUserPage extends StatefulWidget {
  @override
  _StatusUserPageState createState() => _StatusUserPageState();
}

class _StatusUserPageState extends State<StatusUserPage> {
  final database = FirebaseDatabase.instance.ref();

  bool isButtonActive = false;

  @override
  Widget build(BuildContext context) {
    final buyerRef = database.child('accounts/buyers/');

    return Scaffold(
      appBar: AppBar(
        title: Text('Your orders'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
              query: buyerRef.orderByKey(),
              itemBuilder:(context, snapshot, animation, index) {
                var userFromDatabase = snapshot.child('user').value.toString();
                var orders = snapshot.child('order').value.toString();
                var status = snapshot.child('status').value.toString();
                var userFromApp = Provider.of<UserModel>(context, listen: false).username;
                if (userFromDatabase == userFromApp) {
                    return ListTile(
                      title: Text(status.toUpperCase()),
                      subtitle: Text("Items: " + orders),
                      trailing: MaterialButton(
                        color: Colors.green.shade100,
                        onPressed: () {

                        },
                        child: const Text(
                          'Open', 
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                }
                return Text("");
              },
            )
          )
        ]
      )
    );
  }
}