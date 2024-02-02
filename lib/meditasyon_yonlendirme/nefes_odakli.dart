import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Nefes_Odakli extends StatefulWidget {
  const Nefes_Odakli({super.key});

  @override
  State<Nefes_Odakli> createState() => _Nefes_OdakliState();
}

class _Nefes_OdakliState extends State<Nefes_Odakli> {
  final videoURL = "https://www.youtube.com/watch?v=2uDPo_A4b14&ab_channel=mistikyol";

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
        title: const Text("Nefes Odaklı Meditasyon"),
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
                "Nefes odaklı meditasyon, dikkati bilinçli bir şekilde nefese yoğunlaştırarak yapılan bir meditasyon pratiğidir. Bu meditasyon türü, derin bir bilinç hali yaratma, zihni sakinleştirme ve anın tadını çıkarma amacını taşır. Nefes odaklı meditasyon, yaygın olarak mindfulness (bilinçli farkındalık) meditasyonunun bir parçası olarak uygulanır.",
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
