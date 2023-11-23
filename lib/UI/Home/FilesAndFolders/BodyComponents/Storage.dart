

import 'dart:io';




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../StateManagement/GetxCOntroller.dart';

class SStorage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return SStorageState();
  }

}

class SStorageState extends State<SStorage>{
  var total ;
  var channel = const MethodChannel("storage");
 Controller controller =Get.put(Controller());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPermission();
    storagedetails();
    getStorage();
    print(total);

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
                     height:MediaQuery.of(context).size.height/11,
                     child: ListTile(leading:Obx(()=>
                                                     Stack(alignment: AlignmentDirectional.center ,
                                                      children: [CircularProgressIndicator(           value: controller.free.value.isNotEmpty?(controller.free[1]/controller.free[0]):0,
                                                                                                      color: CupertinoColors.systemYellow,
                                                                                            backgroundColor: Colors.grey.shade200,
                                                                                                strokeWidth:2,
                                                                                          ),
                                                                 Text(controller.free.value.isNotEmpty?((((controller.free[1]/controller.free[0])*100)).toStringAsFixed(0)+"%")
                                                                                                      :"${0}%",
                                                                       style: const TextStyle(color: CupertinoColors.systemYellow,
                                                                                           fontSize: 10
                                                                                              ),
                                                                     )
                                                               ],
                                                      ),
                                                 ),
                                      title: const Text("Storage",
                                                         style: TextStyle(fontSize: 14),
                                                       ),
                                   subtitle: Obx(()=> Row(
                                                           children: [
                                                                      Text(controller.free.value.isNotEmpty?((controller.free[1]).toStringAsFixed(2)+"GB"+"/")
                                                                                                           :"",
                                                                          style: const TextStyle(color: CupertinoColors.systemYellow),
                                                                           ),
                                                                      Text(controller.free.value.isNotEmpty?((controller.free[0].toStringAsFixed(2)+"GB"))
                                                                                                           :"",
                                                                          style: const TextStyle(color: Colors.grey),
                                                                          )
                                                                     ],
                                                        ), ),
                                    trailing: Icon(Icons.chevron_right_sharp,
                                                   color: Colors.grey.shade300,
                                                   ),)) ;
  }


//Functions

//#1
getStorage()async{
    var result = await channel.invokeMethod("storagedetails") ;
    controller.free.value =result ;
    print(controller.free);
}


//#2
 Future<void> getPermission()async{
    if(await Permission.storage.status.isGranted){
      print(await Permission.storage.status);
    }
    else{
      Permission.storage.request();
    }
    if(await Permission.manageExternalStorage.status.isGranted){
      print(await Permission.manageExternalStorage.status);
    }
    else{Permission.manageExternalStorage.request();}


  }


  //
  // #3
  Future<void> storagedetails()async {
    Directory? appDocDir = await getExternalStorageDirectory();
    print(appDocDir);
    print(appDocDir?.statSync().type);
    print(appDocDir?.statSync().size);
    print(appDocDir?.statSync().changed);
     controller.available.value = appDocDir!.statSync().size;
     print(111);
     allFilesAndFolders(appDocDir.absolute);
     print(appDocDir.absolute.path);

  }

//#4
  void allFilesAndFolders(Directory directory){

      List<FileSystemEntity> entities = directory.listSync();
      print(222);
      print(entities.length);
      for (var entity in entities) {
        print(222);
        if (entity is File) {
          print('File: ${entity.path}');
        } else if (entity is Directory) {
          print('Directory: ${entity.path}');
          allFilesAndFolders(entity);
        }
      }


  }
    }






