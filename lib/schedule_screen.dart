import 'package:flutter/material.dart';

class ScheduleScreen extends StatefulWidget {
  final List<Map<String, dynamic>>? eventCardModelValues;

  ScheduleScreen({required this.eventCardModelValues});

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late List<ScheduleItem> scheduleItems;

  @override
  void initState() {
    super.initState();
    scheduleItems = widget.eventCardModelValues?.map((event) => ScheduleItem(
          title: event['title'],
          venue: event['venue'],
          time: event['time'],
          isCompleted: false,
          department: event['department'], 
          Date: event['date']
          ,
        ))?.toList() ?? [];
  }

  bool _showAllEvents = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Schedule',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          _buildFilterDropdown(),
        ],
      ),
      body: ListView.builder(
        itemCount: scheduleItems.length,
        itemBuilder: (context, index) {
          ScheduleItem item = scheduleItems[index];

          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(item.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.department),
                  const SizedBox(height: 8),
                  Text('Time: ${(item.time)}'),
                  if (item.isCompleted)
                    const Text(
                      'Status: Completed',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
              tileColor: Colors.amber,
              onTap: () {
                _showEventDetails(item);
              },
              onLongPress: () {
                if (!item.isCompleted) {
                  setState(() {
                    item.isCompleted = true;
                  });
                }
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilterDropdown() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButton<bool>(
        value: _showAllEvents,
        onChanged: (newValue) {
          setState(() {
            _showAllEvents = newValue!;
          });
        },
        items: const [
          DropdownMenuItem<bool>(
            value: true,
            child: Text('All Events'),
          ),
        ],
      ),
    );
  }

  // String _formatTime(String time) {
  //   return '${time.hour}:${time.minute < 10 ? '0${time.minute}' : time.minute}';
  // }

  void _showEventDetails(ScheduleItem item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Event Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Title: ${item.title}'),
              const SizedBox(height: 8),
              Text('venue: ${item.venue}'),
              const SizedBox(height: 8),
              Text('Time: ${(item.time)}'),
              const SizedBox(height: 8),
              Text('Status: ${item.isCompleted ? 'Completed' : 'Pending'}'),
              const SizedBox(height: 8),
              Text('Department: ${item.department}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

class ScheduleItem {
  final String title;
  final String venue;
  final String time;
  bool isCompleted;
  final String department;
  final String Date;

  ScheduleItem({
    required this.title,
    required this.venue,
    required this.time,
    required this.isCompleted,
    required this.department,
    required this.Date,
  });
}
