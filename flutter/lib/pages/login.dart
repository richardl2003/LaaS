import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'seller_status_page.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome',
                style: GoogleFonts.notoSerif(
                  fontSize: 36,
                  fontWeight: FontWeight.bold
                ),
              ),
              TextFormField(
                controller: _username,
                decoration: const InputDecoration(
                  hintText: 'Username',
                ),
              ),
              TextFormField(
                controller: _password,
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
                obscureText: true,
              ),
              const SizedBox(
                height: 24,
              ),
              GestureDetector(
                onTap: () {
                  if (_username.text.isNotEmpty && _password.text.isNotEmpty) {
                    Provider.of<UserModel>(context, listen: false).editUsername(_username.text);
                    Provider.of<UserModel>(context, listen: false).editPassword(_password.text);
                    Provider.of<UserModel>(context, listen: false).editTypeOfUser("buyer");
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const HomePage();
                        }
                      )
                    );
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const LoginPage();
                        }
                      )
                    );                    
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12)
                  ),
                  padding: const EdgeInsets.all(24),
                  child: const Text(
                    "Log in as buyer",
                    style: TextStyle(color: Colors.white)
                  )
                )                
              ),

              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  if (_username.text.isNotEmpty && _password.text.isNotEmpty) {
                    Provider.of<UserModel>(context, listen: false).editUsername(_username.text);
                    Provider.of<UserModel>(context, listen: false).editPassword(_password.text);
                    Provider.of<UserModel>(context, listen: false).editTypeOfUser("seller");
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const SellerStatusPage();
                        }
                      )
                    );
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const LoginPage();
                        }
                      )
                    );                    
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12)
                  ),
                  padding: const EdgeInsets.all(24),
                  child: const Text(
                    "Log in as seller",
                    style: TextStyle(color: Colors.white)
                  )
                )                
              )              
            ],
          ),
        ),
      ),
    );
  }
}