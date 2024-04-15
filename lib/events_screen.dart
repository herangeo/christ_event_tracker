


import 'dart:html';

import 'package:christ_event_tracker/Firebase/Signup_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'profile_edit_screen.dart';
import 'schedule_screen.dart';
import 'interested_events.dart';
import 'EventsHostingScreen.dart';


FirestoreService firestoreService = FirestoreService();



ValueNotifier<List<Map<String, dynamic>>> eventCardModelNotifier = ValueNotifier([]);

ValueNotifier<EventCardModel?> evenCardModelNotifierNavigation = ValueNotifier(null);
List<EventCardModel> events = [];


TextEditingController  _searchController = TextEditingController();

class EventsScreen extends StatefulWidget {
  final String userName;
  final String department;
  final String opportunitiesChoice;
  final String preferences;

  const EventsScreen({
    required this.userName, 
    required this.department, 
    required this.opportunitiesChoice, 
    required this.preferences});

  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {

  int _selectedIndex = 0;

  
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Events', style: TextStyle(color: Colors.black)),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EventHostingScreen()),
              );
            },
            child: const Icon(Icons.add, color: Colors.black),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {
              // Show a search dialog or navigate to a search screen
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Search Events'),
                    content: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Enter event title',
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          String searchQuery = _searchController.text;
                          List<EventCardModel> filteredEvents = events
                              .where((event) =>
                                  event.title.toLowerCase().contains(searchQuery.toLowerCase()))
                              .toList();
                          setState(() {
                            eventCardModelNotifier.value = filteredEvents.map((e) => e.title).cast<Map<String, dynamic>>().toList();
                          });

                          // Show error message if no events are found
                          if (filteredEvents.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('No events found for "$searchQuery".'),
                              ),
                            );
                          }
                        },
                        child: Text('Search'),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Icon(Icons.search, color: Colors.black),
          ),


        ],
      ),
      body: EventsCardList(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(5),
        child: GNav(
          backgroundColor: Colors.white,
          gap: 8,
          color: Colors.black,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.black,
          selectedIndex: _selectedIndex,
          padding: const EdgeInsets.all(16),
          tabs: const [
            GButton(icon: Icons.person, text: 'Profile'),
            GButton(icon: Icons.star, text: 'Interested Events'),
            GButton(icon: Icons.schedule, text: 'Schedule'),
          ],
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });

            switch (index) {
              case 0:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileEditScreen(

                      userName: widget.userName,
                      department: widget.department,
                      opportunitiesChoice: widget.opportunitiesChoice,
                      preferences: widget.preferences,

                    ),
                  ),
                );
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ScheduleScreen(eventCardModelValues: eventCardModelNotifier.value,)),
                );
                break;
            }
          },
        ),
      ),
    );
  }
}

class EventsCardList extends StatefulWidget {
  @override
  _EventsCardListState createState() => _EventsCardListState();
}

class _EventsCardListState extends State<EventsCardList> {
 
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: events.map((event) {
        int index = events.indexOf(event);
        return EventCard(
          event: event,
          onSwipeRight: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InterestedEventDetailsScreen(
                  eventName: event.title,
                  department: event.department,
                  venue: event.venue,
                  date: event.date,
                  link: "",
                  url: event.imageUrl,
                  time: event.time,
                  
                ),
              ),
            );
            

            //  eventCardModelNotifier.value = [event.title];
            print(eventCardModelNotifier.value);


          },
          onSwipeLeft: () {
            // Handle swipe left
          },
          onDetailsTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InterestedEventDetailsScreen(
                  eventName: event.title,
                  department: event.department,
                  venue: event.venue,
                  date: event.date,
                  link:event.link ,
                  url: event.imageUrl,
                  time: event.time,
                ),
              ),
            );
            setState(() {
                evenCardModelNotifierNavigation.value = event;
            });

          eventCardModelNotifier.value = [
            ...eventCardModelNotifier.value,
            {'title': event.title, 'time': event.time,'venue':event.venue,'department':event.department,'date':event.date}
          ];
            print(eventCardModelNotifier.value);
          },
        );
      }).toList(),
    );
  }
}

class EventCard extends StatelessWidget {
  final EventCardModel event;
  final Function onSwipeRight;
  final Function onSwipeLeft;
  final Function() onDetailsTap;

  EventCard({
    required this.event,
    required this.onSwipeRight,
    required this.onSwipeLeft,
    required this.onDetailsTap,
  });

  
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(event.title),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          onSwipeRight();
        } else if (direction == DismissDirection.endToStart) {
          onSwipeLeft();
        }
      },
      background: Container(
        color: Colors.white,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(
          Icons.thumb_up,
          color: Colors.black,
          size: 30,
        ),
      ),
      secondaryBackground: Container(
        color: Colors.white,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(
          Icons.thumb_down,
          color: Colors.black,
          size: 30,
        ),
      ),
      child: GestureDetector(
        onTap: onDetailsTap,
        child: Hero(
          tag: 'event_card_${event.title}',
          child: Card(
            elevation: 5,
            margin: const EdgeInsets.all(16),
            child: Column(
              children: [
                Image.network(
                  event.imageUrl,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text('Venue: ${event.venue}'),
                      Text('Date: ${event.date}'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EventCardModel {
  final String title;
  final String venue;
  final String date;
  final String imageUrl;
  final String department;
  final String link;
  final String time;

  EventCardModel({
    required this.title,
    required this.venue,
    required this.date,
    required this.imageUrl,
    required this.department,
    required this.time, 
    required this.link,
  });
}
