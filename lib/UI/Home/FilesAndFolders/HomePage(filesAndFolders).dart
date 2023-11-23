

import 'package:filemaanager/UI/AppBar/Drawer.dart';
import 'package:filemaanager/UI/Home/FilesAndFolders/BodyComponents/ListOfFilesAndFolders.dart';
import 'package:filemaanager/UI/Home/FilesAndFolders/BodyComponents/MenuBar/Sortby.dart';
import 'package:filemaanager/UI/Home/FilesAndFolders/BodyComponents/Storage.dart';
import 'package:filemaanager/UI/Home/FilesAndFolders/BodyComponents/MenuBar/menu%20bar.dart';
import 'package:filemaanager/UI/Home/FilesAndFolders/BodyComponents/scrollview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../StateManagement/GetxCOntroller.dart';
import '../../AppBar/appbarr.dart';

class HomePageFilesAndFolders extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageFilesAndFoldersState();
  }

}

class  HomePageFilesAndFoldersState extends State<HomePageFilesAndFolders>{
  Controller controller = Get.put(Controller());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller.directoryfetcher();
    print("vissssss");
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(onWillPop: ()async{
                                     if(controller.onSelected.value){
                                         controller.onSelected.value=false;
                                         controller.removeall();
                                         return false;
                                         }
                                     else{
                                         if(controller.menubar.value|controller.sortby.value){
                                              controller.menubar.value=false;controller.sortby.value=false;
                                              return false;
                                             }
                                         else{return true;}}},
      child: GestureDetector(onTap: (){if(controller.menubar.value|controller.sortby.value){
                                           controller.menubar.value=false;controller.sortby.value=false;
      }},
        child: Scaffold(resizeToAvoidBottomInset:false,appBar: AppBar(automaticallyImplyLeading:false,
                                                         actions:[Obx(()=> Container(width: MediaQuery.of(context).size.width,
                                                                                     child:controller.onSelected.value
                                                                                           ?Row(mainAxisAlignment:MainAxisAlignment.spaceAround,
                                                                                                         children: [
                                                                                                           GestureDetector(child: const Icon(CupertinoIcons.xmark),
                                                                                                                                    onTap: (){controller.onSelected.value=false;
                                                                                                                                             controller.removeall();},),
                                                                                                           Text("Selected ${controller.selectedfiles.length} items",style: TextStyle(fontWeight: FontWeight.bold),),
                                                                                                           GestureDetector(child: Obx(()=> Icon(Icons.checklist,
                                                                                                                                                color: controller.selectedfiles.length==controller.list.length
                                                                                                                                                       ?Colors.blue:Colors.black,)
                                                                                                                                     ),
                                                                                                                           onTap: (){controller.selectedfilesfull.value
                                                                                                                                    ?({controller.removeall(),controller.selectedfilesfull.value=false})
                                                                                                                                    :({controller.selectedfiles.addAll(controller.list),controller.selectedfilesfull.value=true});
                                                                                                                                    },
                                                                                                                          ),
                                                                                                                  ],
                                                                                                )
                                                               :Row(children: [Container(width: MediaQuery.of(context).size.width/8,
                                                                                         child: Builder(builder: (context) {return GestureDetector(child: Icon(Icons.menu),
                                                                                                                                                   onTap: (){
                                                                                                                                                     controller.menubar.value=false;
                                                                                                                                                     controller.sortby.value=false;
                                                                                                                                                    Scaffold.of(context).openDrawer();},
                                                                                                                                                  );
                                                                                                                              }
                                                                                                          ),
                                                                                          ),
                                                                               AppBBar(),
                                                                               IconButton(onPressed: (){},icon: const Icon(CupertinoIcons.search))
                                                                                ],

                                                                     )),
                                                                           )
                                                              ]
                                   ),
                        drawer: Draawer(),
                          body: Stack(
                            children: [Container(height: MediaQuery.of(context).size.height,
                                                      child: Column(children: [SStorage(),
                                                                               WidgetScroller(),
                                                                               ListOfFilesAndFolders(),
                                                                              ],
                                                                    )
                                                  ),
                                       MenuBaar(),
                                       Sortby()
                                      ]
                          ),
            bottomNavigationBar: Obx(()=> controller.onSelected.value
                                         ? BottomAppBar(child: Padding(padding: const EdgeInsets.symmetric(horizontal:38.0),
                                                                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                            children: [Column(children: [Icon(CupertinoIcons.share),
                                                                                                                         Text("Send")],),
                                                                                                       Column(children: [Icon(CupertinoIcons.move),
                                                                                                                         Text("Move")],),
                                                                                                       Column(children: [Icon(Icons.delete_outline),
                                                                                                                         Text("Delete")],),
                                                                                                       GestureDetector(
                                                                                                         child: Column(children: [Icon(CupertinoIcons.ellipsis_circle),
                                                                                                                           Text("More")],),
                                                                                                         onTap: (){
                                                                                                           showModalBottomSheet(context: context,isScrollControlled: true, builder: (context)=>
                                                                                                               Padding(
                                                                                                                 padding:  EdgeInsets.only(top: 10.0,left: 10),
                                                                                                                 child:Container(height: MediaQuery.of(context).size.height/2.2,
                                                                                                                   child: ListView(children:  [
                                                                                                                     ListTile(title: Text("Make private"),),
                                                                                                                     ListTile(title: Text("Copy",)),
                                                                                                                     ListTile(title: Text("Add to favourites",)),
                                                                                                                     ListTile(title: Text("Rename",style:TextStyle(color:controller.selectedfiles.value.length>1
                                                                                                                                                                         ?Colors.black26
                                                                                                                                                                         :Colors.black)),
                                                                                                                         onTap:(){
                                                                                                                             if(controller.selectedfiles.value.length>1){}
                                                                                                                         }),
                                                                                                                     ListTile(title: Text("Compress")),
                                                                                                                     ListTile(title: Text("Open in another app",style:TextStyle(color:(controller.selectedfiles.value.length>1 || controller.dirCounter.value!=0)
                                                                                                                                                                                      ?Colors.black26
                                                                                                                                                                                      :Colors.black)),
                                                                                                                         onTap:(){
                                                                                                                             if(controller.selectedfiles.value.length>1 ||
                                                                                                                                controller.dirCounter.value!=0){}
                                                                                                                             else{
                                                                                                                               Navigator.pop(context);
                                                                                                                               showDialog(context: context, builder: (context)=>
                                                                                                                               Align(alignment: Alignment.bottomCenter,
                                                                                                                                      child: Card(
                                                                                                                                        child: Container(height: MediaQuery.of(context).size.height/3,

                                                                                                                                                         child:Column(children: [
                                                                                                                                                           Padding(
                                                                                                                                                             padding: const EdgeInsets.only(top: 15.0,bottom: 25),
                                                                                                                                                             child: Text("Select Type",style: TextStyle(fontWeight: FontWeight.bold),),
                                                                                                                                                           ),
                                                                                                                                                           ListTile(title: Text("> Docs",style: TextStyle(color: Colors.blue),),),
                                                                                                                                                           ListTile(title: Text("  Audio"),),
                                                                                                                                                           ListTile(title: Text("  Video"),),
                                                                                                                                                           ListTile(title: Text("  Images"),)],)),
                                                                                                                                      ),));
                                                                                                                             }
                                                                                                                         }),
                                                                                                                     ListTile(title: Text("Details",style:TextStyle(color:controller.selectedfiles.value.length>1
                                                                                                                                                          ?Colors.black26
                                                                                                                                                          :Colors.black)),
                                                                                                                         onTap:(){
                                                                                                                       if(controller.selectedfiles.value.length>1){}
                                                                                                                         }),
                                                                                                                   ],),
                                                                                                                 ),
                                                                                                               ) );
                                                                                                         },
                                                                                                       )
                                                                                                      ],
                                                                                   ),
                                                                       ),
                                                         )
                                        :Container(height: 1,width: 1,color: Colors.transparent,),
            )),
      ),
    );
  }
}