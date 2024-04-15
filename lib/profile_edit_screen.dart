import 'package:christ_event_tracker/events_screen.dart';
import 'package:christ_event_tracker/interested_events.dart';
import 'package:christ_event_tracker/login_screen.dart';
import 'package:christ_event_tracker/profileedit_EditProfile.dart';
import 'package:christ_event_tracker/profileedit_changepsswd.dart';
import 'package:christ_event_tracker/profileedit_settings.dart';
import 'package:christ_event_tracker/schedule_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class ProfileEditScreen extends StatefulWidget {
  final String userName;
  final String department;
  final String opportunitiesChoice;
  final String preferences;

ProfileEditScreen({
  required this.userName,
  required this.department,
  required this.opportunitiesChoice,
  required this.preferences,
}) ;


  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
  
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {


  int _selectedIndex = 0;
  TextEditingController nameController = TextEditingController();
  TextEditingController departmentController = TextEditingController();

@override
void initState() {

  super.initState();

  nameController.text = widget.userName;
  departmentController.text = widget.department;
}


  static  ButtonStyle whiteButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.white),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const SizedBox(
              height: 115,
              width: 115,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircleAvatar(
                   radius: 55,
              backgroundColor: Colors.black,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/Images/profileIcon.jpg'),
              ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 70),

            Container(
              width: 300,
              height: 50,

              child: ElevatedButton(
                style: whiteButtonStyle,
                onPressed: () {

                Navigator.push(context, MaterialPageRoute(builder: (context) => RealEditProfileScreen(userName: widget.userName, department: widget.department, opportunitiesChoice: widget.opportunitiesChoice, preferences: widget.preferences,)));
                  
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Edit Profile', style: TextStyle(color: Colors.black)),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            Container(
              width: 300,
              height: 50,
              child: ElevatedButton(
                style: whiteButtonStyle,
                onPressed: () {

                  
                 _showPasswordChangeDialog(context);
                  
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Change email/Password', style: TextStyle(color: Colors.black)),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: 300,
               height: 50,
              child: ElevatedButton(
                style: whiteButtonStyle,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const Settings()));
                 
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Settings', style: TextStyle(color: Colors.black)),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: 300,
              height: 50,
              child: ElevatedButton(
                style: whiteButtonStyle,
                onPressed: () {

                Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));


                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Log out', style: TextStyle(color: Colors.black)),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),


      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(5),
        child: GNav(
          backgroundColor: Colors.white,
          gap:8,
          color: Colors.black,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.black,
          selectedIndex: _selectedIndex,
          padding: const EdgeInsets.all(16),
          tabs: const [
            GButton(icon: Icons.home, text: 'Home'),
            GButton(icon: Icons.star, text: 'Interested Events'),
            GButton(icon: Icons.schedule, text: 'Schedule'),
          ],
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });

            switch (index) {
              case 0:
              Navigator.push(context, MaterialPageRoute(builder: (context) => const EventsScreen(userName: '', department: '', opportunitiesChoice: '', preferences: '',)),);
              break;
                case 1:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InterestedEventDetailsScreen(
                        eventName: evenCardModelNotifierNavigation.value?.title ?? '',
                        department: evenCardModelNotifierNavigation.value?.department ?? '',
                        venue: evenCardModelNotifierNavigation.value?.venue ?? '',
                        date: evenCardModelNotifierNavigation.value?.date ?? '',
                        link: evenCardModelNotifierNavigation.value?.link ?? '',
                        url: evenCardModelNotifierNavigation.value?.imageUrl ?? '',
                        time: evenCardModelNotifierNavigation.value?.time ?? '',
                      ),
                    ),
                  );
                  break;
              case 2:
              Navigator.push(context, MaterialPageRoute(builder: (context) =>ScheduleScreen(eventCardModelValues: eventCardModelNotifier.value,)));
              break;
            }
          },
        ),
      ),



    );
  }
   Future<void> _showPasswordChangeDialog(BuildContext context) async {
    TextEditingController passwordController = TextEditingController();

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Password'),
          content: Container(
            width: 300, // Set the width you desire
            height: 120, 
            child: Column(
              children: [
                Center(
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Enter current password',
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); 
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const changePassword()));
              },
              child: const Text('Submit'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

}
