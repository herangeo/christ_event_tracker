import 'package:christ_event_tracker/profile_edit_screen.dart';
import 'package:christ_event_tracker/profileedit_EditProfile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'events_screen.dart';
import 'Firebase/Signup_auth.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuthservice _auth = FirebaseAuthservice();
  final FirestoreService firestoreService = FirestoreService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;


  String opportunitiesChoice = '';
  List<String> preferences = [];
  var _dropdownValue;
  var _dropDownDepartment;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter full name';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                          TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'Please provide a valid email';
                            } else if (!value.endsWith('christuniversity.in')) {
                              return 'Please use a Christ University email';
                            } else {
                              return null;
                            }
                          },
),

                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonFormField<String>(
                          hint:Text('Department') ,
                          value: _dropDownDepartment,
                          items: const [
                            DropdownMenuItem(child: Text('CS'),value:'CS' ,),
                            DropdownMenuItem(child: Text('Data Science'),value:'Data Science' ,),
                            DropdownMenuItem(child: Text('Commerce'),value:'Commerce' ,),
                            DropdownMenuItem(child: Text('Psychology'),value:'Psychology' ,)
                          ],
                           onChanged: (String? SelectedDepartment){
                          if (SelectedDepartment != null) {
                              setState(() {
                                 _dropDownDepartment = SelectedDepartment;
                              });
                            }
                           },
                          validator: (value) {
                          if (value == null) {
                            return 'Please select a department';
                          } else {
                            return null;
                          }
                         },),
                      ),



                      const SizedBox(height: 20),
                      TextFormField(
                        obscureText: !passwordVisible,
                        controller: passwordController,
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
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            DropdownButtonFormField<String>(
                              hint: Text('Select your preference'),
                              items: const [
                                DropdownMenuItem(child: Text("Art"), value: "Art"),
                                DropdownMenuItem(child: Text("Photography"), value: "Photography"),
                                DropdownMenuItem(child: Text("Writing"), value: "Writing"),
                                DropdownMenuItem(child: Text("Dancing"), value: "Dancing"),
                                DropdownMenuItem(child: Text("Sports"), value: "Sports"),
                              ],
                              onChanged: (String? selectedValue) {
                                if (selectedValue != null) {
                                  setState(() {
                                    _dropdownValue = selectedValue;
                                  });
                                }
                              },
                              iconSize: 42.0,
                              value: _dropdownValue,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                                                      validator: (value) {
                          if (value == null) {
                            return 'Please select Preference';
                          } else {
                            return null;
                          }
  }),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      Container(
                        width: 350,
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              firestoreService.addusers(nameController.text,emailController.text,_dropDownDepartment,passwordController.text,_dropdownValue);
                              _signup();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPreferenceChip(String label) {
    return InputChip(
      label: Text(label),
      selected: preferences.contains(label),
      onSelected: (bool selected) {
        setState(() {
          if (selected) {
            preferences.add(label);
          } else {
            preferences.remove(label);
          }
        });
      },
    );
  }

  void _signup() async {
    String email = emailController.text;
    String password = passwordController.text;
    String _dropDownDepartmentdepartment = departmentController.text;
    String name = nameController.text;

    User? user = await _auth.signupWithEmailAndPassword(email, password);

    if (user != null) {
      print("Successfully signed up");

      Navigator.push(context, MaterialPageRoute(builder: (context) => EventsScreen(userName: name, department: _dropDownDepartment, opportunitiesChoice: opportunitiesChoice, preferences: _dropdownValue,)));



      print(email);
      print(_dropDownDepartment);
      print(opportunitiesChoice);
      print(_dropdownValue);
      

    } else {
      print("Some error happened during signup");
    }
  }
}
