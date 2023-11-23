

import 'dart:io';

import 'package:filemaanager/UI/Home/FilesAndFolders/BodyComponents/scrollview.dart';
import 'package:filemaanager/UI/Home/FilesAndFolders/HomePage(filesAndFolders).dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../StateManagement/GetxCOntroller.dart';
import '../../../AppBar/Drawer.dart';
import '../../../AppBar/appbarr.dart';
import 'ListOfFilesAndFolders.dart';
import 'ListOfFilesAndFolders2.dart';
import 'MenuBar/Sortby.dart';
import 'MenuBar/menu bar.dart';

class OpenFolder extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OpenFolderState();
  }

}

class OpenFolderState extends State<OpenFolder>{
 Controller controller = Get.put(Controller());
@override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () async{
        if(controller.onSelected.value){
          controller.onSelected.value=false;
          controller.removeall();
          return false;
        }
        else
        {
          if(controller.directorylist.length == 2){
          print("Before removing");
          print(controller.directorylist.value);
          print("After removinggg");
          controller.directorylist.value = [];
          print(controller.directorylist.value);
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => HomePageFilesAndFolders()));
        }
        else {
          print("Before removing");
          print(controller.directorylist.value);
          print("After removing");
          controller.directorylist.removeAt(
              controller.directorylist.length - 1);
          print(controller.directorylist.value);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => OpenFolder()));
        }
        return true;
      }
        },
      child: Scaffold(appBar: AppBar(automaticallyImplyLeading:false,
                                                       actions:[Obx(()=>
                                                           Container(width: MediaQuery.of(context).size.width,
                                                                      child:controller.onSelected.value
                                                                  ?Row(mainAxisAlignment:MainAxisAlignment.spaceAround,
                                                                                children: [GestureDetector(child: const Icon(CupertinoIcons.xmark),
                                                                                                           onTap: (){controller.onSelected.value=false;
                                                                                                                     controller.removeall();},),
                                                                                           Text("Selected ${controller.selectedfiles.length} items",style: TextStyle(fontWeight: FontWeight.bold)),
                                                                                           GestureDetector(child: Obx(()=> Icon(Icons.checklist,
                                                                                                                               color: controller.selectedfiles.length==controller.list.length
                                                                                                                                      ?Colors.blue
                                                                                                                                      :Colors.black,)),
                                                                                                           onTap: (){controller.selectedfilesfull.value
                                                                                                                     ?({controller.removeall(),controller.selectedfilesfull.value=false})
                                                                                                                     :({controller.selectedfiles.addAll(controller.list),controller.selectedfilesfull.value=true});
                                                                                                                  },
                                                                                                         ),
                                                                                            ],
                                                                      )
                                                                   :Row(children: [Container(width: MediaQuery.of(context).size.width/8,
                                                                                             child: Builder(builder: (context) {
                                                                                                 return GestureDetector(child: Icon(Icons.menu),
                                                                                                                        onTap: (){Scaffold.of(context).openDrawer();},
                                                                                                                       );
                                                                                                                               }
                                                                                                            ),
                                                                                               ),
                                                                                     AppBBar(),
                                                                                     IconButton(onPressed: (){},
                                                                                                     icon: const Icon(CupertinoIcons.search)
                                                                                                  )
                                                                                    ],

                                                                         )),
                                                                                                                      )
                                                                                                                   ]
                                         ),

                        body: Stack(
                               children: [Container(height: MediaQuery.of(context).size.height,
                                                     child: Column(children: [WidgetScroller(),
                                                                             ListOfFilesAndFolders2(),
                                                                            ],
                                                       ),

                                          ),
                                        MenuBaar(),
                                        Sortby()],
                        ),
                       drawer:  Draawer(),
          bottomNavigationBar: Obx(()=> controller.onSelected.value
                                       ? const BottomAppBar(child: Padding(padding: EdgeInsets.symmetric(horizontal:38.0),
                                                                       child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                           children: [Column(children: [Icon(CupertinoIcons.share),
                                                                                                                        Text("Send")],),
                                                                                                      Column(children: [Icon(CupertinoIcons.move),
                                                                                                                        Text("Move")],),
                                                                                                      Column(children: [Icon(Icons.delete_outline),
                                                                                                                        Text("Delete")],),
                                                                                                      Column(children: [Icon(CupertinoIcons.ellipsis_circle),
                                                                                                                        Text("More")],)
                                                                                                     ],),
                                                                     ),
                                                     )
                                     :Container(height: 1,width: 1,color: Colors.transparent,),
                               )

                                ),
    );
  }

}