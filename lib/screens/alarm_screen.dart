import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../services/constants.dart';
import '../services/time.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../services/navbar.dart';
import 'package:audioplayers/audio_cache.dart';

class AlarmScreen extends StatefulWidget {

  @override
  _AlarmScreenState createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  TimeOfDay _time = TimeOfDay.now();
  final player = AudioCache();
  AudioPlayer audioplayer = AudioPlayer(); // create this
  TimeOfDay picked;
  Timer timer;
  void playSound(TimeHandler alarm) async{
     audioplayer = await  player.loop('music/note2.wav', volume: 1, isNotification: true, stayAwake: true);
  }
  Future<TimeOfDay> selectTime(BuildContext context) async{
    picked = await showTimePicker(context: context, initialTime: _time);
    return picked;
  }
  void checkTime(){
    _time = TimeOfDay.now();
//    print(_time);
    for(int i =0; i<alarms.length; i++){
      if (alarms[i].hours == _time.hour && alarms[i].minutes == _time.minute){
        playSound(alarms[i]);
      }
    }
  }

  List<TimeHandler> alarms = [
    TimeHandler(hours: 5, minutes: 30, apm: "AM"),
  ];
  int selectedHours, selectedMinutes;

  void addAlarm(int hours, int minutes){
    String apm;
    if(hours >= 12)
      apm = "PM";
    else
      apm = "AM";
    alarms.add(TimeHandler(hours: hours, minutes: minutes, apm: apm));
  }

   ListView getAlarms(){
    return ListView.builder(
      itemCount: alarms.length,
        itemBuilder: (context, index){
      return Slidable(
        delegate: SlidableDrawerDelegate(),
        child: Container(
          padding: EdgeInsets.all(20.0),
              child: Text(
                'The alarm set for ${alarms[index].hours} : ${alarms[index].minutes} ${alarms[index].apm}',
                style: TextStyle(color: Color(0xFF918F8F), fontSize: 18.0, fontStyle: FontStyle.italic),
              ),
            ),
        secondaryActions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconSlideAction(
              color: Color(0xFFED5E76),
              icon: Icons.delete,
              onTap: (){
                setState(() {
                  alarms.removeAt(index);
                  audioplayer?.stop();
                  player.clear('music/note2.wav');
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconSlideAction(
              color: lightBlueColor,
              icon: Icons.stop,
              onTap: (){
                setState(() {
                  audioplayer?.stop();
                  player.clear('music/note2.wav');
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconSlideAction(
              color: lightPinkColor,
              icon: Icons.play_arrow,
              onTap: (){
                setState(() {
                  audioplayer.resume();
                  player.clear('music/note2.wav');
                });
              },
            ),
          ),

        ],
        );
    });

  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 30), (timer) => checkTime());
  }
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical :20.0, horizontal: 10.0),
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    'SET ALARM',
                    style: headingStyle,
                  ),
                ),
                SizedBox(height: 30.0,),
                 Expanded(
                   child: Container(
                     child: getAlarms(),
                   ),
                 ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await selectTime(context);
          setState(() {
            addAlarm(picked.hour, picked.minute);
          });
        },
        backgroundColor: lightBlackColor,
        child: Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
}



