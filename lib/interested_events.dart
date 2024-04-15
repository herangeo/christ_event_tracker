import 'package:christ_event_tracker/events_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InterestedEventDetailsScreen extends StatelessWidget {
  final String eventName;
  final String department;
  final String venue;
  final String date;
  final String link; 
  final String time;
  final String url;
  // Number of people interested

  InterestedEventDetailsScreen({
    required this.eventName,
    required this.department,
    required this.venue,
    required this.date,
    required this.link,
    required this.url,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Details',style: TextStyle(color: Colors.black),),
      ),
      body: 
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      url,
                      fit: BoxFit.cover, // You can adjust the BoxFit property as needed
                      height: 200, // You can adjust the height as needed
                    ),
                  ),
                ),
                const Text('Event Name',style: TextStyle(fontSize:15.0, fontWeight: FontWeight.bold)),
                Card(
                                  color: Colors.black,
                  child: Container(
                    constraints: const BoxConstraints(
                      minWidth: 50.0,
                      minHeight: 50.0,
                    ),
                    child: Center(
                      child: Text(
                      '$eventName',
                      style:
                       TextStyle(color: Colors.white)
                      ),
                    ),
                  ),
                ),
                const Text('Time',style: TextStyle(fontSize:15.0, fontWeight: FontWeight.bold)),
                Card(
                                  color: Colors.black,
                  child: Container(
                    constraints: const BoxConstraints(
                      minWidth: 50.0,
                      minHeight: 50.0,
                    ),
                    child: Center(
                      child: Text(
                      '$time',
                      style: const TextStyle(color: Colors.white)
                      ),
                    ),
                  ),
                ),
                const Text('Show Date',style: TextStyle(fontSize:15.0, fontWeight: FontWeight.bold)),
                Card(
                  color: Colors.black,
                  child: Container(
                    constraints: const BoxConstraints(
                      minWidth: 50.0,
                      minHeight: 50.0,
                    ),
                    child: Center(
                      child: Text(
                      '$date',
                      style: const TextStyle(color: Colors.white)
                      ),
                    ),
                  ),
                ),
                const Text('Venue',style: TextStyle(fontSize:15.0, fontWeight: FontWeight.bold)),
                Card(
                    color: Colors.black,
                  child: Container(
                    constraints: const BoxConstraints(
                      minWidth: 50.0,
                      minHeight: 50.0,
                    ),
                    child: Center(
                      child: Text(
                      '$venue',
                      style: const TextStyle(color: Colors.white)
                      ),
                    ),
                  ),
                ),
                const Text('Department',style: TextStyle(fontSize:15.0, fontWeight: FontWeight.bold)),
                Card(
                   color: Colors.black,
                  child: Container(
                    constraints: const BoxConstraints(
                      minWidth: 50.0,
                      minHeight: 50.0,
                    ),
                    child: Center(
                      child: Text(
                      '$department',
                      style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
        
          
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          _launchURLApp();
                          

                        },
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(const Size(155, 40)),
                          backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.black),
                        )
                        ,
                        child: const Text('Register',style: TextStyle(color: Colors.white),),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(const Size(155, 40)),
                          backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.black),
        
                        ),
                        child: const Text('Cancel',style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _launchURLApp() async {
  var url = Uri.parse(link);
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}
}



class InterestedEventsScreen extends StatefulWidget {
  @override
  _InterestedEventsScreenState createState() => _InterestedEventsScreenState();
}

class _InterestedEventsScreenState extends State<InterestedEventsScreen> {
  List<InterestedEventModel> interestedEvents = [

    // Add more interested events as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Interested Events'),
      ),
      body: ListView.builder(
        itemCount: interestedEvents.length,
        itemBuilder: (context, index) {
          InterestedEventModel event = interestedEvents[index];
          return Dismissible(
            key: Key(event.eventName),
            onDismissed: (direction) {

              setState(() {
                interestedEvents.removeAt(index);
              });
            },
            background: Container(
              color: Colors.red,
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            child: ListTile(
              title: Text(event.eventName),
              subtitle: Text('Venue: ${event.venue}'),
              onTap: () {
                
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InterestedEventDetailsScreen(
                      eventName: event.eventName,
                      department: event.department,
                      venue: event.venue,
                      date: event.date,
                      link: event.link,
                      url:event.url, time: '',
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class InterestedEventModel {
  final String eventName;
  final String department;
  final String venue;
  final String date;
  final String link;
  final String url;

  InterestedEventModel(
    this.eventName,
    this.department,
    this.venue,
    this.date,
    this.link,
    this.url
  );
}
