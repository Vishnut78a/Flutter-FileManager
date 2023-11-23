


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnSelectedAppB extends StatefulWidget implements PreferredSizeWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OnselectedAppBState();
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();

}
class OnselectedAppBState extends State<OnSelectedAppB>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return AppBar(leading: Icon(CupertinoIcons.xmark),
       title: Text("Selected " " items"),centerTitle: true,
       actions: [ Padding(
         padding: const EdgeInsets.only(right:23.0),
         child: Icon(Icons.checklist),
       )])
  }

}