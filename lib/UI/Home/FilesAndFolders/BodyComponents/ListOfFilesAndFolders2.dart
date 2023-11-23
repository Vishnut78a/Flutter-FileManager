



import 'package:filemaanager/UI/Home/FilesAndFolders/BodyComponents/File&FolderMaker/file&foldermaker(gridview).dart';
import 'package:filemaanager/UI/Home/FilesAndFolders/BodyComponents/File&FolderMaker/file&foldermaker(listview).dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../ModelClass/DirectoryandFile/ModelClass.dart';
import '../../../../StateManagement/GetxCOntroller.dart';



class ListOfFilesAndFolders2 extends StatefulWidget{



  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return ListOfFilesAndFolders2State();
  }

}

class ListOfFilesAndFolders2State extends State<ListOfFilesAndFolders2>{

  var methodchannel = MethodChannel("pdfchannel");
  Controller controller = Get.put(Controller());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
      child:
      FutureBuilder<List<Model>>(future: controller.forwardlist(controller.directorylist.value[controller.directorylist.length-1]),
                                builder: ( context,  snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting) {

            return  Container(height: MediaQuery.of(context).size.height/1.25,
                               child: const Center(
                               child: Column(mainAxisAlignment:MainAxisAlignment.center,
                                                      children: [Icon(Icons.folder_outlined),
                                                                 Text("Just a sec..")],),
                ));
          }
          else if(snapshot.hasData){
            return Obx(()=>
              Container(height:MediaQuery.of(context).size.height,
                         child:controller.viewchanger.value
                             ?ListView.builder(itemCount :snapshot.data?.length,
                                              itemBuilder: (context, index)
                                              => GestureDetector(child: FileAndFolderMaker(snapshot.data![index]),
                                              onLongPress: (){controller.onSelected.value=true;},)
                                              )
                            : GridView.builder(gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 100,mainAxisSpacing:1 ,mainAxisExtent:100 ,crossAxisSpacing:1,childAspectRatio: 0.75 ),
                                                  itemCount: snapshot.data!.length,
                                                itemBuilder: (context,index)
                                               => GestureDetector(child: FileAndFolderMakerGrid(snapshot.data![index]),
                                               onLongPress: (){controller.onSelected.value=true;},)
                                             ),

                   ),
                 );
          }
          else if(snapshot.hasError){
            return Container(height: MediaQuery.of(context).size.height/1.25,
                              child: const Center(child:Column(mainAxisAlignment: MainAxisAlignment.center,
                                                                        children:[Icon(Icons.folder_outlined),
                                                                                  Text("Empty")],),
                                                ),
                       );
          }else{
            return const CircularProgressIndicator();
          }
        },),
    );
  }

}