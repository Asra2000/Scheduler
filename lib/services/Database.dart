import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Database{
  final _firestore = Firestore.instance;
  void addNotes(String text, String color) async{
      if (text != "")
      await  _firestore.collection('notes').add({'note': text, 'color': color});
  }
  void deleteNotes(String id) async{
    await _firestore.collection('notes').document(id).delete();
  }
}