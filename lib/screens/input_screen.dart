import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import '../services/constants.dart';
import '../services/Database.dart';
import '../services/navbar.dart';


class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  Color _shade = Colors.pink;
  Color _tempMainColor = Colors.white;
  TextEditingController controller = TextEditingController();
  bool selection = false, bold = false, italic = false, underline = false;

  void _openDialog(String title, Widget content) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(6.0),
          title: Text('Pick your custom color'),
          content: content,
          actions: [
            FlatButton(
              child: Text('CANCEL'),
              onPressed: Navigator.of(context).pop,
            ),
            FlatButton(
              child: Text('SUBMIT'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() => _shade = _tempMainColor);
              },
            ),
          ],
        );
      },
    );
  }

  void _openMainColorPicker() async {
    _openDialog(
      "Main Color picker",
      MaterialColorPicker(
        colors: accentColors,
        selectedColor: _shade,
        allowShades: false,
        onMainColorChange: (color) => setState(() => _tempMainColor = color),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Color.fromARGB(0, 0, 0, 0),
        ),
        child: NavBarWidget(),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                color: Color(0xFFFFF2F2),
                borderRadius: BorderRadius.circular(18.0)),
            padding: EdgeInsets.all(40.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Tabs(
                        icon: 'B',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24.0),
                        onpress: () {
                          setState(() {
                            bold = bold ? false : true;
                          });
                        },
                      ),
                      Tabs(
                        icon: 'i',
                        style: TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 24.0),
                        onpress: () {
                          setState(() {
                            italic = italic ? false : true;
                          });
                        },
                      ),
                      Tabs(
                        icon: 'U',
                        style: TextStyle(
                            fontSize: 24.0,
                            decoration: TextDecoration.underline),
                        onpress: () {
                          setState(() {
                            underline = underline ? false : true;
                          });
                        },
                      ),
                      Tabs(
                        icon: '',
                        color: _shade,
                        onpress: () {
                          _openMainColorPicker();
                        },
                      ),
                    ],
                  ),
                  Card(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(18.0),
                        child: TextField(
                          controller: controller,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: bold ? FontWeight.bold : null,
                              decoration:
                                  underline ? TextDecoration.underline : null,
                              fontStyle: italic ? FontStyle.italic : null),
                          cursorColor: Color(0xFFC7D8F4),
                          keyboardType: TextInputType.multiline,
                          maxLines: 20,
                          decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                        ),
                      )),
                  RaisedButton(
                    color: Color(0xFFC7D8F4),
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                    onPressed: (){
                     Database().addNotes( controller.text,  '${_shade.value.toRadixString(16)}');
                     controller.clear();
                    },
                    child: Text(
                      'SAVE',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, '/notes');
        },
        child: Icon(Icons.dashboard, color: Colors.white,),
      ),
    );
  }
}

class Tabs extends StatelessWidget {
  final String icon;
  final TextStyle style;
  final Color color;
  final Function onpress;

  Tabs(
      {@required this.icon,
      this.style,
      this.color = Colors.white,
      this.onpress});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: IconButton(
        onPressed: onpress,
        icon: Text(icon, style: style),
      ),
    );
  }
}
