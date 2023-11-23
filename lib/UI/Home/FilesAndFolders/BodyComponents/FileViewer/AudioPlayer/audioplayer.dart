



import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AudiooPlayer extends StatefulWidget{
String audiofile;
AudiooPlayer(this.audiofile);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState;
    return AudiooPlayerState(audiofile);
  }
}
class AudiooPlayerState extends State<AudiooPlayer>{
  String audiofile;
  double int =0;

  AudiooPlayerState(this.audiofile);
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(onWillPop: ()async{
      await audioPlayer.release();
      return true;
    },
      child: Scaffold(appBar: AppBar(),
      body: Container(height: MediaQuery.of(context).size.height/1.12,color:Colors.pinkAccent,
                      width: MediaQuery.of(context).size.width,
      child: Column(mainAxisAlignment:MainAxisAlignment.end,
                   children: [Slider(value: int, onChanged: (valuee){setState(() {
                     int =valuee;
                   });}),
                         Row(mainAxisAlignment:MainAxisAlignment.center,
                                       children: [IconButton(onPressed: ()async{


                                          if(audioPlayer.state==PlayerState.playing){

                                              await  audioPlayer.pause();

                                          }
                                          else{

                                               audioPlayer.play(DeviceFileSource(audiofile));

                                          }
                                       },
                                                                 icon: Icon(CupertinoIcons.play_arrow_solid))],)],),),),
    );
  }
}