// login_screen.dart

import 'package:flutter/material.dart';
import 'login_page.dart';
import 'signup_page.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('#FOMONOMO',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),),
      ),
      backgroundColor:Colors.white, // Set the background color to blue
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            const SizedBox(height: 20), // Add some spacing
            
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0), 
              child: Container(
                width: 300, 
                child: TextButton(
                  onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black,
                    side: BorderSide(width: 2 ,color: Colors.black)
                  ),
                  child: const Text(
                    'Login', 
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 10), // Add some spacing
            
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0), 
              child: Container(
                width: 300, 
                child: TextButton(
                  onPressed: () {

                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                  style: TextButton.styleFrom(
                    backgroundColor:  Colors.black,
                    side: BorderSide(width: 2 ,color: Colors.black)
                  ),
                  child: const Text(
                    'Signup',
                    style: TextStyle(color: Colors.white), 
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
