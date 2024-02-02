import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:url_launcher/url_launcher.dart';



class SevgiveIyilik extends StatefulWidget {
  const SevgiveIyilik({super.key});

  @override
  State<SevgiveIyilik> createState() => _SevgiveIyilikState();
}

class _SevgiveIyilikState extends State<SevgiveIyilik> {
  final videoURL = "https://www.youtube.com/watch?v=dlMaGmGczg0&ab_channel=Se%C3%A7ilG%C3%B6ren";

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
    final websiteUri = Uri.parse("https://www.youtube.com/@SecilGoren");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sevgi ve İyilik Meditasyonu"),
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
                "Sevgi ve İyilik Meditasyonu, zihinsel ve duygusal dengeyi güçlendirmeye odaklanan bir meditasyon pratiğidir. Bu meditasyon, içsel huzur, sevgi ve olumlu enerjiyi artırmayı amaçlar. Meditasyon sürecinde, derin nefes alarak bedeni rahatlatma ve zihni sakinleştirme üzerine odaklanılır.",
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
