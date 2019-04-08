import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      body: Center(
          child: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(20),
                child: Text(
                  "CCC",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 60,color: Colors.blue),
                ),
              ),
              Container(
                child: Text(
                  "nielit CCC Exam Practice app",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: Text(
                  "Developed & Designed By",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Container(
                child:  Image.network(child: null,
                    'https://chedo.in/wp-content/uploads/2019/04/chedo.jpg'),,
              ),
              Container(
                margin: EdgeInsets.all(40),
                child: Text(
                  "We Provide Software development Service & C, C++, data structure, Python, Java, Mobile App Development Web Design, Video Editing, AutoCAD Computer Courses . to get more info or any query dont be shy to contact with us",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15,color: Colors.grey),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: Text(
                  "website : chedo.in",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
        ],
      )),
    );
  }
}
