

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../ModelClass/DirectoryandFile/ModelClass.dart';
import '../../../../../StateManagement/GetxCOntroller.dart';
import 'AudioPlayer/audioplayer.dart';
import 'ImageViewer/imageviewer.dart';
import 'VideooPlayer/VideooPlayer.dart';

class OnTapFunctions{
  Model model;
  BuildContext context;
  OnTapFunctions(this.model,this.context);
  Controller controller = Get.put(Controller());
  var methodchannel = const MethodChannel("pdfchannel");
  Future<void> onTapped() async {
    if(model.file!.isImageFileName || model.file!.toLowerCase().endsWith("arw")){
      if(controller.onSelected.value){
        controller.selectedfiles.contains(model)
            ?(controller.selectedfiles.remove(model),
            controller.selectedfilesfull.value=false)
            :controller.selectedfiles.add(model);
      }
      else{
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageViewer(model.file!)));}
    }
    else if(model.file!.isVideoFileName){
      if(controller.onSelected.value){
        controller.selectedfiles.contains(model)
            ?(controller.selectedfiles.remove(model),
            controller.selectedfilesfull.value=false)
            :controller.selectedfiles.add(model);
      }
      else{
        Navigator.push(context, MaterialPageRoute(builder: (context)=>VideooPlayer(model.file!)));}

    }
    else if(model.file!.isAudioFileName){
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
    }
    else if(model.file!.isPDFFileName){
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
      }
    }
    else if(model.file!.isDocumentFileName){
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
    }
    else if(model.file!.isExcelFileName){
      if(controller.onSelected.value){
        controller.selectedfiles.contains(model)
            ?(controller.selectedfiles.remove(model),
            controller.selectedfilesfull.value=false)
            :controller.selectedfiles.add(model);
      }
      else {}

    }
    else if(model.file!.isPPTFileName){
      if(controller.onSelected.value){
        controller.selectedfiles.contains(model)
            ?(controller.selectedfiles.remove(model),
            controller.selectedfilesfull.value=false)
            :controller.selectedfiles.add(model);
      }
      else{


        var result = await methodchannel.invokeMethod("openPPT",{"path":model.file!});
      }
    }
    else if(model.file!.isAPKFileName){
      if(controller.onSelected.value){
        controller.selectedfiles.contains(model)
            ?(controller.selectedfiles.remove(model),
            controller.selectedfilesfull.value=false)
            :controller.selectedfiles.add(model);
      }
      else{}

    }
    else if(model.file!.isTxtFileName){
      if(controller.onSelected.value){
        controller.selectedfiles.contains(model)
            ?(controller.selectedfiles.remove(model),
            controller.selectedfilesfull.value=false)
            :controller.selectedfiles.add(model);
      }
      else{
        var result = await methodchannel.invokeMethod("openTxt",{"path":model.file!});
        print(result);
      }
    }
    else if(model.file!.toLowerCase().endsWith(".zip" )||model.file!.toLowerCase().endsWith("rar")){
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
            ));
      }
    }
    else{
      if(controller.onSelected.value){
        controller.selectedfiles.contains(model)
            ?(controller.selectedfiles.remove(model),
            controller.selectedfilesfull.value=false)
            :controller.selectedfiles.add(model);
      }
      else{
      }
    }
}
}