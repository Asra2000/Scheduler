import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../services/navbar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(children: <Widget>[
           Container(
             width: width,
             height: height,
             color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Align(
                    child: SvgPicture.asset(
                    'assets/images/img1.svg',
                    ),
                    alignment: Alignment(0.9, -0.9),
                  ),
                  Align(
                    child: SvgPicture.asset(
                      'assets/images/img3.svg',
                    ),
                    alignment: Alignment(-1, 0.6),
                  ),
                  Align(
                    child: SvgPicture.asset(
                      'assets/images/img2.svg',
                    ),
                    alignment: Alignment(-1, 0.8),
                  ),
                  Align(
                  child: SvgPicture.asset(
                    'assets/images/img4.svg',
                    alignment: Alignment.bottomCenter,
                  ),
                    alignment: Alignment(1.0, 1.0),
                  )
                ],
              ),
            ),

      ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: height*0.2,),
              Container(
                margin: EdgeInsets.only(left: width*0.2),
                width: width*0.6,
                height: height*0.3,
                color: Color(0x50D7D7D7),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('Write and let \nthe magic \nbegin..', style: TextStyle(fontSize: 20.0, letterSpacing: 1.5,color: Colors.grey[700]),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: width* 0.2, top: width*0.3),
                child: RaisedButton(
                  color:Color(0xFF001F37) ,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal:50.0, vertical: 20.0),
                  onPressed: (){
                    Navigator.pushNamed(context, '/note');
                  },
                  child: Text('GO', style: TextStyle( color: Colors.white, fontSize: 20.0),),
                ),
              )
            ],
          ),
    ]),
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Color.fromARGB(0, 0, 0, 0),
        ),
        child: NavBarWidget(),
      ),
    );
  }
}

