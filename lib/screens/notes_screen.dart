import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../services/navbar.dart';

class NotesScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Color.fromARGB(0, 0, 0, 0),
        ),
        child: NavBarWidget(),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Notes(),
          ],
        ),
      )
    );
  }
}

class Notes extends StatelessWidget {
   bool isDark = false;

  hexStringToHexInt(String hex) {
    hex = hex.length == 6 ? 'ff' + hex : hex;
    int val = int.parse(hex, radix: 16);
    return val;
  }

  bool colorShadeDetect(int color){
    var rgb = color;   // convert rrggbb to decimal
    var r = (rgb >> 16) & 0xff;  // extract red
    var g = (rgb >>  8) & 0xff;  // extract green
    var b = (rgb >>  0) & 0xff;  // extract blue

    var luma = 0.2126 * r + 0.7152 * g + 0.0722 * b; // per ITU-R BT.709
    print(luma);
    if (luma >= 40) {
      // pick a different colour
      isDark = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('notes').snapshots(),
      builder: (context, snapshot){
        List<Container> noteCard = [];
        if (snapshot.hasData == false) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.pink,
            ),
          );
        }
        final notes = snapshot.data.documents;
        for (var note in notes){
          final text = note.data['note'];
          final color= hexStringToHexInt(note.data['color']);
//          colorShadeDetect(color);
          final card =  Container(
            width: MediaQuery.of(context).size.width / 2,
            height: 100.0,
            child: GestureDetector(
              onTap: (){
                print("clicked");
              },
              child: Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: Color(color),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(text, style: TextStyle(fontSize: 18.0, color: isDark ? Colors.white: Colors.black54),),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)
                ),
              ),
            )
          );
          noteCard.add(card);
        }

        return Expanded(
          child: ListView(
            children: noteCard,
          ),
        );
      },
    );
  }
}
