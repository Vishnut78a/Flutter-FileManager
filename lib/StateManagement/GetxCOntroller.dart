
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../ModelClass/DirectoryandFile/ModelClass.dart';

class Controller extends GetxController{
  var channel = const MethodChannel("storage");
  var directorychannel = MethodChannel("ExternalDirectory");

  /*



  RxList<FileSystemEntity> directorylist = <FileSystemEntity>[].obs;
  RxList<File> files=<File>[].obs;
  RxList<Model> fileAnddirectory=<Model>[].obs;
  RxList<Model> openFolder=<Model>[].obs;
  RxList<Model> tempOpenFolder=<Model>[].obs;
  RxList<Model> tempholder = <Model>[].obs;
*/RxBool viewchanger             =true.obs;                       //Grid<->List
  RxInt directorylength          =0.obs;
  RxBool color                   = true.obs;
  RxInt available                = 0.obs;
  RxList<dynamic> free           = [].obs;
  RxString externaldirectory     =" ".obs;
  RxList<Model> list             = <Model>[].obs;
  RxList<Model> tempfiles        = <Model>[].obs;
  RxList<Directory> directorylist= <Directory>[].obs;
  RxBool menubar                 =false.obs;
  RxBool sortby                  =false.obs;
  RxBool temporarysolution       =false.obs;

  //Media
  RxBool imageinterface          =false.obs;

  InterfaceValuechanger(){
  imageinterface.value?imageinterface.value=false
                      :imageinterface.value=true;
  }
  //AppBar
  RxBool onSelected              =false.obs;
  RxBool check                   =false.obs;
  RxSet<Model> selectedfiles    =<Model>{}.obs;
  RxBool selectedfilesfull      =false.obs;
  RxInt dirCounter         =0.obs;
  void removeall(){
    selectedfiles.value={};
  }
  void toggleselectedfiles(){
    selectedfilesfull.value?selectedfilesfull.value=false:selectedfilesfull.value=true;
  }

  //FilesAndFolders
  Future<List<Model>> forwardlist(Directory tapped)async{

    list.value= await [];

    List<FileSystemEntity> l = tapped.listSync();int e =0,f=1;

    for(FileSystemEntity i in l){
      if(i is Directory){print (f);
        list.add(Model(directory: i.path));
         f++;

      }
      else{ print(e);
        tempfiles.add(Model(file:i.path,isDirectory: false));
        e++;
      }
    }

    list.value.addAll(tempfiles.value);
    tempfiles.value=[];
    print(list.value.toString()+"V");

    return list.value;
  }

  Future<List<Model>> directoryfetcher()async{
    print(999);

    list.value=[];

    print(23423);
    var result =  await directorychannel.invokeMethod("ListOfExternalDirectory");
    externaldirectory.value=result as String;
    directorylist.value=[];
    directorylist.value.add(Directory(result));

    print("directory fectcher11"+directorylist.value.toString());
    List<FileSystemEntity> l = Directory(result).listSync();
    for(FileSystemEntity i in l){
      if(i is Directory){
        list.add(Model(directory: i.path));
      }
      else{

        tempfiles.add(Model(file:i.path,isDirectory: false));
      }
    }
    list.value.addAll(tempfiles.value);
    tempfiles.value=[];

    print(directorylist.toString()+"11");
    print(externaldirectory.toString()+"11");

    return list.value;

  }
  //dsfsdf
/*
  Future<List<Model>> getExternalDirectoryfromDirectory(String direct)async{
    openFolder.value=[];

    List<FileSystemEntity> list = Directory(direct).listSync();
    print(list);
    for(FileSystemEntity entity in list){


      if(entity is Directory){

        openFolder.value.add(Model(directory:Directory(entity.path),
            file: File(entity.path),

            itemCount: entity.path.length.toString()));



      }
      else{

        tempOpenFolder.value.add(Model(directory:Directory(entity.path),
            file:File(entity.path),
            isDirectory: false,

            itemCount: File(entity.path).length().toString()));
        print("printttt"+fileAnddirectory.value[0].itemCount);
      }
    }
    openFolder.addAll(tempOpenFolder);
    tempOpenFolder.value=[];
    directorylist.value=list;
    print(list);
    return openFolder.value;

  }


  Future<List<Model>> getExternalDirectory()async{

    var result = await channel.invokeMethod("ListOfExternalDirectory");
    List<FileSystemEntity> list = Directory(result).listSync();
     print("print");
    for(FileSystemEntity entity in list){


      if(entity is Directory){

        fileAnddirectory.value.add(Model(directory:Directory(entity.path),
                                        file: File(entity.path),

                                         itemCount: entity.path.length.toString()));



      }
      else{

        tempholder.value.add(Model(directory:Directory(entity.path),
                                        file:File(entity.path),
                                 isDirectory: false,

                                   itemCount: File(entity.path).length().toString()));
        print("printttt"+fileAnddirectory.value[0].itemCount);
      }
    }
     fileAnddirectory.addAll(tempholder);
     directorylist.value=list;
     print(list);
     return fileAnddirectory.value;

  }


 Future<List<Model>> getDirectoriesForFutureBuilder()async{
    return fileAnddirectory;
  }
  Future<List<Model>> getDirectoriesForFutureBuilder2()async{
    return openFolder;
  }*/
}