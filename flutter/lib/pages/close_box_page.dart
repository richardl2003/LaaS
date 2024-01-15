import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lock/pages/seller_status_page.dart';
import 'package:provider/provider.dart';

import '../pages/buyer_status_page.dart';
import '../models/user_model.dart';

class CloseBoxPage extends StatelessWidget {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  var isOpen;
  var isFull;

  void updateDatabase() {
    _database.child('').update({'status': 'closed'});
  }

  @override
  Widget build(BuildContext context) {
    final boxRef = _database.child('box/');
    isOpen = boxRef.child("isOpen").get();
    isFull = boxRef.child("isFull").get();
    return Scaffold(
      appBar: AppBar(
        title: Text('Close Lockbox'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              var isOpenSnapshot = await boxRef.child("isOpen").get();
              var isFullSnapshot = await boxRef.child("isFull").get();
              var isOpen = isOpenSnapshot.value;
              var isFull = isFullSnapshot.value;

              await boxRef.update({
                'isFull': isFull == 0 ? 1 : 0,
                'isOpen': isOpen == 0 ? 1 : 0, // ADD TEMPERATURE
              });
            } catch (e) {
              print(e);
            }

            if (Provider.of<UserModel>(context, listen: false).typeOfUser == 'seller') {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SellerStatusPage(),
                  ),
                  (route) => false,
                );
            } else if (Provider.of<UserModel>(context, listen: false).typeOfUser == 'buyer') {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => BuyerStatusPage(),
                ),
                (route) => false,
              );
            } else {
              print('User is not authenticated');
            }
          },
          child: Text('Close Lockbox'),
        ),
      ),
    );
  }
}
