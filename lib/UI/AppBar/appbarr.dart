import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../StateManagement/GetxCOntroller.dart';

class AppBBar extends StatelessWidget{


Controller controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                             children: [

                                           InkWell(
                                            onTap:(){if(!controller.color.value){
                                                     Navigator.pushReplacementNamed(context,"/home");
                                                     controller.color.value=true;}else{}} ,
                                            child:Obx(()=>
                                                 Icon(CupertinoIcons.clock,
                                                      color:controller.color.value?Colors.blue:Colors.black),
                                          ),
                                        ),

                                           InkWell(
                                            onTap:(){if(controller.color.value){
                                                     Navigator.pushReplacementNamed(context,"/homepagefilesandfolders");
                                                     controller.color.value=false;}else{} },
                                            child:Obx(()=>Icon(Icons.folder_open,
                                                               color:controller.color.value?Colors.black:Colors.blue   ),
                                          ),
                                        ),
                                        ]
      ),
    );
  }

}