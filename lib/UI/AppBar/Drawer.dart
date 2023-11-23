
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../StateManagement/GetxCOntroller.dart';

class Draawer extends StatefulWidget{
  @override
  State<Draawer> createState() => DraawerState();
}

class DraawerState extends State<Draawer> {
  bool t = false;
  Controller controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer( child: Padding(
      padding: const EdgeInsets.only(top: 25),
      child: ListView(children:[
                                                    const ListTile(leading: Icon(Icons.devices_sharp),
                                                                     title: Text("Remote"),),
                                                    const ListTile(leading: Icon(Icons.monitor_outlined),
                                                                     title: Text("FTP"),),
                                                    const ListTile(leading: Icon(FontAwesomeIcons.infinity),
                                                                     title: Text("Transfer files"),),
                                                    const ListTile(leading: Icon(Icons.cleaning_services_sharp),
                                                                     title: Text("Deep clean"),),
                                                    const ListTile(leading: Icon(Icons.favorite_outline_sharp),
                                                                     title: Text("Favourites"),),
                                                    const ListTile(leading: Icon(Icons.lock_outline_sharp),
                                                                     title: Text("Private files"),),
                                                          ListTile(leading: const Icon(Icons.dark_mode_outlined),
                                                                     title: const Text("Dark mode"),
                                                                  trailing: Switch(value: t,
                                                                               onChanged:(v){setState(() {
                                                                                 t=v;
                                                                               });},
                                                                     activeTrackColor: Colors.blue,),
                                                                             ),
                                                    const ListTile(leading: Icon(Icons.settings_outlined),
                                                                     title: Text("Setting"),)




      ],),
    ),);
  }
}