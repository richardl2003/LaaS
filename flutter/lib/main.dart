import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/cart_model.dart';
import 'models/user_model.dart';
import 'pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CartModel()
        ),
        ChangeNotifierProvider(
          create: (_) => UserModel()
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ),
    );
    // return ChangeNotifierProvider(
    //   create: (context) => CartModel(),
    //   child: const MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     home: LoginPage(),
    //   )
    // );
  }
}