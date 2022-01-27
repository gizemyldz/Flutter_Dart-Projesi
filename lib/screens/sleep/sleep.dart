import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audioplayers_web.dart';
import 'package:flutter/material.dart';
import 'package:meditation_app_ui/constants/constants.dart';
import 'package:meditation_app_ui/screens/sleep/components/custom_list_tile.dart';

class SleepApp extends StatefulWidget {
  @override
  _SleepAppState createState() => _SleepAppState();
}

class _SleepAppState extends State<SleepApp> {
  List musicList = [
    {
      'title': "Beautiful Dream",
      'singer': "Diego NAVA",
      'url':
          "https://assets.mixkit.co/music/preview/mixkit-beautiful-dream-493.mp3",
      'coverurl':
          "https://cdn.europosters.eu/image/750/art-photo/the-starry-night-june-1889-i67339.jpg"
    },
    {
      'title': "Serene View",
      'singer': "Arulo",
      'url':
          "https://assets.mixkit.co/music/preview/mixkit-serene-view-443.mp3",
      'coverurl':
          "https://i.pinimg.com/564x/98/e0/ec/98e0ece122d68b5b3c8a8c96fc8934e8.jpg"
    },
    {
      'title': "Dreaming Big",
      'singer': "Ahjay STELINO",
      'url':
          "https://assets.mixkit.co/music/preview/mixkit-dreaming-big-31.mp3",
      'coverurl':
          "https://i.pinimg.com/564x/98/e0/ec/98e0ece122d68b5b3c8a8c96fc8934e8.jpg"
    },
    {
      'title': "Silent Descent",
      'singer': "Eugenio MININNI",
      'url':
          "https://assets.mixkit.co/music/preview/mixkit-silent-descent-614.mp3",
      'coverurl':
          "https://i.pinimg.com/564x/98/e0/ec/98e0ece122d68b5b3c8a8c96fc8934e8.jpg"
    },
    {
      'title': "Sleepy Cat",
      'singer': "Alejandro MAGANA (A.M)",
      'url': "https://assets.mixkit.co/music/preview/mixkit-sleepy-cat-135.mp3",
      'coverurl':
          "https://i.pinimg.com/564x/98/e0/ec/98e0ece122d68b5b3c8a8c96fc8934e8.jpg"
    },
    {
      'title': "Dream",
      'singer': "Diego NAVA",
      'url':
          "https://assets.mixkit.co/music/preview/mixkit-beautiful-dream-493.mp3",
      'coverurl':
          "https://i.pinimg.com/564x/98/e0/ec/98e0ece122d68b5b3c8a8c96fc8934e8.jpg"
    },
  ];

  String currentTitle = "";
  String currentCover = "";
  String currentSinger = "";
  IconData btnIcon = Icons.play_arrow;

  //player oluşturma
  AudioPlayer audioPlayer = new AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
  bool isPlaying = false;
  String currentSong = "";

  //player çizgi
  Duration duration = new Duration();
  Duration position = new Duration();

  void playMusic(String url) async {
    if (isPlaying && currentSong != url) {
      audioPlayer.pause();
      int result = await audioPlayer.play(url);
      if (result == 1) {
        setState(() {
          currentSong = url;
        });
      }
    } else if (!isPlaying) {
      int result = await audioPlayer.play(url);
      if (result == 1) {
        setState(() {
          isPlaying = true;
          btnIcon = Icons.play_arrow;
        });
      }
    }
    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        duration = event;
      });
    });

    audioPlayer.onAudioPositionChanged.listen((event) {
      setState(() {
        position = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "UYKU LİSTESİ",
          style: TextStyle(color: Colors.purple.shade900),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: musicList.length,
                itemBuilder: (context, index) => customListTile(
                      onTap: () {
                        playMusic(musicList[index]['url']);
                        setState(() {
                          currentTitle = musicList[index]['title'];
                          currentCover = musicList[index]['coverurl'];
                          currentSinger = musicList[index]['singer'];
                        });
                      },
                      title: musicList[index]['title'],
                      singer: musicList[index]['singer'],
                      cover: musicList[index]['coverurl'],
                    )),
          ),
          Container(
            //padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Color(0x55212121),
                blurRadius: 8.0,
              ),
            ]),
            child: Column(
              children: [
                Slider.adaptive(
                  value: position.inSeconds.toDouble(),
                  min: 0.0,
                  max: duration.inSeconds.toDouble(), //şarkı slide
                  onChanged: (value) {},
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 80.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            image: DecorationImage(
                                image: NetworkImage(currentCover))),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentTitle,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              currentSinger,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          //durdur butonu
                          if (isPlaying) {
                            audioPlayer.pause();
                            setState(() {
                              btnIcon = Icons.pause;
                              isPlaying = false;
                            });
                          } else {
                            audioPlayer.resume();
                            setState(() {
                              btnIcon = Icons.play_arrow;
                              isPlaying = true;
                            });
                          }
                        },
                        iconSize: 42.0,
                        icon: Icon(btnIcon),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
