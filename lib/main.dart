import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MusicApp(),
    );
  }
}


class MusicApp extends StatefulWidget {
  @override
  _MusicAppState createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {

  bool playing = false;
  IconData playBtn = Icons.play_arrow;

  AudioPlayer _player;
  AudioCache cache;

  Duration position = new Duration();
  Duration musicLength = new Duration();

  Widget slider(){
    return Slider.adaptive(value: position.inSeconds.toDouble(),
         max: musicLength.inSeconds.toDouble(),
        activeColor: Colors.blue[800],
        inactiveColor: Colors.grey[350],
        onChanged:(value){
        seekToSec(value.toInt());
        }
    );
  }

  void seekToSec(int sec){
     Duration newpos = Duration(seconds: sec);
     _player.seek(newpos);
  }

  @override
  void initState() {

    super.initState();
    _player = AudioPlayer();
    cache = AudioCache(fixedPlayer: _player);

    _player.durationHandler = (d){
      setState(() {
        musicLength = d;
      });
    };
    _player.positionHandler = (p){
      setState(() {
        position = p;
      });
    };

    cache.load("Stargazer.mp3");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue[800],
              Colors.blue[200],
            ]
          )
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 48.0),
          child: Container(
            child: Column(
               mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                child:Text('Music Beats',style: TextStyle(color: Colors.white,fontSize: 38.0,fontWeight: FontWeight.bold),),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child:Text('Listen to your favourite Music',style: TextStyle(color: Colors.white,fontSize: 24.0,fontWeight: FontWeight.w400),),
                ),


                SizedBox(height: 24.0),
                Center(
                  child: Container(
                    width: 280.0,
                    height: 280.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      image: DecorationImage(
                        image: AssetImage('images/i1.jpg'),
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                ),
                SizedBox(height: 18.0),
                Center(
                   child: Text('Ho_Enna',style: TextStyle(color: Colors.white,fontSize: 32.0,fontWeight: FontWeight.w600),)
                ),
                SizedBox(height: 30.0,),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft:Radius.circular(30.0),topRight: Radius.circular(30.0))
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 500.0,
                          child: Row(

                            children: [
                              Text("${position.inMinutes}:${position.inSeconds.remainder(60)}"),
                              slider(),
                              Text("${musicLength.inMinutes}:${musicLength.inSeconds.remainder(60)}"),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                          ),
                        ),


                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            iconSize:45.0,
                            color: Colors.blue,
                            icon: Icon(Icons.skip_previous),
                            onPressed: () {},
                          ),

                          IconButton(
                            iconSize:62.0,
                            color: Colors.blue[800],
                            icon: Icon(playBtn),
                            onPressed: () {
                              if(!playing){
                                cache.play("Ho_Enna.mp3");
                                setState(() {
                                  playBtn = Icons.pause;
                                  playing = true;
                                });
                              }
                              else
                                {
                                  _player.pause();
                                setState(() {
                                  playBtn = Icons.play_arrow;
                                  playing = false;
                                });
                              }
                            },
                          ),

                          IconButton(
                            iconSize:45.0,
                            color: Colors.blue,
                            icon: Icon(Icons.skip_next),
                            onPressed: () {},
                          )
                        ],
                    )
                      ],
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
