





import 'package:filemaanager/UI/Home/FilesAndFolders/BodyComponents/OpenFolder.dart';
import 'package:filemaanager/UI/Home/FilesAndFolders/HomePage(filesAndFolders).dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../StateManagement/GetxCOntroller.dart';

class WidgetScroller extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WidgetScrollerState();
  }
  
}

class WidgetScrollerState extends State<WidgetScroller>{
  Controller controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {print(controller.directorylist.value.toString()+'df');
    // TODO: implement build
    return   Container(height:MediaQuery.of(context).size.height/21,
                          child:
                             Row(
                               children: [
                                 Expanded(
                                   child: Obx(()=>

                                        ListView.builder( scrollDirection: Axis.horizontal,
                                                                itemCount: controller.directorylist.length,
                                                              itemBuilder: ( context, index)=>

                                                    TextButton(onPressed: (){
                                                     if(index==controller.directorylist.length-1)
                                                     {
                                                     }
                                                     else if(index==0){
                                                       Navigator.pushReplacement(context,
                                                                                 MaterialPageRoute(builder: (context)
                                                                                         =>HomePageFilesAndFolders()));
                                                     }
                                                     else{
                                                       controller.directorylist.removeRange(index+1,controller.directorylist.length);
                                                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)
                                                                                                =>OpenFolder()));
                                                       print(2);
                                                     }
                                                   },
                                                                 child: Text(index==0?"Internal shared storage >"
                                                                                    :"${controller.directorylist[index].path.
                                                                      substring(controller.directorylist[index-1].path.length+1)} >"),

                                                   ),
                                                 ),

                                              ),
                                 ),
                                  Obx(()=>
                                     InkWell(child: controller.viewchanger.value?const Icon(Icons.grid_view_rounded,)
                                                                               :const Icon(Icons.list),
                                            onTap:(){controller.viewchanger.value?controller.viewchanger.value=false
                                                                                 :controller.viewchanger.value=true;
                                                  } ,),
                                  ),
                                 Padding(padding:const EdgeInsets.only(right: 23,left: 10),
                                         child: GestureDetector(child: const Icon(Icons.more_vert),
                                                                onTap: (){controller.menubar.value=true;
                                                                         controller.onSelected.value=false;
                                                                         controller.removeall();},
                                          ))

                               ],
                             ),



                          );

  }
}


/*
 PopupMenuButton(position:PopupMenuPosition.over ,
                                               constraints:BoxConstraints(maxWidth: MediaQuery.of(context).size.width/2.05,),
                                                                           padding:EdgeInsets.symmetric(horizontal: 18),
                                                                       itemBuilder: (context)
                                                                                      =>[PopupMenuItem(height:40,padding:EdgeInsets.only(right: MediaQuery.of(context).size.width/20,left: MediaQuery.of(context).size.width/20,
                                                                                                        ),
                                                                                                         child:Container(alignment:AlignmentDirectional.centerStart,
                                                                                                                         child: Text("Sort by"),
                                                                                                                         ),

                                                                                      ),PopupMenuItem(padding: EdgeInsets.only(right: MediaQuery.of(context).size.width/20,left: MediaQuery.of(context).size.width/20),child: Container(alignment:Alignment.centerLeft,child: Text("Create folder"),)),
                                                                                        PopupMenuItem(height:35,padding: EdgeInsets.only(right: MediaQuery.of(context).size.width/20,left:MediaQuery.of(context).size.width/20),child: Container(alignment:Alignment.centerLeft,child: Text("Don't show hidden files"),))]),

 child: Column(crossAxisAlignment:CrossAxisAlignment.start,
                                                                                                                                                  children: [Padding(padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width/18,
                                                                                                                                                                                                top: MediaQuery.of(context).size.width/50,
                                                                                                                                                                                             bottom:MediaQuery.of(context).size.width/28.6 ),
                                                                                                                                                                                              child: const Text("Sort by"),
                                                                                                                                                                      ),
                                                                                                                                                             Padding(padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width/18,
                                                                                                                                                                                                top: MediaQuery.of(context).size.width/28.6,
                                                                                                                                                                                             bottom:MediaQuery.of(context).size.width/28.6 ),
                                                                                                                                                                                              child: const Text("Create folder"),
                                                                                                                                                                    ),
                                                                                                                                                            Padding(padding:   EdgeInsets.only(left:MediaQuery.of(context).size.width/18,
                                                                                                                                                                                                top: MediaQuery.of(context).size.width/28.6,
                                                                                                                                                                                             bottom:MediaQuery.of(context).size.width/30 ),
                                                                                                                                                                                              child: const Text("Don't show hidden files"),
                                                                                                                                                                      )
                                                                                                                                                  ],),
 */