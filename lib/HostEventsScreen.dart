// event_details_screen.dart

import 'package:christ_event_tracker/Firebase/Signup_auth.dart';
import 'package:christ_event_tracker/events_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'profile_edit_screen.dart'; 
import 'DashboardScreen.dart';
import 'Calendar.dart';
import 'schedule_screen.dart';


class EventDetailsScreen extends StatefulWidget {
  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  
    final FirestoreService firestoreService = FirestoreService();


   var _dropdownValue;
     var _dropDownDepartment;


   TextEditingController _eventName = TextEditingController();
   TextEditingController _VenueName = TextEditingController();
   TextEditingController _DateName = TextEditingController();
   TextEditingController _Time = TextEditingController();
   TextEditingController _link = TextEditingController();


  @override
  Widget build(BuildContext context) {
    var _selectedIndex=0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Event Details',style:TextStyle(color: Colors.black),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
             TextFormField(
              controller: _eventName ,
              decoration: const InputDecoration(
                labelText: 'Event Name',
              ),
            ),
            const SizedBox(height: 16),
                            DropdownButtonFormField<String>(
                              hint: const Text('Department'),
                              items: const [
                            DropdownMenuItem(child: Text('CS'),value:'CS',),
                            DropdownMenuItem(child: Text('Data Science'),value:'Data Science',),
                            DropdownMenuItem(child: Text('Commerce'),value:'Commerce' ,),
                            DropdownMenuItem(child: Text('Psychology'),value:'Psychology' ,)
                              ],
                              onChanged: (String? selectedDepartment){
                              if (selectedDepartment != null) {
                                  setState(() {
                                    _dropDownDepartment = selectedDepartment;
                                  });
                                }
                              },
                              iconSize: 42.0,
                              value: _dropDownDepartment,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _VenueName,
              decoration: const InputDecoration(
                labelText: 'Venue',
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller:_DateName ,
              decoration: const InputDecoration(
                labelText: 'Date',
                hintText: "DD/MM/YY"
              ),
            ),
           const SizedBox(height: 16),
            TextFormField(
              controller:_Time ,
              decoration: const InputDecoration(
                labelText: 'Time',
                hintText: "00:00 AM/PM"
              ),
            ),
          const SizedBox(height: 16),
            DropdownButtonFormField<String>(
                              hint: const Text('Category'),
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
                                 _dropdownValue =selectedValue;
                                  });
                                }
                              },
                              iconSize: 42.0,
                              value: _dropdownValue,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _link,
              decoration: InputDecoration(
                hintText: "Link",
                labelText: "Link"
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
            style:ElevatedButton.styleFrom(
            backgroundColor: Colors.black
          ),
              onPressed: () {

            firestoreService.addevents(_eventName.text,_dropDownDepartment,_VenueName.text,_DateName.text,_Time.text,_dropdownValue,_link.text);
              },
              child: const Text('Post',style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(5),
        child: GNav(
          backgroundColor: Colors.white,
          gap:8,
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.black,
          selectedIndex: _selectedIndex,
          padding: const EdgeInsets.all(16),
          tabs: const [
            GButton(
              icon: Icons.dashboard,
             text: 'Host Events',
             iconColor: Colors.black,),
           GButton(
              icon: Icons.home,
               text: 'Home',
               iconColor: Colors.black,),
            GButton(
              icon: Icons.event,
               text: 'Schedule',
               iconColor: Colors.black,),


          ],
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
            switch (index) {
              case 0:
              // Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen()),);
              break;
              case 1:
              // String event=_eventName.text;
              // String department= _dropdownValue;
              // String Venue=_VenueName.text;
              // String date=_DateName.text;

               Navigator.push(context, MaterialPageRoute(builder: (context) => const EventsScreen(userName:'', department: '', opportunitiesChoice:'', preferences:'',)),);
                break;
              case 2:
               Navigator.push(context, MaterialPageRoute(builder: (context) => ScheduleScreen1()),);
                break;
            }
          },
        ),
      ),
    );
  }
}




