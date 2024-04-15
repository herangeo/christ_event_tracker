// dashboard_screen.dart
import 'package:christ_event_tracker/Calendar.dart';
import 'package:christ_event_tracker/HostEventsScreen.dart';
import 'package:christ_event_tracker/events_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    var _selectedIndex=0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Dashboard',style: TextStyle(color: Colors.black),),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DashboardCard(
              title: 'Events This Month',
              value: '15', // Replace with actual data
            ),
            SizedBox(height: 16),
            DashboardCard(
              title: 'Free Venues',
              value: '8', // Replace with actual data
            ),
            SizedBox(height: 16),
            DashboardCard(
              title: 'Ongoing',
              value: 'Flutter Workshop', // Replace with actual data
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
              icon: Icons.home,
             text: 'Home',
             iconColor: Colors.black,),
            GButton(
              icon: Icons.event,
               text: 'Event',
               iconColor: Colors.black,),
            GButton(
              icon: Icons.schedule,
               text: 'Schedule',
               iconColor: Colors.black,),

          ],
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });

            switch (index) {
              case 0:
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  EventsScreen (userName: '', department: '', opportunitiesChoice: '', preferences: '',)),);
              break;
              case 1:
               Navigator.push(context, MaterialPageRoute(builder: (context) => EventDetailsScreen()),);
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

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;

  const DashboardCard({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}