import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lock/pages/seller_status_page.dart';

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

              print(isFull == 0 ? 0 : 1);
              print(isOpen == 0 ? 0 : 1);

              await boxRef.update({
                'isFull': isFull == 0 ? 0 : 1,
                'isOpen': isOpen == 0 ? 0 : 1,
              });
            } catch (e) {
              print(e);
            }
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => SellerStatusPage(),
              ),
              (route) => false,
            );
          },
          child: Text('Close Lockbox'),
        ),
      ),
    );
  }
}
