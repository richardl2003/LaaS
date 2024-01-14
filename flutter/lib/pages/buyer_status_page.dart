import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_database/firebase_database.dart';

import '../components/biometric_auth.dart';
import '../models/user_model.dart';
import '../pages/close_box_page.dart';

class BuyerStatusPage extends StatefulWidget {
  @override
  _BuyerStatusPageState createState() => _BuyerStatusPageState();
}

class _BuyerStatusPageState extends State<BuyerStatusPage> {
  final database = FirebaseDatabase.instance.ref();

  bool isButtonActive = false;
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
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BiometricAuth(
                              onAuthenticationComplete: onAuthenticationComplete
                            )
                          )
                        );
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