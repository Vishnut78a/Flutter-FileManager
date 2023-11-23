


import 'dart:io';

import 'package:filemaanager/StateManagement/GetxVideoController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideooPlayer extends StatefulWidget{
  String videofile;

  VideooPlayer(this.videofile);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return VideooPlayerState(videofile);
  }
}

class VideooPlayerState extends State<VideooPlayer>{
  String videofile;

  double beforemuting=0;

  VideooController vcontroller = Get.put(VideooController());
  VideooPlayerState(this.videofile);
  late ValueNotifier<double> slidervaluenotifier= ValueNotifier<double>(0.0);
  late VideoPlayerController videoPlayerController;
  var methodchannel = MethodChannel("share");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoPlayerController = VideoPlayerController.file(File(videofile))..setLooping(vcontroller.loop.value)..initialize().then((value) =>{setState(() {})}).then((value) => videoPlayerController.play());
    videoPlayerController.addListener(() {vcontroller.slidervalue.value=videoPlayerController.value.position.inSeconds.toDouble();

                                             vcontroller.hour.value=videoPlayerController.value.position.inHours;
                                             vcontroller.minute.value=videoPlayerController.value.position.inMinutes;
                                             vcontroller.second.value=videoPlayerController.value.position.inSeconds.remainder(60);
                                             videoPlayerController.value.isPlaying?vcontroller.pause.value=true
                                                                                  :vcontroller.pause.value=false;


                                          });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(onWillPop: ()async{
                                         vcontroller.pause.value=true;
                                         vcontroller.speaker.value=true;
                                        await videoPlayerController.dispose();
                                        return true;
                                        },
                            child:
                                  Scaffold(

                                          body: GestureDetector(onTap: (){
                                                                          vcontroller.viewchanger.value?vcontroller.viewchanger.value=false
                                                                                                       :vcontroller.viewchanger.value=true;
                                                                         },
                                          child: Container(color:CupertinoColors.black,
                                                          height: MediaQuery.of(context).size.height,
                                                           width: MediaQuery.of(context).size.width,
                                                           child: Obx(()=>
                                                               Stack(alignment: Alignment.center,
                                                                      children:[AspectRatio(aspectRatio:videoPlayerController.value.aspectRatio,
                                                                                                  child: VideoPlayer(videoPlayerController)
                                                                                           ),

                                                                                vcontroller.viewchanger.value
                                                                                    ?Positioned(top:20,
                                                                                              child: Container(height: MediaQuery.of(context).size.height/10,
                                                                                                                width: MediaQuery.of(context).size.width,
                                                                                                                child: Row(children: [const Icon(Icons.arrow_back,
                                                                                                                                                 color:Colors.white
                                                                                                                                                 ),
                                                                                                                                      Expanded(child: Container()),
                                                                                                                                      const Icon(Icons.cast_rounded,
                                                                                                                                                 color: Colors.white
                                                                                                                                                  ),
                                                                                                                                      PopupMenuButton(color:Colors.white,
                                                                                                                                          itemBuilder: (context)
                                                                                                                                                                     => [PopupMenuItem(height:20,padding:const EdgeInsets.only(left:20) ,
                                                                                                                                                                                         child: Container(width: MediaQuery.of(context).size.width/2,

                                                                                                                                                                                                            child: Row(children: [const Text("Loop video"),
                                                                                                                                                                                                                                  Expanded(child: Container()),
                                                                                                                                                                                                                                  Obx(()=>
                                                                                                                                                                                                                                     Checkbox(value: vcontroller.loop.value,
                                                                                                                                                                                                                                         onChanged: (v){
                                                                                                                                                                                                                                          vcontroller.loop.value=v!;
                                                                                                                                                                                                                                          vcontroller.loop.value?videoPlayerController.setLooping(true)
                                                                                                                                                                                                                                                                :videoPlayerController.setLooping(false);
                                                                                                                                                                                                                                         }),
                                                                                                                                                                                                                                  )],),
                                                                                                                                                                                                          ),
                                                                                                                                                                                     ),
                                                                                                                                                                       const PopupMenuItem(padding: EdgeInsets.only(left: 20),
                                                                                                                                                                                             child: Text("Help and feedback")
                                                                                                                                                                                           )
                                                                                                                                                                         ]
                                                                                                                                                     )

                                                                                                                                    ],
                                                                                                                         ),
                                                                                                            )

                                                                                             )
                                                                                   :Container(height: 1,width: 1,color:Colors.blue),
                                                                                vcontroller.viewchanger.value
                                                                                    ? Positioned(top:50,
                                                                                              bottom:100,
                                                                                                left:50,
                                                                                               right:50,
                                                                                               child: Container(child: Center(child: IconButton(icon:Obx(()=> Icon(vcontroller.pause.value?CupertinoIcons.pause_circle_fill
                                                                                                                                                                                          :CupertinoIcons.play_circle_fill,
                                                                                                                                                                   size: 40,
                                                                                                                                                                  color: Colors.white
                                                                                                                                                                  )
                                                                                                                                                         ),
                                                                                                                          onPressed:(){
                                                                                                                                      vcontroller.pause.value?vcontroller.pause.value=false
                                                                                                                                                             :vcontroller.pause.value=true;
                                                                                                                                      vcontroller.pause.value? videoPlayerController.play()
                                                                                                                                                             :videoPlayerController.pause();
                                                                                                                                  }
                                                                                                                                              ),
                                                                                                                               ),
                                                                                                                )

                                                                                                     )
                                                                                 :Container(height: 1,
                                                                                             width: 1,
                                                                                             color: Colors.blue,
                                                                                           ),
                                                                                vcontroller.viewchanger.value
                                                                                    ?Positioned(bottom: 10,
                                                                                                  left: 5,
                                                                                                 right: 5,
                                                                                                 child: Container(child: Column(children: [Row(children: [Obx(()=>
                                                                                                                                                          Text("${vcontroller.hour.value}:${vcontroller.minute.value}:${vcontroller.second.value}",
                                                                                                                                                               style: const TextStyle(color:Colors.white )
                                                                                                                                                               ),
                                                                                                                                                              ),
                                                                                                                                                          Expanded(child: Obx(()=> Slider(
                                                                                                                                                                                   value:vcontroller.slidervalue.value,
                                                                                                                                                                                     min:0,
                                                                                                                                                                                     max:videoPlayerController.value.duration.inSeconds.toDouble(),
                                                                                                                                                                             activeColor: Colors.white,
                                                                                                                                                                               onChanged: (v){
                                                                                                                                                                                 videoPlayerController.seekTo(Duration(seconds: v.toInt()));
                                                                                                                                                                                  }),
                                                                                                                                                          ),
                                                                                                                                                                  ),
                                                                                                                                                           Text("${videoPlayerController.value.duration.inHours}:"
                                                                                                                                                                "${videoPlayerController.value.duration.inMinutes}:"
                                                                                                                                                                "${videoPlayerController.value.duration.inSeconds.remainder(60)}",
                                                                                                                                                                style: const TextStyle(color:Colors.white )),
                                                                                                                                                           IconButton(icon: Obx(()=>
                                                                                                                                                                          Icon(vcontroller.speaker.value?CupertinoIcons.speaker_2
                                                                                                                                                                                                        :CupertinoIcons.speaker_slash,
                                                                                                                                                                               color: Colors.white,),
                                                                                                                                                                                 ),
                                                                                                                                                                  onPressed: (){
                                                                                                                                                                                 vcontroller.speaker.value?vcontroller.speaker.value=false
                                                                                                                                                                                                          :vcontroller.speaker.value=true;
                                                                                                                                                                                 videoPlayerController.value.volume!=0?{beforemuting=videoPlayerController.value.volume,
                                                                                                                                                                                                                        videoPlayerController.setVolume(0)
                                                                                                                                                                                                                       }
                                                                                                                                                                                                                      :videoPlayerController.setVolume(beforemuting);
                                                                                                                                                                                  },
                                                                                                                                                                    )
                                                                                                                                                          ],
                                                                                                                                          ),
                                                                                                                                          GestureDetector(child: const Column(children: [Icon(Icons.share,
                                                                                                                                                                         color: Colors.white,),
                                                                                                                                                                    Text("Share",
                                                                                                                                                                          style: TextStyle(color:Colors.white ),)],),
                                                                                                                                                        onTap: ()async{
                                                                                                                                                          var result =await methodchannel.invokeMethod("sharemedia",{"path":videofile});
                                                                                                                                                          print(result);
                                                                                                                                                        },
                                                                                                                                          )
                                                                                                                                          ],
                                                                                                                              ),
                                                                                                           )

                                                                                               ) :Container(height: 1,width: 1,color: Colors.blue,),


                                                   ],
                                      ),
                          ),
                         ),
      ),

                    ),


                  );
  }
}