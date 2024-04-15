import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:christ_event_tracker/DashboardScreen.dart';
import 'package:christ_event_tracker/HostEventsScreen.dart';
import 'package:christ_event_tracker/events_screen.dart';

class ScheduleScreen1 extends StatefulWidget {
  @override
  State<ScheduleScreen1> createState() => _ScheduleScreen1State();
}

class _ScheduleScreen1State extends State<ScheduleScreen1> {
  int _selectedIndex = 0;
  List<EventCardModel> events = [];

  @override
  void initState() {
    super.initState();
    // Load events when the screen is initialized
    loadEvents();
  }

  void loadEvents() async {
    try {
      List<EventCardModel> fetchedEvents = await firestoreService.getEventsFromFirebase();
      setState(() {
        events = fetchedEvents;
      });
    } catch (e) {
      print("Error loading events: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Schedule', style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            return ScheduleCard(
              eventName: events[index].title,
              eventDate: events[index].date,
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(5),
        child: GNav(
          backgroundColor: Colors.white,
          gap: 8,
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: const Color.fromARGB(255, 0, 0, 0),
          selectedIndex: _selectedIndex,
          padding: const EdgeInsets.all(16),
          tabs: const [
            GButton(
              icon: Icons.event,
              text: 'Schedule',
              iconColor: Colors.black,
            ),
            GButton(
              icon: Icons.home,
              text: 'Home',
              iconColor: Colors.black,
            ),
            GButton(
              icon: Icons.dashboard,
              text: 'Host Events',
              iconColor: Colors.black,
            ),
          ],
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });

            switch (index) {
              case 0:
                break;
              case 1:
                Navigator.push(context, MaterialPageRoute(builder: (context) => EventsScreen(userName: '', department: '', opportunitiesChoice: '', preferences: '',)),);
                break;
              case 2:
                Navigator.push(context, MaterialPageRoute(builder: (context) => EventDetailsScreen()),);
                break;
            }
          },
        ),
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  final String eventName;
  final String eventDate;

  const ScheduleCard({
    required this.eventName,
    required this.eventDate,
  });

  @override
  Widget build(BuildContext context) {
    // final daysDifference = eventDate.difference(DateTime.now()).inDays;

    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              eventName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Date: ${eventDate}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            // Text(
            //   'Days until the event: ',
            //   style: const TextStyle(
            //     fontSize: 16,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
