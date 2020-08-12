import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import '../services/navbar.dart';
import '../services/constants.dart';



class Scheduler extends StatefulWidget {
  @override
  _SchedulerState createState() => new _SchedulerState();
}

class _SchedulerState extends State<Scheduler> {


  static String noEventText = "No events here";
  String calendarText = noEventText;
  DateTime _currentDate = DateTime.now();

  TextEditingController _controller = TextEditingController();

//  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

//  Future showNotificationWithoutSound() async {
//    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
//        'your channel id', 'your channel name', 'your channel description',
//        playSound: false, importance: Importance.Max, priority: Priority.High);
//    var iOSPlatformChannelSpecifics =
//    new IOSNotificationDetails(presentSound: false);
//    var platformChannelSpecifics = new NotificationDetails(
//        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.show(
//      0,
//      'New Post',
//      'How to Show Notification in Flutter',
//      platformChannelSpecifics,
//      payload: 'No_Sound',
//    );
//  }

  Future onSelectionNotification(String payload)async{
    showDialog(context: context,
        builder: (_) => AlertDialog(
          title: const Text('Here is ur playload'),
          content: Text("payload: $payload"),
        ));
  }

  @override
  void initState() {
    super.initState();
//    var initializationSettingAndroid = AndroidInitializationSettings('app_icon');
//    var initializationSettingIOS = new IOSInitializationSettings();
//    var initializationSettings = InitializationSettings(initializationSettingAndroid, initializationSettingIOS);
//
//    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//    flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: onSelectionNotification);

    _markedDateMap.add(
        new DateTime(2019, 1, 25),
        new Event(
          date: new DateTime(2019, 1, 25),
          title: 'Event 5',
          icon: _eventIcon,
        ));

    _markedDateMap.add(
        new DateTime(2019, 1, 10),
        new Event(
          date: new DateTime(2019, 1, 10),
          title: 'Event 4',
          icon: _eventIcon,
        ));

    _markedDateMap.addAll(new DateTime(2019, 1, 11), [
      new Event(
        date: new DateTime(2019, 1, 11),
        title: 'Event 1',
        icon: _eventIcon,
      ),
      new Event(
        date: new DateTime(2019, 1, 11),
        title: 'Event 2',
        icon: _eventIcon,
      ),
      new Event(
        date: new DateTime(2019, 1, 11),
        title: 'Event 3',
        icon: _eventIcon,
      ),
    ]);
    super.initState();
  }

  showDialogBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'What do you want to remember?'),
                    ),
                    SizedBox(
                      width: 320.0,
                      child: RaisedButton(
                        onPressed: () async{
//                          await showNotificationWithoutSound();
                          setState(() {
                            _markedDateMap.add(_currentDate, Event(date: _currentDate, title: _controller.text, icon: _eventIcon));
                            _currentDate  = DateTime.now();
                          });
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: const Color(0xFF1BC0C5),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Color.fromARGB(0, 0, 0, 0),
        ),
        child: NavBarWidget(),
      ),
      appBar: AppBar(
        title: Text(
          'Mark the Date',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Card(
              child:  CalendarCarousel(
            weekendTextStyle: TextStyle(
              color: Colors.red,
            ),
            weekFormat: false,
            selectedDateTime: _currentDate,
            selectedDayBorderColor: Colors.lightBlue,
            markedDatesMap: _markedDateMap,
            selectedDayButtonColor: Colors.lightBlue,
            selectedDayTextStyle: TextStyle(color: Colors.white),
            todayBorderColor: Colors.transparent,
            weekdayTextStyle: TextStyle(color: Color(0xFFED5E76)),
            height: 420.0,
            daysHaveCircularBorder: true,
            todayButtonColor: Color(0xFFED5E76),
            onDayPressed: (DateTime date, List<Event> events) {
              this.setState(() => refresh(date));
            },
          )),
          GestureDetector(
            onLongPress: (){
              setState(() {
                _markedDateMap.remove(_currentDate, _markedDateMap.getEvents(_currentDate)[0]);
                calendarText = noEventText;
              });
            },
            child: Card(
              child: Container(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.flag),
                        Text(
                          calendarText,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{

          showDialogBox();
        },
        backgroundColor: lightBlackColor,
        child: Icon(Icons.add, color: Colors.white,),
      ),
    );
  }

  void refresh(DateTime date) {
    _currentDate = date;
    if (_markedDateMap
        .getEvents(new DateTime(date.year, date.month, date.day))
        .isNotEmpty) {
      calendarText = _markedDateMap
          .getEvents(new DateTime(date.year, date.month, date.day))[0]
          .title;
    } else {
      calendarText = noEventText;
    }
  }
}

EventList<Event> _markedDateMap = EventList<Event>(events: {
  DateTime(2019, 1, 24): [
    Event(
      date: new DateTime(2019, 1, 24),
      title: 'BirthDay',
      icon: _eventIcon,
    )
  ]
});

Widget _eventIcon = new Container(
  decoration: new BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(1000)),
      border: Border.all(color: Colors.red, width: 2.0)),
  child: new Icon(
    Icons.person,
    color: Colors.amber,
  ),
);




