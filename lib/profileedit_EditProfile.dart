import 'package:flutter/material.dart';

class RealEditProfileScreen extends StatefulWidget {
  final String userName;
  final String department;
  final String opportunitiesChoice;
  final String preferences;

  RealEditProfileScreen({
    required this.userName,
    required this.department,
    required this.opportunitiesChoice,
    required this.preferences,
  });

  @override
  State<RealEditProfileScreen> createState() => _RealEditProfileScreenState();
}

class _RealEditProfileScreenState extends State<RealEditProfileScreen> {
  late String editName;
  late String editDepartment;
  late String editPreference;


  bool _isEditingText = false;
  late TextEditingController _editingController;
    late TextEditingController _editingdepartmentController;
      late TextEditingController _editingPreferenceController;

  @override
  void initState() {
    super.initState();

    editName = widget.userName;
    editDepartment = widget.department;
    editPreference = widget.preferences;

    _editingController = TextEditingController(text: editName);
    _editingdepartmentController = TextEditingController(text: editDepartment);
    _editingPreferenceController = TextEditingController(text: editPreference);
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(

        child: Column(
          children: [
                    const SizedBox(height: 80,)
                    ,_editTitleTextField()
                    ,const SizedBox(height: 25,)
                    ,_editDepartmentTextField()
                    ,const SizedBox(height: 25,)
                    ,_editPreferenceTextField(),
                    const SizedBox(height: 345,),

                    Container(
                      width: 350,
                      child: ElevatedButton(onPressed: (){
                      },
                    style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                   child: const Text("Submit",style: TextStyle(color: Colors.white),)),
                    )
                    ],

        ),
      ),
    );
  }

  Widget _editTitleTextField() {
    if (_isEditingText) {
      return Center(
        child: TextField(
          onSubmitted: (newValue) {
            setState(() {
              editName = newValue;
              _isEditingText = false;
            });
          },
          autofocus: true,
          controller: _editingController,
        ),
      );
    }
    return InkWell(
      onTap: () {
        setState(() {
          _isEditingText = true;
        });
      },
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text('Name :'),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              editName,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
      
      
    );
  }
    Widget _editDepartmentTextField() {
    if (_isEditingText) {
      return Center(
        child: TextField(
          onSubmitted: (newValue) {
            setState(() {
              editDepartment = newValue;
              _isEditingText = false;
            });
          },
          autofocus: true,
          controller: _editingdepartmentController,
        ),
      );
    }
    return InkWell(
      onTap: () {
        setState(() {
          _isEditingText = true;
        });
      },
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text('Department :'),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              editDepartment,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
      
      
    );
  }
    Widget _editPreferenceTextField() {
    if (_isEditingText) {
      return Center(
        child: TextField(
          onSubmitted: (newValue) {
            setState(() {
              editPreference= newValue;
              _isEditingText = false;
            });
          },
          autofocus: true,
          controller: _editingPreferenceController,
        ),
      );
    }
    return InkWell(
      onTap: () {
        setState(() {
          _isEditingText = true;
        });
      },
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text('Preference :'),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              editPreference,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
      
      
    );
  }
}
