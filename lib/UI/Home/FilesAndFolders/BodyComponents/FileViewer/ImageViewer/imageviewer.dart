


import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../../StateManagement/GetxCOntroller.dart';

class ImageViewer extends StatelessWidget{
  String file;
  ImageViewer(this.file);
  Controller controller = Get.put(Controller());
  var methodChannel = const MethodChannel("share");


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Obx(()=>
      Scaffold(extendBody: true,
        extendBodyBehindAppBar: true,
                   appBar: controller.imageinterface.value?AppBar(title: const Text("Data"),
                                                                  backgroundColor: Colors.white,
                                                                )
                                                          :AppBar(automaticallyImplyLeading: false,
                                                                            backgroundColor: Colors.transparent,),
                     body: GestureDetector(onTap: (){
                                                 controller.InterfaceValuechanger();
                                          },
                     child: Container(alignment:Alignment.center,
                                         height: MediaQuery.of(context).size.height,
                                          color: Colors.transparent,
                                          child: Image.file(File(file)),
                                     ),
        ),
        bottomNavigationBar: controller.imageinterface.value? BottomAppBar(color:Colors.white,
                                                                           child: Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                                                                                              children: [GestureDetector(child:const Icon(CupertinoIcons.share),
                                                                                                                         onTap:(){
                                                                                                                        var result = methodChannel.invokeMethod("sharemedia",{"path":file});
                                                                                                                         print(result);
                                                                                                                          },),
                                                                                                         const Icon(FontAwesomeIcons.edit),
                                                                                                         const Icon(Icons.delete_outlined),
                                                                                                         GestureDetector(child: const Icon(CupertinoIcons.ellipsis_circle),
                                                                                                                         onTap:(){
                                                                                                           showModalBottomSheet(context: context, builder: (context)=>
                                                                                                                   Padding(
                                                                                                                     padding: const EdgeInsets.only(top: 10.0,left: 10),
                                                                                                                     child:ListView(children:  const [
                                                                                                                       ListTile(title: Text("Add to album",        style: TextStyle(fontWeight: FontWeight.bold)) ,),
                                                                                                                       ListTile(title: Text("Recognise text",      style: TextStyle(fontWeight: FontWeight.bold)),),
                                                                                                                       ListTile(title: Text("Adjust",              style: TextStyle(fontWeight: FontWeight.bold)),),
                                                                                                                       ListTile(title: Text("Protective Watermark",style: TextStyle(fontWeight: FontWeight.bold)),),
                                                                                                                       ListTile(title: Text("Set as wallpaper",    style: TextStyle(fontWeight: FontWeight.bold)),),
                                                                                                                       ListTile(title: Text("Start slideshow",     style: TextStyle(fontWeight: FontWeight.bold)),),
                                                                                                                       ListTile(title: Text("Rename",              style: TextStyle(fontWeight: FontWeight.bold)),),
                                                                                                                       ListTile(title: Text("Details",             style: TextStyle(fontWeight: FontWeight.bold)),),
                                                                                                                     ],),
                                                                                                                   ) );
                                                                                                                         },),
                                                                                                         ],
                                                                                      ),
                                                                          )
                                                              :const BottomAppBar(color: Colors.transparent,),
                ),
              );
  }

}