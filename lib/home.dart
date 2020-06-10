import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var frequencyValue = 0.0;
  var heading = 'Shoo Mosquito';
  IconData myFeedback = FontAwesomeIcons.sadTear;
  Color myFeedbackColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(heading),
        backgroundColor: Colors.blueAccent,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Container(
            child: CarouselSlider(
              items: imageSliders,
              options: CarouselOptions(
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                autoPlay: true,
                initialPage: 2,
              ),
            ),
          ),
          Container(
            child: FrequencySlider(),
          ),
        ],
      ),
    );
  }
}

final List<String> imgList = [
  'assets/images/mosquito.png',
  'assets/images/scared.jpg',
  'assets/images/happy.png',
];

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
              color: Colors.white,
              margin: EdgeInsets.all(30),
              child: ClipRRect(
                child: Stack(
                  children: <Widget>[
                    Image.asset(item),
                  ],
                ),
              )),
        ))
    .toList();

class FrequencySlider extends StatefulWidget {
  @override
  _FrequencySliderState createState() => _FrequencySliderState();
}

class _FrequencySliderState extends State<FrequencySlider> {
  var frequencyValue = 0.0;
  Duration _duration = Duration();
  Duration _position = Duration();
  AudioCache audioCache;
  AudioPlayer advancedPlayer;
  String localFilePath;

  Future loadMusic() async {
    advancedPlayer =
        await AudioCache().loop('sound/dengue-mosquito-repellent-22000.mp3');
  }

  stopFile() {
    advancedPlayer.stop(); // stop the file like this
  }

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  void initPlayer() {
    advancedPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: advancedPlayer);
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        child: Material(
            // color: Colors.redAccent,
            child: Container(
          child: Column(
            children: <Widget>[
              Text(
                '${frequencyValue}kHz',
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'ReemKufi',
                    color: Colors.blueAccent),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    child: Slider.adaptive(
                  min: 0,
                  max: 21,
                  divisions: 21,
                  value: frequencyValue,
                  onChanged: (newValue) {
                    setState(() {
                      frequencyValue = newValue;
                    });

                    if (newValue > 0) {
                      // loadMusic();
                      print(this.frequencyValue);
                    }
                    if (newValue == 0) {
                      // stopFile();
                      print(this.frequencyValue);
                    }
                  },
                )),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
