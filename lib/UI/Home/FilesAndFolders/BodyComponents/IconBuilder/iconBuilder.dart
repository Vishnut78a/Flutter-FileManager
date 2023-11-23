

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../ModelClass/DirectoryandFile/ModelClass.dart';

class IconBuilder extends StatelessWidget{
  Model model;
   IconBuilder(this.model);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  if(model.isDirectory){
    return const Icon(Icons.folder, color: Colors.orangeAccent, size: 50,);}
  else{
    if(model.file!.isImageFileName || model.file!.toLowerCase().endsWith("arw")){
      return const Icon(Icons.image, color: Colors.pink, size: 50,);
    }
    else if(model.file!.isVideoFileName){
    return const Icon(Icons.play_circle,color:Colors.purpleAccent,size: 50,);

    }
    else if(model.file!.isAudioFileName){
    return  const Icon(Icons.audio_file,color:Colors.blue,size: 50,);
    }
    else if(model.file!.isPDFFileName){
    return const Icon(Icons.picture_as_pdf,color:Colors.red,size: 50,);

    }
    else if(model.file!.isDocumentFileName){
    return SvgPicture.asset("asset/icons8-word.svg");

    }
    else if(model.file!.isExcelFileName){
    return  SvgPicture.asset("asset/file-type-excel.svg");

    }
    else if(model.file!.isPPTFileName){
    return SvgPicture.asset("asset/icons8-microsoft-powerpoint-2019.svg");

    }
    else if(model.file!.isAPKFileName){
    return  const Icon(Icons.android,color:Colors.greenAccent,size: 50,);


    }
    else if(model.file!.isTxtFileName){
    return SvgPicture.asset("asset/icons8-text.svg");

    }
    else if(model.file!.toLowerCase().endsWith(".zip" )||model.file!.toLowerCase().endsWith("rar") ){
    return  const Icon(Icons.folder_zip_sharp,color:Colors.yellow,size: 50,);

    }
    else{

    return const Icon(Icons.file_copy_outlined,color:Colors.blueGrey,size: 50,);

  }
  }

}}