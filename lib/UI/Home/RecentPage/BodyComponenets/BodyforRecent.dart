
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MediaContainer.dart';

class BodyForRecent extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BodyForRecentState();
  }

}

class BodyForRecentState extends State<BodyForRecent>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body:SingleChildScrollView(child: Column(children: [MediaContainer()],),));
  }

}