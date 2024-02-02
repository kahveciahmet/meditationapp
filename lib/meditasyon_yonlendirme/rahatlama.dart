import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Rahatlama extends StatefulWidget {
  const Rahatlama({super.key});

  @override
  State<Rahatlama> createState() => _RahatlamaState();
}

class _RahatlamaState extends State<Rahatlama> {
  final videoURL = "https://www.youtube.com/watch?v=1Zr3SR0MTvY&ab_channel=MeditopiaTR";

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
    final websiteUri = Uri.parse("https://www.youtube.com/@MeditopiaTR");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rahatlama Meditasyonu"),
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
                "Rahatlama meditasyonu, zihinsel ve fiziksel gerginliği azaltmak, stresi hafifletmek ve içsel huzuru artırmak amacıyla yapılan bir meditasyon pratiğidir. Bu meditasyon türü, bireyin derin bir gevşeme durumuna geçmesine yardımcı olarak, günlük yaşamın getirdiği yoğunluğu atma ve zihinsel dinginlik elde etme amacını taşır.",
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
          const SizedBox(height: 10.0),
          Center(
            child: ElevatedButton(
                onPressed: () => setState(() {
                  launchUrl(
                    websiteUri,
                    mode: LaunchMode.externalApplication,
                  );
                }),
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(500, 70),
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
