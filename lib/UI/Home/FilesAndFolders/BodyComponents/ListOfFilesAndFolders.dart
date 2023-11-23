



import 'dart:io';

import 'package:filemaanager/UI/Home/FilesAndFolders/BodyComponents/File&FolderMaker/file&foldermaker(gridview).dart';
import 'package:filemaanager/UI/Home/FilesAndFolders/BodyComponents/FileViewer/OnTapFunctions.dart';
import 'package:filemaanager/UI/Home/FilesAndFolders/BodyComponents/IconBuilder/iconBuilder.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../ModelClass/DirectoryandFile/ModelClass.dart';
import '../../../../StateManagement/GetxCOntroller.dart';

import 'OpenFolder.dart';

class ListOfFilesAndFolders extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ListOfFilesAndFoldersState();
  }

}

class ListOfFilesAndFoldersState extends State<ListOfFilesAndFolders>{
  var methodchannel = MethodChannel("pdfchannel");
  Controller controller = Get.put(Controller());

  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     print(111111123333);
    return
       Expanded(child:

        Obx(()=>        controller.list.isNotEmpty?
                         Container(height: MediaQuery.of(context).size.height/1.25,
                                    child: controller.viewchanger.value
                                        ?
                                        NotificationListener<ScrollNotification>(
                                          onNotification: (ScrollNotification notification){
                                            if(notification is ScrollStartNotification){
                                              controller.menubar.value=false;
                                              controller.sortby.value=false;
                                              return false;
                                            }
                                            else{
                                              return false;
                                            }
                                          },
                                          child: ListView.builder(itemCount: controller.list.length,
                                                                itemBuilder: (context, index)
                                                         =>GestureDetector(child: ListTile(leading: IconBuilder(controller.list[index]),
                                                                                             title: Text(controller.list[index].isDirectory?controller.list[index].directory!.substring(controller.directorylist[controller.directorylist.length - 1].path.length + 1)
                                                                                                                                          :controller.list[index].file!.substring(controller.directorylist[controller.directorylist.length - 1].path.length + 1)),
                                                                                          subtitle:  const Row(children: [ Text("ItemCount | "), Text("lastModified")],),
                                                                                          trailing: Obx(()=> Container(decoration:BoxDecoration(color: controller.onSelected.value?(controller.selectedfiles.contains(controller.list[index])?Colors.blue:Colors.transparent)
                                                                                                                                                                                   :Colors.transparent,
                                                                                                                                                shape: BoxShape.circle,),
                                                                                                                            child:controller.onSelected.value
                                                                                                                                  ?
                                                                                                                                  (controller.selectedfiles.contains(controller.list![index])
                                                                                                                                        ?Icon(FontAwesomeIcons.circleCheck,color: Colors.white,)
                                                                                                                                        :Icon(FontAwesomeIcons.circle,))
                                                                                                                                  :
                                                                                                                                   Icon(Icons.chevron_right))),
                                                                                            onTap:() {  if(controller.menubar.value|controller.sortby.value){
                                                                                                           controller.menubar.value=false;
                                                                                                           controller.sortby.value=false;
                                                                                                       }else{
                                                                                                        if(controller.onSelected.value){
                                                                                                            controller.selectedfiles.contains(controller.list[index])?{controller.selectedfiles.remove(controller.list[index]),
                                                                                                                                                                      controller.list[index].isDirectory?(controller.dirCounter>0?controller.dirCounter--:null)
                                                                                                                                                                                                        :null,
                                                                                                                                                                       controller.selectedfilesfull.value=false,}
                                                                                                                                                                    :{controller.selectedfiles.add(controller.list[index]),
                                                                                                                                                                     controller.list[index].isDirectory?controller.dirCounter++:null};
                                                                                                                 }
                                                                                                         else {
                                                                                                          if(controller.list[index].isDirectory){
                                                                                                          controller.directorylength.value = controller.list[index].directory!.length;
                                                                                                              print(controller.directorylength.value);
                                                                                                              print("Before adding (PL)${controller.directorylist}");
                                                                                                         controller.directorylist.value.add(Directory(controller.list[index].directory!));
                                                                                                            print("After adding(PL)${controller.directorylist}");
                                                                                                         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OpenFolder()));
                                                                                                          }else{
                                                                                                            OnTapFunctions(controller.list[index], context).onTapped();
                                                                                                          }
                                                                                                         }
                                                                                                    }}
                                                                                                                                                ),
                                                                    onLongPress: (){
                                                                      controller.menubar.value=false;
                                                                      controller.sortby.value=false;
                                                                      controller.onSelected.value=true;},)
                                                         ),
                                        )

                                        :
                                            NotificationListener<ScrollNotification>(
                                              onNotification: (ScrollNotification scrollNotification){
                                                if(scrollNotification is ScrollStartNotification){
                                                  controller.menubar.value=false;
                                                  controller.sortby.value=false;
                                                  return false;
                                                }else{
                                                  return false;
                                                }
                                              },
                                              child: GridView.builder(gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 100,mainAxisSpacing:1 ,mainAxisExtent:100 ,crossAxisSpacing:1,childAspectRatio: 0.75 ),
                                                                  itemCount: controller.list.length,
                                                                itemBuilder: (context,index)
                                                   =>GestureDetector(child: FileAndFolderMakerGrid(controller.list[index]),

                                                                 onLongPress: (){controller.menubar.value=false;
                                                                                controller.sortby.value=false;
                                                                                controller.onSelected.value=true;},)
                                                  ),
                                            ),


                                 )
                      :


                  Container(height: MediaQuery.of(context).size.height/1.25,
                                      child: const Center(
                                                        child:Column(mainAxisAlignment: MainAxisAlignment.center,
                                                                              children:[Icon(Icons.folder_outlined),
                                                                                        Text("Empty")],),
                      ),
                    ))

                );}



              }






/*
Expanded(
      child: Obx(()=>
         FutureBuilder(future: getExternalDirectory(),
                             builder: (BuildContext context, AsyncSnapshot snapshot) {
                                     if(snapshot.hasData) {
                                                controller.directorylist=snapshot.data as RxList;
                                                return Obx(()=>
                                                   ListView.builder(itemCount :controller.directorylist.length,
                                                                         itemBuilder: (context, index) =>
                                                                             ListTile(leading: Icon(Icons.folder),
                                                                                        title: Text("Name"),
                                                                                     subtitle: Row(children: [ Text("Item Count |"),
                                                                                                               Text("DateModified")],),
                                                                                     trailing: Icon(Icons.chevron_right))),
                                                );
                                                        }
                                     else if(snapshot.connectionState==ConnectionState.waiting){
                                           return Expanded(child: Column(children: [Icon(Icons.folder_outlined),
                                                                                    Text("Just a sec..")],));
                                                     }
                                    else{
                                          return Expanded(child: Column(children: [Icon(Icons.folder_outlined),
                                                             Text("Empty")],));
                                        }
                                },),
      ),
    )
 */

/*
Container(height: MediaQuery.of(context).size.height/1.25,
                child: Center(
                  child:Column(mainAxisAlignment: MainAxisAlignment.center,
                              children:[Icon(Icons.folder_outlined),
                                        Text("Empty")],),
                ),
              )
 */