import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SinirYonetimi extends StatefulWidget {
  const SinirYonetimi({super.key});

  @override
  State<SinirYonetimi> createState() => _SinirYonetimiState();
}

class _SinirYonetimiState extends State<SinirYonetimi> {
  final videoURL = "https://www.youtube.com/watch?v=tcnT1_C-WeE&ab_channel=mistikyol";

  late YoutubePlayerController _controller;

  @override
  void initState(){
    final videoID = YoutubePlayer.convertUrlToId(videoURL);

    _controller = YoutubePlayerController(
        initialVideoId: videoID!,
        flags: const YoutubePlayerFlags(
          autoPlay: false,

        )
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final websiteUri = Uri.parse("https://www.youtube.com/@mistikyol");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sinir ve Yönetim Meditasyonu"),
        backgroundColor: Colors.blue[900],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YoutubePlayer(controller: _controller,
            showVideoProgressIndicator: true,
          ),
          const SizedBox(height: 15.0,),
          Container(
            color: Colors.blue[900], // Arkaplan rengi
            padding: const EdgeInsets.all(50.0),
            child: const Align(
              alignment: Alignment.center,
              child: Text(
                "Sinir yönetimi meditasyonu, bireylerin stres, endişe ve duygusal gerginlikle başa çıkabilmeleri için kullanılan bir meditasyon türüdür. Bu meditasyon, bireyin içsel huzurunu artırmayı, duygusal dengeyi sağlamayı ve stresle daha etkili bir şekilde başa çıkabilmeyi hedefler.",
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: <Shadow>[
                    Shadow(
                      blurRadius: 5.0,
                      color: Colors.black,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 35.0),
          Center(
            child: ElevatedButton(
                onPressed: () => setState(() {
                  launchUrl(
                    websiteUri,
                    mode: LaunchMode.externalApplication,
                  );
                }),
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(500, 80),
                  elevation: 10.0,
                  side: const BorderSide(color: Colors.blueAccent, width: 5.0),
                ),
                child: const Text("Bu kanaldan daha fazlası için tıklayın!",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.blue,
                    shadows: <Shadow>[
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.blueAccent,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }
}
