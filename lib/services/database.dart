import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_coffe_app/model/brew.dart';

class DatabaseService {
  var id;
  DatabaseService({this.id});
   final collection=FirebaseFirestore.instance.collection('brews');
   Future addUserData(String sugars,String name,int strength) async{
     return await collection.doc(id).set({
       'sugars':sugars,
       'name':name,
       'strength':strength
     });
   }
   List <BrewModel> _brewListFromSnapshot(QuerySnapshot snapshot){
     return snapshot.docs.map((doc) {
       return BrewModel(
         name: (doc.data() as dynamic)['name'] ?? '',
         strength: (doc.data() as dynamic)['strength'] ?? 0,
         sugars: (doc.data() as dynamic)['sugars'] ?? '0',
       );
     }).toList();
   }

   Future updateUserData(String sugars,String name,int strength) async{
     return await collection.doc(id).update({
       'sugars':sugars,
       'name':name,
       'strength':strength
     });
   }

   Future deleteUserData() async{
     return await collection.doc(id).delete();
   }
   Stream<List<BrewModel>> get brews{
     return collection.snapshots().map(_brewListFromSnapshot);
   }

  
}