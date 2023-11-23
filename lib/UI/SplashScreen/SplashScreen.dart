
import 'package:filemaanager/UI/SplashScreen/Splashservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../StateManagement/GetxCOntroller.dart';

class SplashScreen extends StatefulWidget{



  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Controller controller = Get.put(Controller());
  @override
  void initState() {

    super.initState();

    Splashservices splashservices = Splashservices(context);
    splashservices.enterapp();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: SafeArea(
                              child: Container(child: Center(child: Icon(CupertinoIcons.folder_fill,
                                                                         size: 80,
                                                                         color: Colors.white
                                ,)),
                                               color: Colors.orange,),
    ));
  }
}