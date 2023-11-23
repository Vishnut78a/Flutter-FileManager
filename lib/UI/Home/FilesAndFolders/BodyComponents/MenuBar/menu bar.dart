

import 'dart:io';

import 'package:filemaanager/ModelClass/DirectoryandFile/ModelClass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../StateManagement/GetxCOntroller.dart';



class MenuBaar extends StatefulWidget{
  @override
  State<MenuBaar> createState() => _MenuBaarState();
}

class _MenuBaarState extends State<MenuBaar> {
  Controller controller = Get.put(Controller());
  TextEditingController textEditingController =TextEditingController(text: "New Folder");
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Obx(
        ()=> Positioned(left: context.isPortrait?MediaQuery.of(context).size.width/2.3
                                               :MediaQuery.of(context).size.width/1.4,
                       right: context.isPortrait?MediaQuery.of(context).size.width/14
                                               :MediaQuery.of(context).size.width/30,
                        top: controller.directorylength.value==1
                                         ?context.isPortrait?MediaQuery.of(context).size.height/10
                                                            :MediaQuery.of(context).size.height/12.5
                                         :context.isPortrait?MediaQuery.of(context).size.height/30
                                                            :MediaQuery.of(context).size.height/12.5,
                     bottom: controller.directorylength.value==1
                                       ?context.isPortrait?MediaQuery.of(context).size.height/1.65
                                                          :MediaQuery.of(context).size.height/3.8
                                        :context.isPortrait? MediaQuery.of(context).size.height/1.5
                                                           :MediaQuery.of(context).size.height/3.8,
          child: Obx(()=>
          controller.menubar.value?
          Container(decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Shadow color
                spreadRadius: 5, // Spread radius
                blurRadius: 7, // Blur radius
                offset: Offset(0, 3), // Offset to control the position of the shadow
              ),
            ],
          ),
              /*width: MediaQuery.of(context).size.width/6,
                                                     height: MediaQuery.of(context).size.height/6,*/
              child:ListView(
                children: [ListTile(title: const Text("Sort by"),
                    onTap: (){
                      controller.menubar.value=false;
                      controller.sortby.value=true;
                    }),const Divider(height: 0,indent: 20,endIndent: 20,),
                  ListTile(title: const Text("Create folder"),
                           onTap: (){
                    controller.menubar.value=false;
                    controller.temporarysolution.value=true;
                    showDialog(context: context, builder: (context)=>

                        Align(alignment:Alignment.center,child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Card(
                            child: Container(width:context.isPortrait?MediaQuery.of(context).size.width
                                :MediaQuery.of(context).size.width/2.5
                              ,height:context.isPortrait?MediaQuery.of(context).size.height/3.7
                                  :MediaQuery.of(context).size.height/2,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 30.0),
                                      child: Center(child: Text("Create folder",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),),
                                    ),Padding(
                                      padding: const EdgeInsets.only(left:15.0,bottom: 22),
                                      child: Column(children: [
                                        const ListTile(title: Text("Enter folder name",style: TextStyle(fontSize: 14),),),
                                        ListTile(title: Container(height: 40,
                                          child: TextField(controller: textEditingController,
                                            decoration:
                                            const InputDecoration( contentPadding: EdgeInsets.symmetric(horizontal: 5),border: OutlineInputBorder()),),
                                        ),)
                                      ],),
                                    )

                                    ,const Divider(height: 0,),
                                    Row(
                                      children: [Expanded(child: TextButton(onPressed: (){Navigator.of(context).pop();
                                                                                           controller.temporarysolution.value=false;},
                                                                                child: const Text("Cancel"))),
                                        Expanded(
                                            child:TextButton(onPressed: (){var directory = Directory("${controller.directorylist.value[controller.directorylist.length-1].path}/${textEditingController.text}");
                                                                     print("zz"+directory.toString());
                                                                     print("zz"+controller.directorylist.value[0].toString());
                                                                            directory.existsSync()?print("already exists"):directory.create().then((_) =>  controller.list.add(Model(isDirectory: true,directory: directory.path)));

                                                                            Navigator.of(context).pop();
                                                                            controller.temporarysolution.value=false;
                                                                            }, child: const Text("OK"))),
                                      ],)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ))


                    ).then((value) {
                      textEditingController.text="New Folder";
                      print(controller.temporarysolution.value);
                      controller.temporarysolution.value=false;
                      print(controller.temporarysolution.value);
                   ;});
                  },),
                  const Divider(height: 0,indent: 20,endIndent: 20,),
                  ListTile(title: const Text("Don't show hidden files"),onTap: (){}),],))
              :Container()
          )),
      );
  }
}