

import 'package:filemaanager/UI/AppBar/Drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../AppBar/appbarr.dart';

import 'BodyComponenets/BodyforRecent.dart';


class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Home();
  }

}

class Home extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(appBar: AppBar(actions: [
                                          Container(width: MediaQuery.of(context).size.width/8),
                                          AppBBar(),
                                          IconButton(onPressed: (){}, icon: const Icon(CupertinoIcons.search))




                                             ],
                                   ),
                   drawer: Draawer(),
                    body: BodyForRecent(),);
  }

}