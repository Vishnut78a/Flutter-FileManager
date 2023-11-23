
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../ModelClass/DirectoryandFile/ModelClass.dart';
import '../../../../../StateManagement/GetxCOntroller.dart';
import '../FileViewer/AudioPlayer/audioplayer.dart';
import '../FileViewer/ImageViewer/imageviewer.dart';
import '../FileViewer/VideooPlayer/VideooPlayer.dart';
import '../OpenFolder.dart';

class FileAndFolderMaker extends StatefulWidget{
  Model model;

  FileAndFolderMaker(this.model);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FileAndFolderMakerState(model);
  }

}

class FileAndFolderMakerState extends State<FileAndFolderMaker>{
  Model model;

  FileAndFolderMakerState(this.model);
  Controller controller = Get.put(Controller());
  var methodchannel = MethodChannel("pdfchannel");
  @override
  Widget build(BuildContext context) {
    print("Builddd");
    // TODO: implement build
    if(model.isDirectory){
      print("isDireeectory");
      return
      ListTile(leading: const Icon(
        Icons.folder, color: Colors.orangeAccent,
        size: 50,),
            title: Text(model.directory!
              .substring(controller
              .directorylist[controller.directorylist
              .length - 1].path.length + 1)),
          subtitle: const Row(children: [ Text(
              "ItemCount | "),
            Text("lastModified")],),
          trailing:  Obx(()=> Container(decoration:BoxDecoration(color: controller.onSelected.value?(controller.selectedfiles.contains(model)?Colors.blue:Colors.transparent):Colors.transparent,shape: BoxShape.circle,),
              child:controller.onSelected.value?(controller.selectedfiles.contains(model)?Icon(FontAwesomeIcons.circleCheck,color: Colors.white,)
                                                                                                                                          :Icon(FontAwesomeIcons.circle,))
                                                               :Icon(Icons.chevron_right))),
          onTap: () {
            if(controller.onSelected.value){
               controller.selectedfiles.contains(model)?(controller.selectedfiles.remove(model),
                                                         controller.selectedfilesfull.value=false)
                                                                 :controller.selectedfiles.add(model);


            }
            else {
              controller.directorylength.value = model.directory!.length;
              print(controller.directorylength.value);
              print("Before adding (PL)" +
                  controller.directorylist.toString());
              controller.directorylist.value.add(Directory(
                  model.directory!));
              print("After adding(PL)" +
                  controller.directorylist.toString());
              Navigator.pushReplacement(context,
                  MaterialPageRoute(
                      builder: (context) => OpenFolder()));
            }
            });
    }else{
      if(model.file!.isImageFileName || model.file!.toLowerCase().endsWith("arw")){
        return
          ListTile(leading: const Icon(
            Icons.image,
            color: Colors.pink, size: 50,),
            title: Text(
               model.file!.substring(
                    controller.directorylist[controller
                        .directorylist.length - 1].path
                        .length + 1)),
            subtitle: const Row(children: [ Text("ItemCount|"),
                                           Text("lastModified")],),
            trailing: Obx(()=> Container(decoration: BoxDecoration(shape: BoxShape.circle,color: controller.onSelected.value?(controller.selectedfiles.contains(model)?Colors.blue:Colors.transparent):Colors.transparent,),
              child: controller.selectedfiles.contains(model)?Icon(FontAwesomeIcons.circleCheck,color: Colors.white)
                                                                       :Icon(FontAwesomeIcons.circle),
            ),
            ),
            
            onTap: (){
              if(controller.onSelected.value){
                controller.selectedfiles.contains(model)
                    ?(controller.selectedfiles.remove(model),
                    controller.selectedfilesfull.value=false)
                    :controller.selectedfiles.add(model);
              }
              else{
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageViewer(model.file!)));}
              },
          );
      }else if(model.file!.isVideoFileName){
        return ListTile(leading:  const Icon(Icons.play_circle,color:Colors.purpleAccent,size: 50,),
          title: Text(model.file!.substring(controller.directorylist[controller.directorylist.length-1].path.length+1)),
          subtitle: const Row(children: [ Text("ItemCount|"),
            Text("lastModified")],),
          trailing: Obx(()=> Container(decoration: BoxDecoration(shape: BoxShape.circle,color: controller.onSelected.value?(controller.selectedfiles.contains(model)?Colors.blue:Colors.transparent):Colors.transparent,),
            child: controller.selectedfiles.contains(model)?Icon(FontAwesomeIcons.circleCheck,color: Colors.white)
                :Icon(FontAwesomeIcons.circle),
          ),
          ),
          onTap: (){
            if(controller.onSelected.value){
              controller.selectedfiles.contains(model)
                  ?(controller.selectedfiles.remove(model),
                  controller.selectedfilesfull.value=false)
                  :controller.selectedfiles.add(model);
            }
            else{
              Navigator.push(context, MaterialPageRoute(builder: (context)=>VideooPlayer(model.file!)));}


          },
        );

      }
      else if(model.file!.isAudioFileName){
        return  ListTile(leading:  const Icon(Icons.audio_file,color:Colors.blue,size: 50,),
          title: Text(model.file!.substring(controller.directorylist[controller.directorylist.length-1].path.length+1)),
          subtitle: const Row(children: [ Text("ItemCount|"),
            Text("lastModified")],),
          trailing: Obx(()=> Container(decoration: BoxDecoration(shape: BoxShape.circle,color: controller.onSelected.value?(controller.selectedfiles.contains(model)?Colors.blue:Colors.transparent):Colors.transparent,),
            child: controller.selectedfiles.contains(model)?Icon(FontAwesomeIcons.circleCheck,color: Colors.white)
                :Icon(FontAwesomeIcons.circle),
          ),
          ),
          onTap: (){
            if(controller.onSelected.value){
              controller.selectedfiles.contains(model)
                  ?(controller.selectedfiles.remove(model),
                  controller.selectedfilesfull.value=false)
                  :controller.selectedfiles.add(model);
            }
            else {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => AudiooPlayer(model.file!)));
            }
          },
        );
      }
      else if(model.file!.isPDFFileName){
        return ListTile(leading:  const Icon(Icons.picture_as_pdf,color:Colors.red,size: 50,),
          title: Text(model.file!.substring(controller.directorylist[controller.directorylist.length-1].path.length+1)),
          subtitle: const Row(children: [ Text("ItemCount|"),
            Text("lastModified")],),
          trailing: Obx(()=> Container(decoration: BoxDecoration(shape: BoxShape.circle,color: controller.onSelected.value?(controller.selectedfiles.contains(model)?Colors.blue:Colors.transparent):Colors.transparent,),
            child: controller.selectedfiles.contains(model)?Icon(FontAwesomeIcons.circleCheck,color: Colors.white)
                :Icon(FontAwesomeIcons.circle),
          ),
          ),
          onTap: ()async{
            if(controller.onSelected.value){
              controller.selectedfiles.contains(model)
                  ?(controller.selectedfiles.remove(model),
                  controller.selectedfilesfull.value=false)
                  :controller.selectedfiles.add(model);
            }
            else{

            print(model.file);
            var result=await methodchannel.invokeMethod("openpdf",{"path":model.file!});
            print(result);
          }},
        );
      }else if(model.file!.isDocumentFileName){
        return ListTile(leading:SvgPicture.asset("asset/icons8-word.svg"),
          title: Text(model.file!.substring(controller.directorylist[controller.directorylist.length-1].path.length+1)),
          subtitle: const Row(children: [ Text("ItemCount|"),
            Text("lastModified")],),
          trailing: Obx(()=> Container(decoration: BoxDecoration(shape: BoxShape.circle,color: controller.onSelected.value?(controller.selectedfiles.contains(model)?Colors.blue:Colors.transparent):Colors.transparent,),
            child: controller.selectedfiles.contains(model)?Icon(FontAwesomeIcons.circleCheck,color: Colors.white)
                :Icon(FontAwesomeIcons.circle),
          ),
          ),
          onTap: () async {
            if(controller.onSelected.value){
              controller.selectedfiles.contains(model)
                  ?(controller.selectedfiles.remove(model),
                  controller.selectedfilesfull.value=false)
                  :controller.selectedfiles.add(model);
            }
            else {
              var result = await methodchannel.invokeMethod(
                  "openDoc", {"path": model.file});
              print(result);
            }
          },
        );
      }
      else if(model.file!.isExcelFileName){
        return ListTile(leading: SvgPicture.asset("asset/file-type-excel.svg"),
          title: Text(model.file!.substring(controller.directorylist[controller.directorylist.length-1].path.length+1)),
          subtitle: const Row(children: [ Text("ItemCount|"),
            Text("lastModified")],),
          trailing:Obx(()=> Container(decoration: BoxDecoration(shape: BoxShape.circle,color: controller.onSelected.value?(controller.selectedfiles.contains(model)?Colors.blue:Colors.transparent):Colors.transparent,),
            child: controller.selectedfiles.contains(model)?Icon(FontAwesomeIcons.circleCheck,color: Colors.white)
                :Icon(FontAwesomeIcons.circle),
          ),
          ),
          onTap: (){
            if(controller.onSelected.value){
              controller.selectedfiles.contains(model)
                  ?(controller.selectedfiles.remove(model),
                  controller.selectedfilesfull.value=false)
                  :controller.selectedfiles.add(model);
            }
            else {}

          },
        );
      }
      else if(model.file!.isPPTFileName){
        return ListTile(leading: SvgPicture.asset("asset/icons8-microsoft-powerpoint-2019.svg"),
          title: Text(model.file!.substring(controller.directorylist[controller.directorylist.length-1].path.length+1)),
          subtitle: const Row(children: [ Text("ItemCount|"),
            Text("lastModified")],),
          trailing: Obx(()=> Container(decoration: BoxDecoration(shape: BoxShape.circle,color: controller.onSelected.value?(controller.selectedfiles.contains(model)?Colors.blue:Colors.transparent):Colors.transparent,),
            child: controller.selectedfiles.contains(model)?Icon(FontAwesomeIcons.circleCheck,color: Colors.white)
                :Icon(FontAwesomeIcons.circle),
          ),
          ),
          onTap: ()async{
            if(controller.onSelected.value){
              controller.selectedfiles.contains(model)
                  ?(controller.selectedfiles.remove(model),
                  controller.selectedfilesfull.value=false)
                  :controller.selectedfiles.add(model);
            }
            else{


            var result = await methodchannel.invokeMethod("openPPT",{"path":model.file!});
          }
            },
        );
      }
      else if(model.file!.isAPKFileName){
        return  ListTile(leading:  const Icon(Icons.android,color:Colors.greenAccent,size: 50,),
          title: Text(model.file!.substring(controller.directorylist[controller.directorylist.length-1].path.length+1)),
          subtitle: const Row(children: [ Text("ItemCount|"),
            Text("lastModified")],),
          trailing: Obx(()=> Container(decoration: BoxDecoration(shape: BoxShape.circle,color: controller.onSelected.value?(controller.selectedfiles.contains(model)?Colors.blue:Colors.transparent):Colors.transparent,),
            child: controller.selectedfiles.contains(model)?Icon(FontAwesomeIcons.circleCheck,color: Colors.white)
                :Icon(FontAwesomeIcons.circle),
          ),
          ),
          onTap: (){
            if(controller.onSelected.value){
              controller.selectedfiles.contains(model)
                  ?(controller.selectedfiles.remove(model),
                  controller.selectedfilesfull.value=false)
                  :controller.selectedfiles.add(model);
            }
            else{
              }

          },
        );

      }
      else if(model.file!.isTxtFileName){
        return  ListTile(leading:  SvgPicture.asset("asset/icons8-text.svg"),
          title: Text(model.file!.substring(controller.directorylist[controller.directorylist.length-1].path.length+1)),
          subtitle: const Row(children: [ Text("ItemCount|"),
            Text("lastModified")],),
          trailing: Obx(()=> Container(decoration: BoxDecoration(shape: BoxShape.circle,color: controller.onSelected.value?(controller.selectedfiles.contains(model)?Colors.blue:Colors.transparent):Colors.transparent,),
            child: controller.selectedfiles.contains(model)?Icon(FontAwesomeIcons.circleCheck,color: Colors.white)
                :Icon(FontAwesomeIcons.circle),
          ),
          ),
          onTap: ()async{
            if(controller.onSelected.value){
              controller.selectedfiles.contains(model)
                  ?(controller.selectedfiles.remove(model),
                  controller.selectedfilesfull.value=false)
                  :controller.selectedfiles.add(model);
            }
            else{


            var result = await methodchannel.invokeMethod("openTxt",{"path":model.file!});

            print(result);
          }},
        );
      }
      else if(model.file!.toLowerCase().endsWith(".zip" )||model.file!.toLowerCase().endsWith("rar") ){
        return  ListTile(leading:  const Icon(Icons.folder_zip_sharp,color:Colors.yellow,size: 50,),
          title: Text(model.file!.substring(controller.directorylist[controller.directorylist.length-1].path.length+1)),
          subtitle: const Row(children: [ Text("ItemCount|"),
            Text("lastModified")],),
          trailing: Obx(()=> Container(decoration: BoxDecoration(shape: BoxShape.circle,color: controller.onSelected.value?(controller.selectedfiles.contains(model)?Colors.blue:Colors.transparent):Colors.transparent,),
            child: controller.selectedfiles.contains(model)?Icon(FontAwesomeIcons.circleCheck,color: Colors.white)
                :Icon(FontAwesomeIcons.circle),
          ),
          ),
          onTap: (){
            if(controller.onSelected.value){
              controller.selectedfiles.contains(model)
                  ?(controller.selectedfiles.remove(model),
                  controller.selectedfilesfull.value=false)
                  :controller.selectedfiles.add(model);
            }
            else{

            showDialog(context: context, builder: (context)=>
          Align(alignment: Alignment.bottomCenter,
            child: Card(child: Container(width:MediaQuery.of(context).size.width/1.05,
              height: MediaQuery.of(context).size.height/4.5,
              child: Column(children: [Padding(
                padding: const EdgeInsets.only(top: 21.0,bottom: 28),
                child: Text(model.file!.substring(controller.directorylist[controller.directorylist.length-1].path.length+1),
                style: TextStyle(fontWeight: FontWeight.bold),),
              ),
                ListTile(title: Text("> Extract here" ,style: TextStyle(color: Colors.blue,fontSize: 14)),),ListTile(title: Text("  Extract to...",style: TextStyle(fontSize: 14),),)],),)),
          ));}
          },
        );
      }
      else{

        return ListTile(leading:  const Icon(Icons.file_copy_outlined,color:Colors.blueGrey,size: 50,),
          title: Text(model.file!.substring(controller.directorylist[controller.directorylist.length-1].path.length+1)),
          subtitle: const Row(children: [ Text("ItemCount|"),
            Text("lastModified")],),
          trailing: Obx(()=> Container(decoration: BoxDecoration(shape: BoxShape.circle,color: controller.onSelected.value?(controller.selectedfiles.contains(model)?Colors.blue:Colors.transparent):Colors.transparent,),
            child: controller.selectedfiles.contains(model)?Icon(FontAwesomeIcons.circleCheck,color: Colors.white)
                :Icon(FontAwesomeIcons.circle),
          ),
          ),
          onTap: (){
            if(controller.onSelected.value){
              controller.selectedfiles.contains(model)
                  ?(controller.selectedfiles.remove(model),
                  controller.selectedfilesfull.value=false)
                  :controller.selectedfiles.add(model);
            }
            else{
             }

          },

        );
      }
    }
  }
  }

