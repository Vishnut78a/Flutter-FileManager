

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../../StateManagement/GetxCOntroller.dart';

class Sortby extends StatefulWidget{

   @override
  State<Sortby> createState() => SortbyState();
}


class SortbyState extends State<Sortby>{
  Controller controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Positioned(left: context.isPortrait ?MediaQuery.of(context).size.width / 1.8
                                               :MediaQuery.of(context).size.width / 1.4,
                     right: context.isPortrait ?MediaQuery.of(context).size.width / 14
                                               :MediaQuery.of(context).size.width / 30,
                       top: context.isPortrait ?MediaQuery.of(context).size.height / 10
                                               :MediaQuery.of(context).size.height / 12.5,
                    bottom: context.isPortrait ?MediaQuery.of(context).size.height / 2.24
                                               :MediaQuery.of(context).size.height / 3.8,
                     child: Obx(() =>
                           controller.sortby.value ? Container(decoration: BoxDecoration(
                                                                    color: Colors.white,
                                                                boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), // Shadow color
                                                                               spreadRadius: 5, // Spread radius
                                                                                 blurRadius: 7, // Blur radius
                                                                                     offset: Offset(0, 3), // Offset to control the position of the shadow
                                                                                      ),
                                                                           ],
                                                                                       ),
                                                                    child: ListView(children: const [ListTile(title: Text("Name"),),
                                                                                                             Divider(height: 0, indent: 20, endIndent: 20,),
                                                                                                     ListTile(title: Text("Bigger to smaller")),
                                                                                                             Divider(height: 0, indent: 20, endIndent: 20,),
                                                                                                     ListTile(title: Text("Smaller to bigger"),),
                                                                                                             Divider(height: 0, indent: 20, endIndent: 20,),
                                                                                                     ListTile(title: Text("Type"),),
                                                                                                             Divider(height: 0, indent: 20, endIndent: 20,),
                                                                                                     ListTile(title: Text("Modification time"),)
                                                                                                    ],),)
                                                 : Container()
        ));
  }
  }