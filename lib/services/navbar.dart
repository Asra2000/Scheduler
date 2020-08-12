import 'package:flutter/material.dart';
import 'constants.dart';

class NavBarWidget extends StatelessWidget {
  const NavBarWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          SizedBox(height: 50.0,),
          ListTile(
            title: Text('MY PLANNER', style: TextStyle(color:Color(0xFFF9CBCB), fontSize: 24.0, letterSpacing: 7.0 )),
          ),
          SizedBox(height: 20.0,),
          ListTile(
            title: Text('Notes', style: textNavStyle),
            onTap: (){
              Navigator.pushNamed(context, '/');
              },
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1.0,horizontal: 15.0),
            child: Divider(color: Color(0xFFF9CBCB), height: 13,),
          ),
          ListTile(
            title: Text('Schedule', style: textNavStyle),
            onTap: (){Navigator.pushNamed(context, '/schedule');},
          ),
          ListTile(
            title: Text('Alarm', style: textNavStyle),
            onTap: (){
              Navigator.pushNamed(context, '/alarm');
            },
          ),
        ],
      ),
    );
  }
}
