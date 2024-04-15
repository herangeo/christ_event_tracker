import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'events_screen.dart';
import 'package:getwidget/getwidget.dart';
import 'package:christ_event_tracker/Firebase/Signup_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  final FirebaseAuthservice _auth = FirebaseAuthservice();
  final GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Form(
          key: formKey1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Please provide a valid email';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: !passwordVisible,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    fillColor: Colors.white,
                    filled: true,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                      icon: Icon(
                        passwordVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.length < 6) {
                      return 'Password must be greater than 6 characters';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(),
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontSize: 16,
                    color:Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GFButton(
                    onPressed: () {},
                    text: "",
                    icon: const Icon(Icons.facebook),
                    type: GFButtonType.transparent,
                  ),
                  GFButton(
                    onPressed: () {},
                    text: "",
                    icon: const Icon(Icons.apple),
                    type: GFButtonType.transparent,
                  ),
                  GFButton(
                    onPressed: () {},
                    text: "",
                    icon: const Icon(Icons.android),
                    type: GFButtonType.transparent,
                  ),
                ],
              ),
              const SizedBox(height: 350),
              Container(
                width: 350,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey1.currentState!.validate()) {
                      _signin();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  void _signin() async {
    String email = emailController.text;
    String password = passwordController.text;

    User? user = await _auth.signinWithEmailAndPassword(email, password);

    if (user != null) {
      print("Successful");
      Navigator.push(context, MaterialPageRoute(builder: (context) => EventsScreen(userName: '', department: '', opportunitiesChoice: '', preferences: '',)));
    } else {
      print("Some error happened");
      // Show Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Check your email and password. Please try again.'),
        ),
      );
    }
  }
}
