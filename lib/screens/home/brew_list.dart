import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coffe_app/model/brew.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  const BrewList({super.key});

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    var brews=Provider.of<List<BrewModel>?>(context);
   for (var element in brews!) {
    debugPrint(element.name);
    debugPrint(element.sugars);
    debugPrint(element.strength.toString());
   }
   
    return Container(
      color: Colors.brown[100],
      
    );
  }
}