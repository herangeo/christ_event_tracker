import 'package:christ_event_tracker/events_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class FirebaseAuthservice{

  FirebaseAuth _auth=FirebaseAuth.instance;

  Future<User?> signupWithEmailAndPassword(String email,String password) async{

    try{
      UserCredential credential=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }
    catch(e)
    {
      print(e);
    }
    return null;
  }


    Future<User?> signinWithEmailAndPassword(String email,String password) async{

    try{
      UserCredential credential=await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }
    catch(e)
    {
      
      print("Some error Occured");
    }
    return null;
  }
}

class FirestoreService{

  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  final CollectionReference events = FirebaseFirestore.instance.collection('events');



  Future<void> addusers(String name,String email,String department,String password,String preference){
    return users.add({
      'user':name,
      'email':email,
      'department':department,
      'password':password,
      'preference':preference
    }) ;
  }
  
  Future<void> addevents(String name,String department,String venue,String date,String time,String preference,String link){
    return events.add({
      'event':name,
      'department':department,
      'venue':venue,
      'date':date,
      'time':time,
      'preference':preference,
      'link':link,
    }) ;
  }


  Future<List<EventCardModel>> getEventsFromFirebase() async {
    QuerySnapshot querySnapshot = await events.get();
    List<EventCardModel> eventList = [];
    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      eventList.add(EventCardModel(
        title: data['event'] ?? '',
        venue: data['venue'] ?? '',
        department: data['department'] ?? '',
        date: data['date'] ?? '',
        time: data['time'] ?? '',
        link:data['link']  ?? '',
        imageUrl: data['imageUrl'] ?? 'https://www.ghacks.net/wp-content/uploads/2023/08/AI-generated-art-copyright.jpg',
      ));
    });
    return eventList;
  }
  
}