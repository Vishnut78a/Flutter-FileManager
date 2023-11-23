

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

class FileAndFolderMakerGrid extends StatefulWidget{
  Model model;

  FileAndFolderMakerGrid(this.model);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FileAndFolderMakerGridState(model);
  }

}

class FileAndFolderMakerGridState extends State<FileAndFolderMakerGrid>{
  var methodchannel = MethodChannel("pdfchannel");
  Model model;
  FileAndFolderMakerGridState(this.model);
  Controller controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(model.isDirectory){
      return InkWell(onTap: (){
        if(controller.onSelected.value){
          controller.selectedfiles.contains(model)
              ?(controller.selectedfiles.remove(model),
              controller.selectedfilesfull.value=false)
              :controller.selectedfiles.add(model);
        }else{controller.directorylength.value=model.directory!.length;
      print(controller.directorylength);
      print("Before adding");
      controller.directorylist.value.add(Directory(model.directory!));
      print("After adding");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OpenFolder()));
      }},
        child: GridTile(header: Align(alignment: Alignment.topRight,
          child: Obx(()=> Container(decoration: BoxDecoration(shape: BoxShape.circle,color: controller.onSelected.value?(controller.selectedfiles.contains(model)?Colors.blue:Colors.transparent):Colors.transparent,),
            child: controller.onSelected.value?(controller.selectedfiles.contains(model)?Icon(FontAwesomeIcons.circleCheck,color: Colors.white)
                :Icon(FontAwesomeIcons.circle))
               :null,
          )),
        ),
          child: Column(crossAxisAlignment:CrossAxisAlignment.center,
            children: [
              const Expanded(
                child: Icon(Icons.folder,
                  color:Colors.orangeAccent ,size: 60,),
              ),

              Expanded(
                child: Text(model.directory!.substring((controller.directorylist[controller.directorylist.length-1].path.length+1)),
                  overflow: TextOverflow.ellipsis,),
              ),
            ],),
        ),
      );
    }
    else{
      if(model.file!.isImageFileName|| model.file!.toLowerCase().endsWith("arw")){
        return GestureDetector(
          onTap: (){if(controller.onSelected.value){
            controller.selectedfiles.contains(model)
                ?(controller.selectedfiles.remove(model),
                controller.selectedfilesfull.value=false)
                :controller.selectedfiles.add(model);
          }else{
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageViewer(model.file!)));}},
          child: GridTile(header:Align(alignment: Alignment.topRight,
            child: Obx(()=> Container(decoration: BoxDecoration(shape: BoxShape.circle,color: controller.onSelected.value?(controller.selectedfiles.contains(model)?Colors.blue:Colors.transparent):Colors.transparent,),
              child: controller.selectedfiles.contains(model)?Icon(FontAwesomeIcons.circleCheck,color: Colors.white)
                  :Icon(FontAwesomeIcons.circle),
            )),
          ),
            child: Column(crossAxisAlignment:CrossAxisAlignment.center,children: [Expanded(child: const Icon(Icons.image,size: 50,color: Colors.pinkAccent,)),
            Expanded(child: Text(model.file!.substring(controller.directorylist[controller.directorylist.length-1].path.length+1),overflow:TextOverflow.ellipsis,))],)),
        );
      }
      else if(model.file!.isVideoFileName){
        return GestureDetector(onTap: (){
          if(controller.onSelected.value){
            controller.selectedfiles.contains(model)
                ?(controller.selectedfiles.remove(model),
                controller.selectedfilesfull.value=false)
                :controller.selectedfiles.add(model);
          }else{
          Navigator.push(context, MaterialPageRoute(builder: (context)=>VideooPlayer(model.file!)));
        } },
          child: GridTile(header:Align(alignment: Alignment.topRight,
            child: Obx(()=> Container(decoration: BoxDecoration(shape: BoxShape.circle,color: controller.onSelected.value?(controller.selectedfiles.contains(model)?Colors.blue:Colors.transparent):Colors.transparent,),
              child: controller.selectedfiles.contains(model)?Icon(FontAwesomeIcons.circleCheck,color: Colors.white)
                  :Icon(FontAwesomeIcons.circle),
            )),
          ),child: Column(crossAxisAlignment:CrossAxisAlignment.center,children: [Expanded(child: const Icon(Icons.play_circle,size: 50,color: Colors.purpleAccent,)),
            Expanded(child: Text(model.file!.substring(controller.directorylist[controller.directorylist.length-1].path.length+1),overflow:TextOverflow.ellipsis,))],)),
        );
      }
      else if(model.file!.isAudioFileName){
        return GestureDetector(onTap: (){
          if(controller.onSelected.value){
            controller.selectedfiles.contains(model)
                ?(controller.selectedfiles.remove(model),
                controller.selectedfilesfull.value=false)
                :controller.selectedfiles.add(model);
          }else{
          Navigator.push(context,MaterialPageRoute(builder: (context)=>AudiooPlayer(model.file!)));
        }},
          child: GridTile(header:Align(alignment: Alignment.topRight,
            child: Obx(()=> Container(decoration: BoxDecoration(shape: BoxShape.circle,color: controller.onSelected.value?(controller.selectedfiles.contains(model)?Colors.blue:Colors.transparent):Colors.transparent,),
              child: controller.selectedfiles.contains(model)?Icon(FontAwesomeIcons.circleCheck,color: Colors.white)
                  :Icon(FontAwesomeIcons.circle),
            )),
          ),child: Column(crossAxisAlignment:CrossAxisAlignment.center,children: [Expanded(child: const Icon(Icons.audio_file,size: 50,color: Colors.lightBlueAccent,)),
            Expanded(child: Text(model.file!.substring(controller.directorylist[controller.directorylist.length-1].path.length+1),overflow:TextOverflow.ellipsis,))],)),
        );
      }
      else if(model.file!.isPDFFileName){
        return GestureDetector( onTap: ()async{
          if(controller.onSelected.value){
            controller.selectedfiles.contains(model)
                ?(controller.selectedfiles.remove(model),
                controller.selectedfilesfull.value=false)
                :controller.selectedfiles.add(model);
          }else{
          print(model.file);
          var result=await methodchannel.invokeMethod("openpdf",{"path":model.file!});
          print(result);
        }},
          child: GridTile(header:Align(alignment: Alignment.topRight,
            child: Obx(()=> Container(decoration: BoxDecoration(shape: BoxShape.circle,color: controller.onSelected.value?(controller.selectedfiles.contains(model)?Colors.blue:Colors.transparent):Colors.transparent,),
              child: controller.selectedfiles.contains(model)?Icon(FontAwesomeIcons.circleCheck,color: Colors.white)
                  :Icon(FontAwesomeIcons.circle),
            )),
          ),child: Column(crossAxisAlignment:CrossAxisAlignment.center,children: [Expanded(child: const Icon(Icons.picture_as_pdf,size: 50,color: Colors.red,)),
            Expanded(child: Text(model.file!.substring(controller.directorylist[controller.directorylist.length-1].path.length+1),overflow:TextOverflow.ellipsis,))],)),
        );
      }
      else if(model.file!.isDocumentFileName){
        return GestureDetector(  onTap: () async {
          if(controller.onSelected.value){
            controller.selectedfiles.contains(model)
                ?(controller.selectedfiles.remove(model),
                controller.selectedfilesfull.value=false)
                :controller.selectedfiles.add(model);
          }else{
        var result = await methodchannel.invokeMethod("openDoc",{"path":model.file});
        print(result);
        }},
          child: GridTile(header:Align(alignment: Alignment.topRight,
            child: Obx(()=> Container(decoration: BoxDecoration(shape: BoxShape.circle,color: controller.onSelected.value?(controller.selectedfiles.contains(model)?Colors.blue:Colors.transparent):Colors.transparent,),
              child: controller.selectedfiles.contains(model)?Icon(FontAwesomeIcons.circleCheck,color: Colors.white)
                  :Icon(FontAwesomeIcons.circle),
            )),
          ),child: Column(crossAxisAlignment:CrossAxisAlignment.center,children: [Expanded(child: SvgPicture.asset("asset/icons8-word.svg")),
            Expanded(child: Text(model.file!.substring(controller.directorylist[controller.directorylist.length-1].path.length+1),overflow:TextOverflow.ellipsis,))],)),
        );
      }
      else if(model.file!.isExcelFileName){
        return GestureDetector(onTap: (){
          if(controller.onSelected.value){
            controller.selectedfiles.contains(model)
                ?(controller.selectedfiles.remove(model),
                controller.selectedfilesfull.value=false)
                :controller.selectedfiles.add(model);
          }else{}
        },
          child: GridTile(header:Align(alignment: Alignment.topRight,
            child: Obx(()=> Container(decoration: BoxDecoration(shape: BoxShape.circle,color: controller.onSelected.value?(controller.selectedfiles.contains(model)?Colors.blue:Colors.transparent):Colors.transparent,),
              child: controller.selectedfiles.contains(model)?Icon(FontAwesomeIcons.circleCheck,color: Colors.white)
                  :Icon(FontAwesomeIcons.circle),
            )),
          ),child: Column(crossAxisAlignment:CrossAxisAlignment.center,children: [Expanded(child:  SvgPicture.asset("asset/file-type-excel.svg")),
            Expanded(child: Text(model.file!.substring(controller.directorylist[controller.directorylist.length-1].path.length+1),overflow:TextOverflow.ellipsis,))],)),
        );
      }
      else if (model.file!.isPPTFileName){
        return GestureDetector( onTap: ()async{
          if(controller.onSelected.value){
            controller.selectedfiles.contains(model)
                ?(controller.selectedfiles.remove(model),
                controller.selectedfilesfull.value=false)
                :controller.selectedfiles.add(model);
          }else{
          var result = await methodchannel.invokeMethod("openPPT",{"path":model.file!});
        }},
          child: GridTile(header:Align(alignment: Alignment.topRight,
            child: Obx(()=> Container(decoration: BoxDecoration(shape: BoxShape.circle,color: controller.onSelected.value?(controller.selectedfiles.contains(model)?Colors.blue:Colors.transparent):Colors.transparent,),
              child: controller.selectedfiles.contains(model)?Icon(FontAwesomeIcons.circleCheck,color: Colors.white)
                  :Icon(FontAwesomeIcons.circle),
            )),
          ),child: Column(crossAxisAlignment:CrossAxisAlignment.center,children: [Expanded(child: SvgPicture.asset("asset/icons8-microsoft-powerpoint-2019.svg")),
            Expanded(child: Text(model.file!.substring(controller.directorylist[controller.directorylist.length-1].path.length+1),overflow:TextOverflow.ellipsis,))],)),
        );
      }
      else if(model.file!.isTxtFileName){
        return GestureDetector( onTap: ()async{
          if(controller.onSelected.value){
            controller.selectedfiles.contains(model)
                ?(controller.selectedfiles.remove(model),
                controller.selectedfilesfull.value=false)
                :controller.selectedfiles.add(model);
          }else {
            var result = await methodchannel.invokeMethod(
                "openTxt", {"path": model.file!});

          print(result);
        }},
          child: GridTile(header:Align(alignment: Alignment.topRight,
            child: Obx(()=> Container(decoration: BoxDecoration(shape: BoxShape.circle,color: controller.onSelected.value?(controller.selectedfiles.contains(model)?Colors.blue:Colors.transparent):Colors.transparent,),
              child: controller.selectedfiles.contains(model)?Icon(FontAwesomeIcons.circleCheck,color: Colors.white)
                  :Icon(FontAwesomeIcons.circle),
            )),
          ),child: Column(crossAxisAlignment:CrossAxisAlignment.center,children: [Expanded(child: SvgPicture.asset("asset/icons8-text.svg")),
            Expanded(child: Text(model.file!.substring(controller.directorylist[controller.directorylist.length-1].path.length+1),overflow:TextOverflow.ellipsis,))],)),
        );
      }

      else if(model.file!.isAPKFileName){
        return GestureDetector(onTap: (){
          if(controller.onSelected.value){
            controller.selectedfiles.contains(model)
                ?(controller.selectedfiles.remove(model),
                controller.selectedfilesfull.value=false)
                :controller.selectedfiles.add(model);
          }else{}
        },
          child: GridTile(header:Align(alignment: Alignment.topRight,
            child: Obx(()=> Container(decoration: BoxDecoration(shape: BoxShape.circle,color: controller.onSelected.value?(controller.selectedfiles.contains(model)?Colors.blue:Colors.transparent):Colors.transparent,),
              child: controller.selectedfiles.contains(model)?Icon(FontAwesomeIcons.circleCheck,color: Colors.white)
                  :Icon(FontAwesomeIcons.circle),
            )),
          ),child: Column(crossAxisAlignment:CrossAxisAlignment.center,children: [Expanded(child: const Icon(Icons.android,size: 50,color: Colors.greenAccent,)),
            Expanded(child: Text(model.file!.substring(controller.directorylist[controller.directorylist.length-1].path.length+1),overflow:TextOverflow.ellipsis,))],)),
        );
      }
      else if(model.file!.toLowerCase().endsWith(".zip" )||model.file!.toLowerCase().endsWith("rar")){
        return GestureDetector(
          child: GridTile(header:Align(alignment: Alignment.topRight,
            child: Obx(()=> Container(decoration: BoxDecoration(shape: BoxShape.circle,color: controller.onSelected.value?(controller.selectedfiles.contains(model)?Colors.blue:Colors.transparent):Colors.transparent,),
              child: controller.selectedfiles.contains(model)?Icon(FontAwesomeIcons.circleCheck,color: Colors.white)
                  :Icon(FontAwesomeIcons.circle),
            )),
          ),child: Column(crossAxisAlignment:CrossAxisAlignment.center,children: [Expanded(child: const Icon(Icons.folder_zip_sharp,color:Colors.yellow,size: 50,)),
            Expanded(child: Text(model.file!.substring(controller.directorylist[controller.directorylist.length-1].path.length+1),overflow:TextOverflow.ellipsis,))],)),
         onTap: (){
    if(controller.onSelected.value){
    controller.selectedfiles.contains(model)
    ?(controller.selectedfiles.remove(model),
    controller.selectedfilesfull.value=false)
        :controller.selectedfiles.add(model);
    }else{showDialog(context: context, builder: (context)=>
             Align(alignment: Alignment.bottomCenter,
               child: Card(child: Container(width:MediaQuery.of(context).size.width/1.05,
                 height: MediaQuery.of(context).size.height/4.5,
                 child: Column(children: [Padding(
                   padding: const EdgeInsets.only(top: 21.0,bottom: 28),
                   child: Text(model.file!.substring(controller.directorylist[controller.directorylist.length-1].path.length+1),
                     style: TextStyle(fontWeight: FontWeight.bold),),
                 ),
                   ListTile(title: Text("> Extract here" ,style: TextStyle(color: Colors.blue,fontSize: 14)),),ListTile(title: Text("  Extract to...",style: TextStyle(fontSize: 14),),)],),)),
             ));
         }},
        );
      }

      else{
        return GestureDetector(onTap: (){
          if(controller.onSelected.value){
            controller.selectedfiles.contains(model)
                ?(controller.selectedfiles.remove(model),
                controller.selectedfilesfull.value=false)
                :controller.selectedfiles.add(model);
          }else{}
        },
          child: GridTile(header:Align(alignment: Alignment.topRight,
            child: Obx(()=> Container(decoration: BoxDecoration(shape: BoxShape.circle,color: controller.onSelected.value?(controller.selectedfiles.contains(model)?Colors.blue:Colors.transparent):Colors.transparent,),
              child: controller.selectedfiles.contains(model)?Icon(FontAwesomeIcons.circleCheck,color: Colors.white)
                  :Icon(FontAwesomeIcons.circle),
            )),
          ),child: Column(crossAxisAlignment:CrossAxisAlignment.center,children: [Expanded(child: const Icon(Icons.file_copy_outlined,size: 50,)),
            Expanded(child: Text(model.file!.substring(controller.directorylist[controller.directorylist.length-1].path.length+1),overflow:TextOverflow.ellipsis,))],)),
        );
      }}

  }


}