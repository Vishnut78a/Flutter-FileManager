
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MediaContainer extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MediaContainerState();
  }

}

class MediaContainerState extends State<MediaContainer>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
                     height: MediaQuery.of(context).size.height/5,
                     child:  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [Column(
                                                        children: [
                                                            CircleAvatar(backgroundColor: Colors.greenAccent,
                                                                                                 child: Icon(CupertinoIcons.photo_fill, color: Colors.white,
                                                                                                   ),),
                                                          SizedBox(height:MediaQuery.of(context).size.height/100),
                                                            Text("Images",style: TextStyle(fontSize:12 )),
                                                          SizedBox(height:MediaQuery.of(context).size.height/50),

                                                          CircleAvatar(backgroundColor: Colors.green,
                                                            child: Icon(Icons.android, color: Colors.white,
                                                            ),),
                                                          SizedBox(height:MediaQuery.of(context).size.height/100),
                                                          Text("APKs",style: TextStyle(fontSize:12 )),

                                                                        ]),

                                                                      Column(
                                                                        children: [
                                                                          CircleAvatar(backgroundColor: Colors.deepOrangeAccent,
                                                                                                 child:Icon(CupertinoIcons.videocam_fill, color: Colors.white,),),
                                                                          SizedBox(height:MediaQuery.of(context).size.height/100),
                                                                          Text("Videos",style: TextStyle(fontSize:12 )),

                                                                          SizedBox(height:MediaQuery.of(context).size.height/50),
                                                                          CircleAvatar(backgroundColor: Colors.lightBlueAccent,
                                                                            child:Icon(Icons.download, color: Colors.white),),
                                                                          SizedBox(height:MediaQuery.of(context).size.height/100),
                                                                          Text("Bluetooth &\nDownloads",style: TextStyle(fontSize:12 ))


                                                                      ]),



                                                       Column(
                                                                children: [

                                                                  CircleAvatar(backgroundColor: Colors.purpleAccent,
                                                                    child:Icon(CupertinoIcons.doc_text_fill, color: Colors.white),),
                                                                  SizedBox(height:MediaQuery.of(context).size.height/100),
                                                                  Text("Docs",style: TextStyle(fontSize:12 )),

                                                                  SizedBox(height:MediaQuery.of(context).size.height/50),

                                                                  CircleAvatar(backgroundColor: Colors.green,
                                                                    child:Icon(Icons.call_rounded, color: Colors.white,),),
                                                                  SizedBox(height:MediaQuery.of(context).size.height/100),
                                                                  Text("WhatsApp",style: TextStyle(fontSize:12 ),),
                                                                                 ]
                                                                ),
                                                                           Column(
                                                                             children: [


                                                                               CircleAvatar(backgroundColor: Colors.pinkAccent,
                                                                                 child: Icon(CupertinoIcons.double_music_note, color: Colors.white,),),
                                                                               SizedBox(height:MediaQuery.of(context).size.height/100),
                                                                               Text("Music",style: TextStyle(fontSize:12 )),

                                                                               SizedBox(height:MediaQuery.of(context).size.height/50),


                                                                           Column(
                                                                             children: [
                                                                               CircleAvatar(backgroundColor: Colors.redAccent,
                                                                                                      child: Icon(CupertinoIcons.square_grid_2x2_fill, color: Colors.white,),),
                                                                               SizedBox(height:MediaQuery.of(context).size.height/100),
                                                                               Text("More",style: TextStyle(fontSize:12 ))
                                                                             ],
                                                                           )
                         ],
                       ),

                                                      ]));
  }
}