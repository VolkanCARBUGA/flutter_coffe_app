import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coffe_app/model/brew.dart';
import 'package:flutter_coffe_app/screens/home/brew_list.dart';
import 'package:flutter_coffe_app/services/auth_services.dart';
import 'package:flutter_coffe_app/services/database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
var firebaseAuthservices=AuthServices();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<BrewModel>?>.value(
      value: DatabaseService().brews,
      initialData: [],
      child: Scaffold(
       // backgroundColor: Colors.brown,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Kahve Dünyası',style: GoogleFonts.kaushanScript(fontSize: 50.0, fontWeight: FontWeight.bold,color: Colors.brown),),
          elevation: 0.0,
          actions: <Widget>[
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                   ),
               
              ),
              icon: Icon(Icons.person,color: Colors.brown,size: 30,fill: 1,),
              label: Text('LogOut',style: GoogleFonts.kaushanScript(color: Colors.brown,fontSize: 20.0, fontWeight: FontWeight.bold),),
              onPressed: () async {
         await firebaseAuthservices.signOut();
      
         
              },
            )
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}